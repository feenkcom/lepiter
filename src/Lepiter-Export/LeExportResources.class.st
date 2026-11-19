Class {
	#name : #LeExportResources,
	#superclass : #Object,
	#traits : 'TLeExportResources',
	#classTraits : 'TLeExportResources classTrait',
	#instVars : [
		'resources'
	],
	#category : #'Lepiter-Export-Resources - Model'
}

{ #category : #'add / remove' }
LeExportResources >> addResource: aResource [
	resources add: aResource
]

{ #category : #converting }
LeExportResources >> asArray [
	^ resources asArray
]

{ #category : #enumerating }
LeExportResources >> assembledResources [
	| assembled |
	assembled := resources select: [ :each | each state isAssembledState ].
	assembled sort: [ :a :b | a state duration > b state duration ].
	^ assembled
]

{ #category : #accessing }
LeExportResources >> averageDurationOf: aCollection [
	"Average recorded assembled durations. Answer nil when no duration is available."

	| assembled |
	assembled := aCollection
			select: [ :resource | resource state isAssembledState ].
	assembled ifEmpty: [ ^ nil ].
	^ (self totalDurationOf: assembled) / assembled size
]

{ #category : #enumerating }
LeExportResources >> collect: aBlock [
	^ resources collect: aBlock as: Array
]

{ #category : #enumerating }
LeExportResources >> do: aBlock [
	resources do: aBlock
]

{ #category : #accessing }
LeExportResources >> durationBinsEvery: aDuration [
	"Answer contiguous half-open duration bins as start-seconds -> resources.
	Include empty bins so the histogram preserves distances along its duration axis."

	| assembled width bins maximumIndex |
	self assert: aDuration > 0 seconds.
	assembled := self assembledResources.
	assembled ifEmpty: [ ^ #() ].
	width := aDuration asSeconds.
	maximumIndex := (assembled first state duration asSeconds / width) floor.
	bins := (0 to: maximumIndex)
			collect: [ :index | index * width -> OrderedCollection new ].
	assembled
		do: [ :each | (bins at: (each state duration asSeconds / width) floor + 1) value add: each ].
	^ bins
]

{ #category : #'gt - extensions' }
LeExportResources >> durationHistogram [
	"Build a five-second histogram: duration on x, assembled resource count on y."

	| bins data chart maximum |
	bins := self durationBinsEvery: 5 seconds.	"Plotter needs at least one bin, even when there are no assembled resources."
	bins ifEmpty: [ bins := {0 -> #()} ].
	maximum := bins inject: 1 into: [ :max :bin | max max: bin value size ].
	data := GtPlotterDataGroup new values: bins.
	data := data
			labelled: [ :bin | bin key asString , '–' , (bin key + 5) asString ].
	data := data background: [ :bin | Color blue alpha: 0.5 ].
	chart := GtPlotterVerticalBarChart new.
	chart barHeightScale: (GtPlotterLinearScale new domainFrom: 0 to: maximum).
	chart barHeightData: [ :bin | bin value size ].
	chart barWidthScale constant: 25.
	chart amountOfTicks: (maximum min: 5).
	chart diagonalTicks.
	chart scalableContents.
	chart
		barElement: [ :context | 
			| bin |
			bin := context originalValue.
			BlElement new
				aptitude: (BrGlamorousWithExplicitTooltipAptitude
						text: bin key asString , ' to < ' , (bin key + 5) asString , ' seconds: '
								, bin value size asString , ' resources') ].
	chart with: data.
	^ chart
]

{ #category : #enumerating }
LeExportResources >> failedResources [
	^ resources select: [ :each | each state isFailure ].
]

{ #category : #'gt - extensions' }
LeExportResources >> gtAssembledResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Assembled';
		priority: 20;
		items: [ self assembledResources ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Duration'
			text: [ :aResource | aResource state duration gtShortPrintString ]
			width: 70;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #'gt - extensions' }
LeExportResources >> gtDurationDistributionFor: aView [
	"How are assembled resource export durations distributed?
	X is duration in five-second intervals [start, end); Y is resource count.
	Resources without an assembled duration are excluded."

	<gtView>
	^ aView explicit
		title: 'Duration distribution';
		priority: 21;
		stencil: [ BrVerticalPane new
				matchParent;
				padding: (BlInsets all: 20);
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: 'Number of assembled resources');
				addChild: self durationHistogram asElement;
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: 'Export duration (seconds; 5-second bins)') ]
]

{ #category : #'gt - extensions' }
LeExportResources >> gtFailedResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Failures';
		priority: 15;
		items: [ self failedResources ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #'gt - extensions' }
LeExportResources >> gtInfoFor: aView [
	"How many resources were assembled, how are they distributed across disjoint
	duration ranges, and what are their maximum, total and average durations?
	Ranges include the lower bound and exclude the upper bound.
	Average durations exclude resources without an assembled duration.
	Select a row to inspect its matching resources."

	<gtView>
	^ aView columnedList
		title: 'Info';
		priority: 0;
		items: [ self infoRows ];
		column: 'Resources' text: #first;
		column: 'Count'
			text: [ :row | row second size ]
			width: 80;
		column: 'Maximum duration'
			text: [ :row | row third ifNil: [ '—' ] ifNotNil: [ :duration | duration gtShortPrintString ] ];
		column: 'Average duration'
			text: [ :row | 
				(self averageDurationOf: row second)
					ifNil: [ '—' ]
					ifNotNil: [ :duration | duration gtShortPrintString ] ];
		column: 'Total duration'
			text: [ :row | (self totalDurationOf: row second) gtShortPrintString ];
		send: [ :row | 
			| matching |
			matching := self class new.
			row second do: [ :each | matching addResource: each ].
			matching ]
]

{ #category : #'gt - extensions' }
LeExportResources >> gtResourcesFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Resources';
		priority: 1;
		items: [ resources ifNil: [ #() ] ];
		column: 'Index'
			text: [ :_ :anIndex | anIndex ]
			width: 60;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ]
]

{ #category : #'gt - extensions' }
LeExportResources >> gtResourcesGroupedBySourceTypeFor: aView [
	<gtView>
	resources ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Resources by types';
		priority: 9;
		items: [ LeExportGroupedResource 
			resources: self 
			groupedBy: #sourceType ];
		children: #children;
		column: 'Source' text: [ :aResource | aResource source ];
		column: 'Path' text: [ :aResource | aResource pathName ];
		column: 'State' text: [ :aResource | aResource state label ];
		send: #object
]

{ #category : #accessing }
LeExportResources >> infoRows [
	"Summarize assembled resources in disjoint ranges [lower, upper), plus
	non-assembled resources. A nil maximum means no assembled duration is available."

	| assembled rows lower matching |
	assembled := self assembledResources.
	rows := OrderedCollection new.
	rows
		add: {'Not assembled (skipped) resources'.
				resources select: [ :each | each state isAssembledState not ].
				nil}.
	rows
		add: {'Assembled resources'.
				assembled.
				assembled ifEmpty: [ nil ] ifNotEmpty: [ assembled first state duration ]}.
	lower := 0 seconds.
	{'Exports < 5 seconds' -> 5 seconds.
		'Exports 5–<10 seconds' -> 10 seconds.
		'Exports 10–<15 seconds' -> 15 seconds.
		'Exports 15–<30 seconds' -> 30 seconds.
		'Exports 30 seconds–<1 minute' -> 1 minute.
		'Exports 1–<2 minutes' -> 2 minutes}
		do: [ :threshold | 
			matching := assembled
					select: [ :each | each state duration >= lower and: [ each state duration < threshold value ] ].
			rows
				add: {threshold key.
						matching.
						matching ifEmpty: [ nil ] ifNotEmpty: [ matching first state duration ]}.
			lower := threshold value ].
	matching := assembled select: [ :each | each state duration >= lower ].
	rows
		add: {'Exports ≥ 2 minutes'.
				matching.
				matching ifEmpty: [ nil ] ifNotEmpty: [ matching first state duration ]}.
	^ rows
]

{ #category : #accessing }
LeExportResources >> initialize [
	super initialize.
	resources := OrderedCollection new
]

{ #category : #printing }
LeExportResources >> printOn: aStream [
	super printOn: aStream.

	resources ifNil: [ ^ self ].

	aStream
		space;
		nextPut: $[;
		print: self size;
		nextPutAll: (' item' asPluralBasedOn: self size);
		nextPut: $]
]

{ #category : #enumerating }
LeExportResources >> select: aBlock [
	^ resources select: aBlock
]

{ #category : #accessing }
LeExportResources >> size [
	^ resources size
]

{ #category : #accessing }
LeExportResources >> totalDurationOf: aCollection [
	"Sum recorded assembled durations only. Non-assembled resources have no duration."

	^ aCollection
		inject: 0 seconds
		into: [ :total :resource | 
			resource state isAssembledState
				ifTrue: [ total + resource state duration ]
				ifFalse: [ total ] ]
]
