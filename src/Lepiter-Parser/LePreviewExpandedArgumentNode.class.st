Class {
	#name : #LePreviewExpandedArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LePreviewExpandedArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitPreviewExpandedArgument: self
]

{ #category : #testing }
LePreviewExpandedArgumentNode >> isPreviewExpanded [
	^ true
]
