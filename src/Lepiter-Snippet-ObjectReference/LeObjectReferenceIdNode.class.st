Class {
	#name : #LeObjectReferenceIdNode,
	#superclass : #LeObjectReferenceArgumentNode,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceIdNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceId: self
]
