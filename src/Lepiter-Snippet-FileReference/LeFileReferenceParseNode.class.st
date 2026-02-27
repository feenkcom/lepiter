Class {
	#name : #LeFileReferenceParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferenceParseNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferenceParse: self
]
