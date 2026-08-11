Class {
	#name : #LeObjectReferenceParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceParseNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceParse: self
]
