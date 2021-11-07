Class {
	#name : #LeLinkNode,
	#superclass : #LeContentNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitLink: self
]
