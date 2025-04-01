Class {
	#name : #LePictureAnnotationNode,
	#superclass : #LePictureParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #'Lepiter-Snippet-Picture-Annotations'
}

{ #category : #generated }
LePictureAnnotationNode >> acceptVisitor: aPictureParseVisitor [
	^ aPictureParseVisitor visitPictureAnnotation: self
]

{ #category : #generated }
LePictureAnnotationNode >> bars [
	^ bars
]

{ #category : #generated }
LePictureAnnotationNode >> bars: anOrderedCollection [
	bars := anOrderedCollection
]

{ #category : #generated }
LePictureAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
LePictureAnnotationNode >> compositeTokenVariables [
	^ #(#bars)
]

{ #category : #testing }
LePictureAnnotationNode >> hasPictureReferenceSpecified [
	^ self pictureReferenceNode notNil
]

{ #category : #'generated-initialize-release' }
LePictureAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #generated }
LePictureAnnotationNode >> items [
	^ items
]

{ #category : #generated }
LePictureAnnotationNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]

{ #category : #accessing }
LePictureAnnotationNode >> pictureReference [
	^ self pictureReferenceNode value ifNotNil: #source
]

{ #category : #accessing }
LePictureAnnotationNode >> pictureReferenceNode [
	^ items detect: [ :each | each isKindOf: LePictureReferenceNode ] ifNone: [  ]
]
