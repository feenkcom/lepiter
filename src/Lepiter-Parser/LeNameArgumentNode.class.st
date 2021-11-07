Class {
	#name : #LeNameArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeNameArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitNameArgument: self
]

{ #category : #accessing }
LeNameArgumentNode >> imageObject [
	^ self subclassResponsibility
]

{ #category : #testing }
LeNameArgumentNode >> isDefined [
	^ self imageObject notNil
]

{ #category : #testing }
LeNameArgumentNode >> isName [
	^ true
]
