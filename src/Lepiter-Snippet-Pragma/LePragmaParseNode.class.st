"
Base node for gtPragma annotation parsing.
"
Class {
	#name : #LePragmaParseNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #generated }
LePragmaParseNode >> acceptVisitor: aPragmaParseVisitor [
	^ aPragmaParseVisitor visitPragmaParse: self
]
