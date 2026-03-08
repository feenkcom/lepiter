Class {
	#name : #LeSymbolParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #generated }
LeSymbolParseNode >> acceptVisitor: aSymbolParseVisitor [
	^ aSymbolParseVisitor visitSymbolParse: self
]
