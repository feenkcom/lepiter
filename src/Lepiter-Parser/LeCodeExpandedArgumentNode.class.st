Class {
	#name : #LeCodeExpandedArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeCodeExpandedArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitCodeExpandedArgument: self
]

{ #category : #testing }
LeCodeExpandedArgumentNode >> isCodeExpanded [
	^ true
]
