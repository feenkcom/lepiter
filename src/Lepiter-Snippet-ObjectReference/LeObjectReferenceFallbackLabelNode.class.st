Class {
	#name : #LeObjectReferenceFallbackLabelNode,
	#superclass : #LeObjectReferenceArgumentNode,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceFallbackLabelNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceFallbackLabel: self
]
