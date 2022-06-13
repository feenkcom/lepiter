Class {
	#name : #LeIdArgumentNode,
	#superclass : #LeArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeIdArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitIdArgument: self
]

{ #category : #testing }
LeIdArgumentNode >> isId [
	^ true
]
