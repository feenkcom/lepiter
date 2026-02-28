Class {
	#name : #LeFileReferenceAnnotationNode,
	#superclass : #LeFileReferenceParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferenceAnnotationNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferenceAnnotation: self
]

{ #category : #generated }
LeFileReferenceAnnotationNode >> bars [
	^ bars
]

{ #category : #generated }
LeFileReferenceAnnotationNode >> bars: anOrderedCollection [
	bars := anOrderedCollection
]

{ #category : #generated }
LeFileReferenceAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
LeFileReferenceAnnotationNode >> compositeTokenVariables [
	^ #(#bars)
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> expandedArgument [
	^ self items
		ifNil: [ nil ]
		ifNotNil: [ :itemList | itemList detect: [ :each | each isKindOf: LeFileReferenceExpandedNode ] ifNone: [ nil ] ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> expandedValue [
	| argument raw |
	argument := self expandedArgument.
	argument ifNil: [ ^ nil ].
	raw := argument valueString.
	raw ifNil: [ ^ true ].
	^ raw = 'true'
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> heightArgument [
	^ self items
		ifNil: [ nil ]
		ifNotNil: [ :itemList | itemList detect: [ :each | each isKindOf: LeFileReferenceHeightNode ] ifNone: [ nil ] ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> heightValue [
	| argument |
	argument := self heightArgument.
	^ argument ifNil: [ nil ] ifNotNil: [ :heightNode | heightNode value ifNil: [ nil ] ifNotNil: [ :token | token value asInteger ] ]
]

{ #category : #'generated-initialize-release' }
LeFileReferenceAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #generated }
LeFileReferenceAnnotationNode >> items [
	^ items
]

{ #category : #generated }
LeFileReferenceAnnotationNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> labelArgument [
	^ items detect: [ :each | each isKindOf: LeFileReferenceLabelNode ] ifNone: [  ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> labelString [
	^ self labelArgument ifNil: [ nil ] ifNotNil: [ :arg | arg normalizedValue ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> pathArgument [
	^ items detect: [ :each | each isKindOf: LeFileReferencePathNode ] ifNone: [  ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> pathString [
	^ self pathArgument ifNil: [ nil ] ifNotNil: [ :arg | arg normalizedValue ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> rangeArgument [
	^ self items
		ifNil: [ nil ]
		ifNotNil: [ :itemList | itemList detect: [ :each | each isKindOf: LeFileReferenceRangeNode ] ifNone: [ nil ] ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> rangeEnd [
	^ self rangeArgument
		ifNil: [ nil ]
		ifNotNil: [ :argument | argument endInteger ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> rangeStart [
	^ self rangeArgument
		ifNil: [ nil ]
		ifNotNil: [ :argument | argument startInteger ]
]

{ #category : #accessing }
LeFileReferenceAnnotationNode >> rangeValue [
	^ self rangeArgument
]
