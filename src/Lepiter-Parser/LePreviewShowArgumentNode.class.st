Class {
	#name : #LePreviewShowArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LePreviewShowArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPreviewShowArgument: self
]

{ #category : #testing }
LePreviewShowArgumentNode >> isPreviewShow [
	^ true
]
