"
Examples for export resource duration summaries and their inspector navigation.
"
Class {
	#name : #LeExportResourcesExamples,
	#superclass : #Object,
	#category : #'Lepiter-Export-Resources - Examples'
}

{ #category : #examples }
LeExportResourcesExamples >> durationBins [
	<gtExample>
	| resources bins |
	resources := LeExportResources new.
	#(0 4 5 9 10 21)
		do: [ :seconds | 
			resources
				addResource: (LeExportSnippetResource new
						state: (LeExportAssembledResourceState new duration: seconds seconds)) ].
	resources
		addResource: (LeExportSnippetResource new state: LeExportReadyResourceState default).
	bins := resources durationBinsEvery: 5 seconds.
	self assert: (bins collect: #key) asArray equals: #(0 5 10 15 20).
	self
		assert: (bins collect: [ :bin | bin value size ]) asArray
		equals: #(2 2 1 0 1).
	bins
		do: [ :bin | 
			bin value
				do: [ :resource | 
					self assert: resource state duration >= bin key seconds.
					self assert: resource state duration < (bin key + 5) seconds ] ].
	self assert: (resources durationBinsEvery: 10 seconds) size equals: 3.
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> durationHistogram [
	<gtExample>
	| element |
	element := self durationBins durationHistogram asElement.
	self assert: element notNil.
	^ element
]

{ #category : #examples }
LeExportResourcesExamples >> durationSummary [
	<gtExample>
	| resources rows members skipped |
	resources := LeExportResources new.
	#(0 4 5 9 10 14 15 29 30 59 60 119 120 121 180)
		do: [ :seconds | 
			resources
				addResource: (LeExportSnippetResource new
						state: (LeExportAssembledResourceState new duration: seconds seconds)) ].
	resources
		addResource: (LeExportSnippetResource new state: LeExportReadyResourceState default).
	self assert: resources infoRows size equals: 9.
	rows := resources infoRows reject: [ :row | row third isNil ].
	self
		assert: (rows collect: [ :row | row second size ]) asArray
		equals: #(15 2 2 2 2 2 2 3).
	self
		assert: (rows collect: [ :row | row third asSeconds ]) asArray
		equals: #(180 4 9 14 29 59 119 180).
	rows
		do: [ :row | 
			self assert: row second first state duration equals: row third.
			self assert: (row second allSatisfy: [ :each | each state isAssembledState ]) ].
	skipped := resources infoRows detect: [ :row | row third isNil ].
	self assert: skipped second size equals: 1.
	self
		assert: (skipped second allSatisfy: [ :each | each state isAssembledState not ]).
	members := rows allButFirst flatCollect: #second.
	self assert: members size equals: resources assembledResources size.
	self assert: members asSet size equals: members size.
	self assert: members asSet equals: resources assembledResources asSet.
	self
		assert: rows first second size + skipped second size
		equals: resources size.
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> durationSummaryWithoutSlowExports [
	<gtExample>
	| resources |
	resources := LeExportResources new.
	resources
		addResource: (LeExportSnippetResource new
				state: (LeExportAssembledResourceState new duration: 15 seconds)).
	resources
		addResource: (LeExportSnippetResource new state: LeExportReadyResourceState default).
	resources infoRows
		do: [ :row | 
			(#('Assembled resources' 'Exports 15–<30 seconds') includes: row first)
				ifTrue: [ self assert: row second size equals: 1.
					self assert: row third equals: 15 seconds ]
				ifFalse: [ self assert: row third isNil.
					self
						assert: (row second allSatisfy: [ :each | each state isAssembledState not ]) ] ].
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> emptyDurationHistogram [
	<gtExample>
	| resources element |
	resources := self emptyDurationSummary.
	self assert: (resources durationBinsEvery: 5 seconds) isEmpty.
	element := resources durationHistogram asElement.
	self assert: element notNil.
	^ element
]

{ #category : #examples }
LeExportResourcesExamples >> emptyDurationSummary [
	<gtExample>
	| resources |
	resources := LeExportResources new.
	resources infoRows
		do: [ :row | 
			self assert: row second isEmpty.
			self assert: row third isNil ].
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> infoAverageDurations [
	<gtExample>
	| resources rows |
	resources := self durationSummary.
	rows := resources infoRows reject: [ :row | row third isNil ].
	rows
		do: [ :row | 
			self
				assert: (resources averageDurationOf: row second)
				equals: (resources totalDurationOf: row second) / row second size ].
	self
		assert: (resources averageDurationOf: rows second second)
		equals: 2 seconds.
	self
		assert: (resources averageDurationOf: resources asArray)
		equals: (resources averageDurationOf: resources assembledResources).
	(resources infoRows select: [ :row | row third isNil ])
		do: [ :row | self assert: (resources averageDurationOf: row second) isNil ].
	self emptyDurationSummary infoRows
		do: [ :row | self assert: (resources averageDurationOf: row second) isNil ].
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> infoRowNavigation [
	<gtExample>
	| resources view |
	resources := self durationSummary.
	view := resources gtInfoFor: GtPhlowView empty.
	resources infoRows
		do: [ :row | 
			| selected |
			selected := view transformation transformedValueFrom: row selection: #().
			self assert: selected class equals: LeExportResources.
			self assert: selected asArray equals: row second asArray ].
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> infoTotalDurations [
	<gtExample>
	| resources rows totals |
	resources := self durationSummary.
	rows := resources infoRows reject: [ :row | row third isNil ].
	totals := rows collect: [ :row | resources totalDurationOf: row second ].
	self
		assert: (totals collect: #asSeconds) asArray
		equals: #(775 4 14 24 44 89 179 421).
	self
		assert: (totals allButFirst inject: 0 seconds into: [ :sum :duration | sum + duration ])
		equals: totals first.
	(resources infoRows select: [ :row | row third isNil ])
		do: [ :row | self assert: (resources totalDurationOf: row second) equals: 0 seconds ].
	self emptyDurationSummary infoRows
		do: [ :row | self assert: (resources totalDurationOf: row second) equals: 0 seconds ].
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> onlySkippedResources [
	<gtExample>
	| resources skipped view selected |
	resources := LeExportResources new.
	resources
		addResource: (LeExportSnippetResource new state: LeExportReadyResourceState default).
	resources
		addResource: (LeExportSnippetResource new state: LeExportOptionalResourceState default).
	skipped := resources infoRows detect: [ :row | row second notEmpty ].
	self assert: skipped second size equals: resources size.
	self assert: skipped third isNil.
	self assert: (resources totalDurationOf: skipped second) equals: 0 seconds.
	self
		assert: (resources infoRows detect: [ :row | row first = 'Assembled resources' ]) second
				isEmpty.
	view := resources gtInfoFor: GtPhlowView empty.
	selected := view transformation transformedValueFrom: skipped selection: #().
	self assert: selected asArray equals: resources asArray.
	^ resources
]

{ #category : #examples }
LeExportResourcesExamples >> zeroAndFractionalAverageDurations [
	<gtExample>
	| resources |
	resources := LeExportResources new.
	resources
		addResource: (LeExportSnippetResource new
				state: (LeExportAssembledResourceState new duration: 0 seconds)).
	self assert: (resources averageDurationOf: resources asArray) equals: 0 seconds.
	resources
		addResource: (LeExportSnippetResource new
				state: (LeExportAssembledResourceState new duration: 1 second)).
	self
		assert: (resources averageDurationOf: resources asArray)
		equals: 500 milliseconds.
	^ resources
]
