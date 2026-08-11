Class {
	#name : #LeObjectReferenceShowNode,
	#superclass : #LeObjectReferenceArgumentNode,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceShowNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceShow: self
]
