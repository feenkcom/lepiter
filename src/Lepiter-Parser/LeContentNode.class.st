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

{ #category : #copying }
LeContentNode >> postCopy [
	super postCopy.
	"Position caches must not be shared when a copied subtree is relocated."
	attributes := attributes ifNotNil: [ attributes copy ]
]

{ #category : #'ston persistence' }
LeContentNode >> stonContainSubObjects [
	"Lepiter AST nodes aren't ever saved, so don't need to be processed (and go into infinite recusion, anyway)"
	^ false
]
