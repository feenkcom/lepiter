Class {
	#name : #LeStringNode,
	#superclass : #LeContentNode,
	#instVars : [
		'parts'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeStringNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitString: self
]

{ #category : #generated }
LeStringNode >> compositeNodeVariables [
	^ #(#parts)
]

{ #category : #'generated-initialize-release' }
LeStringNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #generated }
LeStringNode >> parts [
	^ parts
]

{ #category : #generated }
LeStringNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]
