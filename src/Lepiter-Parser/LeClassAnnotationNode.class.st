Class {
	#name : #LeClassAnnotationNode,
	#superclass : #LeAnnotationNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeClassAnnotationNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitClassAnnotation: self
]
