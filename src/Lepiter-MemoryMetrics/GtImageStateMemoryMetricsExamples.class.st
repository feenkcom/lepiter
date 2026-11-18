"
I check {{gtClass:GtImageStateMemoryMetrics}}: its definition, without estimating the whole image, and its report, computed with a small definition.
"
Class {
	#name : #GtImageStateMemoryMetricsExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-MemoryMetrics'
}

{ #category : #private }
GtImageStateMemoryMetricsExamples >> assertViewsOf: anObject [
	| aCheck |
	aCheck := GtMemorySpaceViewsCheck forObject: anObject.
	self assert: aCheck hasErrors not description: [ aCheck errorsDescription ].
	^ aCheck
]

{ #category : #examples }
GtImageStateMemoryMetricsExamples >> imageStateBeforeComputing [
	<gtExample>
	<return: #GtImageStateMemoryMetrics>
	| aMetrics |
	aMetrics := GtImageStateMemoryMetrics new.
	self assert: aMetrics stateSize equals: 0.
	self assertViewsOf: aMetrics.
	^ aMetrics
]

{ #category : #examples }
GtImageStateMemoryMetricsExamples >> imageStateDefinition [
	"The groups of roots of the state of the image, in the order in which they are estimated"

	<gtExample>
	<return: #GtMemorySpaceRootsDefinition>
	| aDefinition aBoundary |
	aDefinition := GtImageStateMemoryMetrics newDefinition.

	self
		assert: (aDefinition rootGroups collect: [ :each | each label ]) asArray
		equals: #('Lepiter GT Book' 'Code index' 'Other Lepiter databases' 'Class-side state' 'Globals').
	self
		assert: (aDefinition rootGroups first attribution
				isKindOf: GtMemorySpaceSlotsAttribution).
	aBoundary := aDefinition boundary.
	self assert: (aBoundary shouldStopAtClass: CompiledMethod).
	self assert: (aBoundary shouldStopAtClass: LeLogicalDatabase).
	self assert: (aBoundary shouldStopAtClass: LeDatabase).
	self assert: (aBoundary shouldStopAtClass: LePage).
	self deny: (aBoundary shouldStopAtClass: Process).
	self deny: (aBoundary shouldStopAtClass: Context).
	self assert: (aBoundary tagForClass: Bitmap) name equals: #bitmap.
	self assert: (aBoundary tagForClass: FullBlockClosure) name equals: #block.
	self assertViewsOf: aDefinition.
	^ aDefinition
]

{ #category : #examples }
GtImageStateMemoryMetricsExamples >> imageStateFocusedOnAGroup [
	"A focus group is estimated first, and stops at the shared hubs of the image, 
	so that it gets its own objects and not the whole image"

	<gtExample>
	<return: #GtMemorySpaceRootsDefinition>
	| aGroup aMetrics aDefinition |
	aGroup := GtMemorySpaceRootGroup
			label: 'Focus'
			roots: {Array with: 'focused' copy}.
	aMetrics := GtImageStateMemoryMetrics new
			focusOn: aGroup;
			yourself.
	aDefinition := aMetrics definition.

	self assert: aDefinition rootGroups first identicalTo: aGroup.
	self assert: aDefinition rootGroups second label equals: 'Lepiter GT Book'.
	self
		assert: (GtImageStateMemoryMetrics sharedHubClasses
				allSatisfy: [ :each | aGroup extraStopClasses includes: each ]).
	self deny: (aDefinition boundary shouldStopAtClass: Process).
	self
		assert: ((aGroup boundaryWithin: aDefinition boundary) shouldStopAtClass: Process).	"defining again does not add the hubs twice"
	aMetrics focusOn: (GtMemorySpaceRootGroup label: 'Second focus' roots: #()).
	aMetrics definition.
	self
		assert: aGroup extraStopClasses size
		equals: GtImageStateMemoryMetrics sharedHubClasses size.
	^ aDefinition
]

{ #category : #examples }
GtImageStateMemoryMetricsExamples >> imageStateOfASmallDefinition [
	"The report, computed with a small definition and a given size of the code entities"

	<gtExample>
	<return: #GtImageStateMemoryMetrics>
	| held aDefinition aMetrics |
	held := Array with: 'held' copy with: 'objects' copy.
	aDefinition := GtMemorySpaceRootsDefinition new
			roots: 'Example roots' are: {held};
			yourself.
	aMetrics := GtImageStateMemoryMetrics new
			definition: aDefinition;
			codeEntitiesSize: 0;
			compute;
			yourself.

	self
		assert: aMetrics stateSize
		equals: held sizeInMemory
				+ (held inject: 0 into: [ :aSum :each | aSum + each sizeInMemory ]).
	self assert: aMetrics imageSizeInMemory > aMetrics stateSize.
	self assert: aMetrics imageFileSize > 0.
	self
		assert: aMetrics notReachedSize
		equals: aMetrics imageSizeInMemory - aMetrics stateSize.
	self assert: aMetrics estimate rootGroupEstimates size equals: 1.
	self assert: aMetrics summaryItems size equals: 6.
	self assertViewsOf: aMetrics.
	^ aMetrics
]

{ #category : #examples }
GtImageStateMemoryMetricsExamples >> lepiterRootsOfADatabase [
	"A Lepiter database is estimated from its own pages and snippets, which the walk does not follow"

	<gtExample>
	<return: #GtMemorySpaceEstimate>
	| aDatabase aPage aDefinition anEstimate |
	aDatabase := LeDatabase new.
	aPage := LePage named: 'Memory roots page'.
	aPage addSnippet: (LeTextSnippet string: 'Some text').
	aDatabase addPage: aPage.
	aDefinition := GtMemorySpaceRootsDefinition new
			stopAtInstancesOf: {LeDatabase.
					LeContent};
			yourself.
	(aDefinition
		roots: 'Database'
		are: (GtImageStateMemoryMetrics lepiterRootsOf: aDatabase))
		attribution: (GtImageStateMemoryMetrics lepiterAttributionIn: aDefinition named: 'Database').

	anEstimate := aDefinition estimate estimate.

	self
		assert: (anEstimate rootEstimates collect: [ :each | each root object ]) asArray
		equals: {aDatabase.
				aPage.
				aPage children first}.
	self
		assert: (anEstimate rootEstimates
				allSatisfy: [ :each | each category = (aDefinition categoryNamed: 'Database') ]).
	self assert: anEstimate totalBytes > 0.
	self
		assert: anEstimate totalBytes
		equals: (anEstimate bytesOf: (aDefinition categoryNamed: 'Database')).
	^ anEstimate
]
