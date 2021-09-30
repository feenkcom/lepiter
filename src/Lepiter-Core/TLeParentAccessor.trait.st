Trait {
	#name : #TLeParentAccessor,
	#instVars : [
		'parent'
	],
	#category : 'Lepiter-Core-Utility'
}

{ #category : #'private - asserting' }
TLeParentAccessor >> assertParent: aParent [
	self 
		assert: [ aParent isNotNil ]
		description: [ 'Parent must be non-nil' ].
]

{ #category : #'private - hooks' }
TLeParentAccessor >> onParentChanged [
	"Objects can react to database changes"
]

{ #category : #'api - accessing' }
TLeParentAccessor >> parent [
	^ parent ifNil: [ self ]
]

{ #category : #'api - accessing' }
TLeParentAccessor >> parent: aParent [
	self assertParent: aParent.
	parent := aParent.
	self onParentChanged.
]
