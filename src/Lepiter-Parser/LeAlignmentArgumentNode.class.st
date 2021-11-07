Class {
	#name : #LeAlignmentArgumentNode,
	#superclass : #LeArgumentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeAlignmentArgumentNode >> acceptVisitor: anAnnotationParseVisitor [
	^ anAnnotationParseVisitor visitAlignmentArgument: self
]

{ #category : #testing }
LeAlignmentArgumentNode >> isAlignment [
	^ true
]
