Class {
	#name : #LeFullHashLinkNode,
	#superclass : #LeHashLinkNode,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeFullHashLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitFullHashLink: self
]

{ #category : #generated }
LeFullHashLinkNode >> left [
	^ left
]

{ #category : #generated }
LeFullHashLinkNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #'api - accessing' }
LeFullHashLinkNode >> linkUID [
	"Return link name (UID) that represents a referenced page"
	^ self link source
]

{ #category : #generated }
LeFullHashLinkNode >> right [
	^ right
]

{ #category : #generated }
LeFullHashLinkNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
LeFullHashLinkNode >> tokenVariables [
	^ #(#left #right #link)
]
