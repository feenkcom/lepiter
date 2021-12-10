Class {
	#name : #LeWordParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Snippet-Words-Annotations'
}

{ #category : #generated }
LeWordParseNode >> acceptVisitor: aWordParseVisitor [
	^ aWordParseVisitor visitWordParse: self
]
