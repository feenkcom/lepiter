Class {
	#name : #LeShowArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeShowArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitShowArgument: self
]

{ #category : #testing }
LeShowArgumentNode >> isShow [
	^ true
]
