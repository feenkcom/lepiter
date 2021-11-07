Class {
	#name : #LePreviewHeightArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LePreviewHeightArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPreviewHeightArgument: self
]

{ #category : #testing }
LePreviewHeightArgumentNode >> isPreviewHeight [
	^ true
]
