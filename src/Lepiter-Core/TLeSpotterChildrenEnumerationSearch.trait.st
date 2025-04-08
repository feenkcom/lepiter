Trait {
	#name : #TLeSpotterChildrenEnumerationSearch,
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'api - enumerating' }
TLeSpotterChildrenEnumerationSearch >> allChildrenBreadthFirstDo: aBlock [
	| queue |
	queue := LinkedList withAll: self children.
	[ queue notEmpty ]
		whileTrue: [ | child |
			child := queue removeFirst.
			aBlock value: child.
			queue addAll: child children ]
]

{ #category : #'api - enumerating' }
TLeSpotterChildrenEnumerationSearch >> allChildrenDepthFirstDo: aBlock [ 
	self childrenDo: [ :each | each allChildrenDepthFirstDo: aBlock ].
	self childrenDo: aBlock.
]

{ #category : #'api - accessing' }
TLeSpotterChildrenEnumerationSearch >> children [
	<return: #Collection of: #LeContent>
	^ self explicitRequirement
]

{ #category : #'api - enumerating' }
TLeSpotterChildrenEnumerationSearch >> childrenDo: aBlock [
	self children do: aBlock
]

{ #category : #'api - testing' }
TLeSpotterChildrenEnumerationSearch >> hasChildren [
	<return: #Boolean>
	^ self explicitRequirement
]

{ #category : #'api - enumerating' }
TLeSpotterChildrenEnumerationSearch >> withAllChildrenBreadthFirstDo: aBlock [ 
	aBlock value: self.
	self allChildrenBreadthFirstDo: aBlock
]

{ #category : #'api - enumerating' }
TLeSpotterChildrenEnumerationSearch >> withAllChildrenDepthFirstDo: aBlock [ 
	aBlock value: self.
	self allChildrenDepthFirstDo: aBlock
]
