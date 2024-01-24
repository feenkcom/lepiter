Class {
	#name : #LePreviewSelectArgumentNode,
	#superclass : #LeArgumentNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LePreviewSelectArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPreviewSelectArgument: self
]

{ #category : #testing }
LePreviewSelectArgumentNode >> isPreviewSelect [
	^ true
]
