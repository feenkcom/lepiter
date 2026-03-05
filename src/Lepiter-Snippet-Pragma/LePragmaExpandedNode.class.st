Class {
	#name : #LePragmaExpandedNode,
	#superclass : #LePragmaArgumentNode,
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #generated }
LePragmaExpandedNode >> acceptVisitor: aPragmaParseVisitor [
	^ aPragmaParseVisitor visitPragmaExpanded: self
]
