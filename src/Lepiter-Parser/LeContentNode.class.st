Class {
	#name : #LeContentNode,
	#superclass : #SmaCCParseNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeContentNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitContent: self
]

{ #category : #testing }
LeContentNode >> isHeaderNode [
	^ false
]

{ #category : #'ston persistence' }
LeContentNode >> stonContainSubObjects [
	"Lepiter AST nodes aren't ever saved, so don't need to be processed (and go into infinite recusion, anyway)"
	^ false
]
