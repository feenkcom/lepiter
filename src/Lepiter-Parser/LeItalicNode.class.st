Class {
	#name : #LeItalicNode,
	#superclass : #LeContentNode,
	#instVars : [
		'leftStar',
		'parts',
		'rightStar'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeItalicNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitItalic: self
]

{ #category : #generated }
LeItalicNode >> compositeNodeVariables [
	^ #(#parts)
]

{ #category : #'generated-initialize-release' }
LeItalicNode >> initialize [
	super initialize.
	parts := OrderedCollection new: 2.
]

{ #category : #generated }
LeItalicNode >> leftStar [
	^ leftStar
]

{ #category : #generated }
LeItalicNode >> leftStar: aSmaCCToken [
	leftStar := aSmaCCToken
]

{ #category : #generated }
LeItalicNode >> parts [
	^ parts
]

{ #category : #generated }
LeItalicNode >> parts: anOrderedCollection [
	self setParents: self parts to: nil.
	parts := anOrderedCollection.
	self setParents: self parts to: self
]

{ #category : #generated }
LeItalicNode >> rightStar [
	^ rightStar
]

{ #category : #generated }
LeItalicNode >> rightStar: aSmaCCToken [
	rightStar := aSmaCCToken
]

{ #category : #generated }
LeItalicNode >> tokenVariables [
	^ #(#leftStar #rightStar)
]
