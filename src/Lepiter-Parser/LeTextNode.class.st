Class {
	#name : #LeTextNode,
	#superclass : #LeContentNode,
	#instVars : [
		'text'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeTextNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitText: self
]

{ #category : #'api - accessing' }
LeTextNode >> content [
	"Return text that represents this node"
	^ self text source
]

{ #category : #generated }
LeTextNode >> text [
	^ text
]

{ #category : #generated }
LeTextNode >> text: aSmaCCToken [
	text := aSmaCCToken
]

{ #category : #generated }
LeTextNode >> tokenVariables [
	^ #(#text)
]
