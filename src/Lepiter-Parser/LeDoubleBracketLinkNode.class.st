Class {
	#name : #LeDoubleBracketLinkNode,
	#superclass : #LePageLinkNode,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeDoubleBracketLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitDoubleBracketLink: self
]

{ #category : #generated }
LeDoubleBracketLinkNode >> left [
	^ left
]

{ #category : #generated }
LeDoubleBracketLinkNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #'api - accessing' }
LeDoubleBracketLinkNode >> linkUID [
	"Return link name (UID) that represents a referenced page"
	^ self link source
]

{ #category : #generated }
LeDoubleBracketLinkNode >> right [
	^ right
]

{ #category : #generated }
LeDoubleBracketLinkNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
LeDoubleBracketLinkNode >> tokenVariables [
	^ #(#left #right #link)
]
