Class {
	#name : #LeBlockLinkNode,
	#superclass : #LeDefinedLinkNode,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeBlockLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitBlockLink: self
]

{ #category : #generated }
LeBlockLinkNode >> left [
	^ left
]

{ #category : #generated }
LeBlockLinkNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #'api - accessing' }
LeBlockLinkNode >> linkUID [
	"Return UID that represents a page or part"
	^ self link source
]

{ #category : #generated }
LeBlockLinkNode >> right [
	^ right
]

{ #category : #generated }
LeBlockLinkNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
LeBlockLinkNode >> tokenVariables [
	^ #(#left #right #link)
]
