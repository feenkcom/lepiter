Class {
	#name : #LeObjectReferenceLabelNode,
	#superclass : #LeObjectReferenceArgumentNode,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceLabelNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceLabel: self
]
