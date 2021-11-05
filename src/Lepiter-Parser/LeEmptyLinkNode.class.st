Class {
	#name : #LeEmptyLinkNode,
	#superclass : #LeLinkNode,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeEmptyLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitEmptyLink: self
]

{ #category : #generated }
LeEmptyLinkNode >> left [
	^ left
]

{ #category : #generated }
LeEmptyLinkNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
LeEmptyLinkNode >> right [
	^ right
]

{ #category : #generated }
LeEmptyLinkNode >> right: aSmaCCToken [
	right := aSmaCCToken
]

{ #category : #generated }
LeEmptyLinkNode >> tokenVariables [
	^ #(#left #right)
]
