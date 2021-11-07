Class {
	#name : #LeEmptyHashLinkNode,
	#superclass : #LeEmptyLinkNode,
	#instVars : [
		'prefix'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeEmptyHashLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitEmptyHashLink: self
]

{ #category : #generated }
LeEmptyHashLinkNode >> prefix [
	^ prefix
]

{ #category : #generated }
LeEmptyHashLinkNode >> prefix: aSmaCCToken [
	prefix := aSmaCCToken
]

{ #category : #generated }
LeEmptyHashLinkNode >> tokenVariables [
	^ #(#prefix)
]
