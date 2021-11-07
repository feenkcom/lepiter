Class {
	#name : #LeExpandedArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeExpandedArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitExpandedArgument: self
]

{ #category : #testing }
LeExpandedArgumentNode >> isExpanded [
	^ true
]
