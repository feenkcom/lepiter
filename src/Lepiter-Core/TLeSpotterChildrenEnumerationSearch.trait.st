Trait {
	#name : #TLeSpotterChildrenEnumerationSearch,
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'api - enumerating' }
TLeSpotterChildrenEnumerationSearch >> allChildrenBreadthFirstDo: aBlock [ 
	self childrenDo: aBlock.
	self childrenDo: [ :each | each allChildrenBreadthFirstDo: aBlock ]
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
