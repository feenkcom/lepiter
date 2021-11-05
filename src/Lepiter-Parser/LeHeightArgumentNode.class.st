Class {
	#name : #LeHeightArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeHeightArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitHeightArgument: self
]

{ #category : #testing }
LeHeightArgumentNode >> isHeight [
	^ true
]
