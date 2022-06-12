Class {
	#name : #LeTagArgumentNode,
	#superclass : #LeArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeTagArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitTagArgument: self
]

{ #category : #accessing }
LeTagArgumentNode >> isTag [
	^ true
]
