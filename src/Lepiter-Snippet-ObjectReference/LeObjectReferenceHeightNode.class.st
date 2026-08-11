Class {
	#name : #LeObjectReferenceHeightNode,
	#superclass : #LeObjectReferenceArgumentNode,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceHeightNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceHeight: self
]
