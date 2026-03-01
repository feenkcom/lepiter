"
Node that captures the pragma name.
"
Class {
	#name : #LePragmaNameNode,
	#superclass : #LePragmaArgumentNode,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #generated }
LePragmaNameNode >> acceptVisitor: aPragmaParseVisitor [
	^ aPragmaParseVisitor visitPragmaName: self
]
