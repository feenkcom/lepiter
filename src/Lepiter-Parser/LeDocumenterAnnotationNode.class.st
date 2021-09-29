Class {
	#name : 'LeDocumenterAnnotationNode',
	#superclass : 'LeContentNode',
	#instVars : [
		'left',
		'name',
		'annotation',
		'colon',
		'right'
	],
	#category : 'Lepiter-Parser'
}

{ #category : 'generated' }
LeDocumenterAnnotationNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitDocumenterAnnotation: self
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> annotation [
	^ annotation
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> annotation: anObject [
	self setParent: self annotation to: nil.
	annotation := anObject.
	self setParent: self annotation to: self
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> colon [
	^ colon
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> colon: aSmaCCToken [
	colon := aSmaCCToken
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> left [
	^ left
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> name [
	^ name
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> otherVariables [
	^ #(#annotation)
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> right [
	^ right
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : 'generated' }
LeDocumenterAnnotationNode >> tokenVariables [
	^ #(#left #name #colon #right)
]
