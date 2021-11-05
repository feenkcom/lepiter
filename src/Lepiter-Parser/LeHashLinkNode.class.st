Class {
	#name : #LeHashLinkNode,
	#superclass : #LePageLinkNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeHashLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitHashLink: self
]
