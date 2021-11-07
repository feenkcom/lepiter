Class {
	#name : #LeEmptyDoubleBracketLinkNode,
	#superclass : #LeEmptyLinkNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeEmptyDoubleBracketLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitEmptyDoubleBracketLink: self
]
