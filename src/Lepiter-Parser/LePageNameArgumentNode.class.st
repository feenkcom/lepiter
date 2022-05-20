Class {
	#name : #LePageNameArgumentNode,
	#superclass : #LeNameArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePageNameArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPageNameArgument: self
]

{ #category : #accessing }
LePageNameArgumentNode >> imageObject [
	^ nil
]

{ #category : #testing }
LePageNameArgumentNode >> isDefined [
	^ value value isNotNil
]
