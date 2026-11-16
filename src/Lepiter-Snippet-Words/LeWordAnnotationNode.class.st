Class {
	#name : #LeWordAnnotationNode,
	#superclass : #LeWordParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #generated }
LeWordAnnotationNode >> acceptVisitor: aWordParseVisitor [
	^ aWordParseVisitor visitWordAnnotation: self
]

{ #category : #generated }
LeWordAnnotationNode >> bars [
	^ bars
]

{ #category : #generated }
LeWordAnnotationNode >> bars: anOrderedCollection [
	bars := anOrderedCollection
]

{ #category : #generated }
LeWordAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
LeWordAnnotationNode >> compositeTokenVariables [
	^ #(#bars)
]

{ #category : #accessing }
LeWordAnnotationNode >> expandedValueNode [
	^ items detect: [ :each | each isKindOf: LeWordExpandedNode ] ifNone: [  ]
]

{ #category : #testing }
LeWordAnnotationNode >> hasExpandedSpecified [
	^ self expandedValueNode notNil
]

{ #category : #testing }
LeWordAnnotationNode >> hasHeightSpecified [
	^ self heightValueNode notNil
]

{ #category : #testing }
LeWordAnnotationNode >> hasWordSpecified [
	^ self wordValueNode notNil
]

{ #category : #accessing }
LeWordAnnotationNode >> height [
	^ self heightValueNode ifNil: [ 100 ] ifNotNil: [ :node | node value source asInteger ]
]

{ #category : #accessing }
LeWordAnnotationNode >> heightValueNode [
	^ items detect: [ :each | each isKindOf: LeWordHeightNode ] ifNone: [  ]
]

{ #category : #'generated-initialize-release' }
LeWordAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #testing }
LeWordAnnotationNode >> isExpanded [
	^ self expandedValueNode ifNil: [ false ] ifNotNil: [ :node | node value isNil or: [ node value source sameAs: 'true' ] ]
]

{ #category : #generated }
LeWordAnnotationNode >> items [
	^ items
]

{ #category : #generated }
LeWordAnnotationNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #accessing }
LeWordAnnotationNode >> word [
	^ self wordValueNode ifNotNil: [ :node | node value source ]
]

{ #category : #accessing }
LeWordAnnotationNode >> wordValueNode [
	^ items detect: [ :each | each isKindOf: LeWordValueNode ] ifNone: [  ]
]
