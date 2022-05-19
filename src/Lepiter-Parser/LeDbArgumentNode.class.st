Class {
	#name : #LeDbArgumentNode,
	#superclass : #LeArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeDbArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitDbArgument: self
]

{ #category : #testing }
LeDbArgumentNode >> isDb [
	^ true
]
