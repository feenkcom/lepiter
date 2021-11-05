Class {
	#name : #LeCustomAnnotationNode,
	#superclass : #LeContentNode,
	#instVars : [
		'left',
		'name',
		'annotation',
		'colon',
		'right'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeCustomAnnotationNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitDocumenterAnnotation: self
]

{ #category : #generated }
LeCustomAnnotationNode >> annotation [
	^ annotation
]

{ #category : #generated }
LeCustomAnnotationNode >> annotation: anObject [
	self setParent: self annotation to: nil.
	annotation := anObject.
	self setParent: self annotation to: self
]

{ #category : #generated }
LeCustomAnnotationNode >> colon [
	^ colon
]

{ #category : #generated }
LeCustomAnnotationNode >> colon: aSmaCCToken [
	colon := aSmaCCToken
]

{ #category : #generated }
LeCustomAnnotationNode >> left [
	^ left
]

{ #category : #generated }
LeCustomAnnotationNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
LeCustomAnnotationNode >> name [
	^ name
]

{ #category : #generated }
LeCustomAnnotationNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeCustomAnnotationNode >> otherVariables [
	^ #(#annotation)
]

{ #category : #generated }
LeCustomAnnotationNode >> right [
	^ right
]

{ #category : #generated }
LeCustomAnnotationNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
LeCustomAnnotationNode >> tokenVariables [
	^ #(#left #name #colon #right)
]
