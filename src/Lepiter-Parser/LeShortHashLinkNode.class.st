Class {
	#name : #LeShortHashLinkNode,
	#superclass : #LeHashLinkNode,
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeShortHashLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitShortHashLink: self
]

{ #category : #'api - accessing' }
LeShortHashLinkNode >> linkUID [
	"Return link name (UID) that represents a referenced page"
	^ self link source allButFirst
]
