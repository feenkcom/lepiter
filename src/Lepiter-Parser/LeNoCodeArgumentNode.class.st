Class {
	#name : #LeNoCodeArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeNoCodeArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitNoCodeArgument: self
]

{ #category : #testing }
LeNoCodeArgumentNode >> isNoCode [
	^ true
]
