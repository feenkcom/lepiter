Class {
	#name : #LeEmptyExternalLinkNode,
	#superclass : #LeContentNode,
	#instVars : [
		'leftBracket',
		'rightBracket',
		'leftParenthesis',
		'rightParenthesis'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeEmptyExternalLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitEmptyExternalLink: self
]

{ #category : #generated }
LeEmptyExternalLinkNode >> leftBracket [
	^ leftBracket
]

{ #category : #generated }
LeEmptyExternalLinkNode >> leftBracket: aSmaCCToken [
	leftBracket := aSmaCCToken
]

{ #category : #generated }
LeEmptyExternalLinkNode >> leftParenthesis [
	^ leftParenthesis
]

{ #category : #generated }
LeEmptyExternalLinkNode >> leftParenthesis: aSmaCCToken [
	leftParenthesis := aSmaCCToken
]

{ #category : #generated }
LeEmptyExternalLinkNode >> rightBracket [
	^ rightBracket
]

{ #category : #generated }
LeEmptyExternalLinkNode >> rightBracket: aSmaCCToken [
	rightBracket := aSmaCCToken
]

{ #category : #generated }
LeEmptyExternalLinkNode >> rightParenthesis [
	^ rightParenthesis
]

{ #category : #generated }
LeEmptyExternalLinkNode >> rightParenthesis: aSmaCCToken [
	rightParenthesis := aSmaCCToken
]

{ #category : #generated }
LeEmptyExternalLinkNode >> tokenVariables [
	^ #(#leftBracket #rightBracket #leftParenthesis #rightParenthesis)
]
