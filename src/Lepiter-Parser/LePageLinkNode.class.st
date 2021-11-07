Class {
	#name : #LePageLinkNode,
	#superclass : #LeDefinedLinkNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LePageLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitPageLink: self
]
