Class {
	#name : #LeBoldNode,
	#superclass : #LeContentNode,
	#instVars : [
		'leftStars',
		'parts',
		'rightStars'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeBoldNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitBold: self
]

{ #category : #generated }
LeBoldNode >> compositeNodeVariables [
	^ #(#parts)
]

{ #category : #generated }
LeBoldNode >> compositeTokenVariables [
	^ #(#leftStars #rightStars)
]

{ #category : #'generated-initialize-release' }
LeBoldNode >> initialize [
	super initialize.
	leftStars := OrderedCollection new: 2.
	parts := OrderedCollection new: 2.
	rightStars := OrderedCollection new: 2.
]

{ #category : #generated }
LeBoldNode >> leftStars [
	^ leftStars
]

{ #category : #generated }
LeBoldNode >> leftStars: anOrderedCollection [
	leftStars := anOrderedCollection
]

{ #category : #generated }
LeBoldNode >> parts [
	^ parts
]

{ #category : #generated }
LeBoldNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]

{ #category : #generated }
LeBoldNode >> rightStars [
	^ rightStars
]

{ #category : #generated }
LeBoldNode >> rightStars: anOrderedCollection [
	rightStars := anOrderedCollection
]
