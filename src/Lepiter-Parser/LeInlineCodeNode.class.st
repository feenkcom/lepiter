Class {
	#name : #LeInlineCodeNode,
	#superclass : #LeContentNode,
	#instVars : [
		'code'
	],
	#category : 'Lepiter-Parser'
}

{ #category : #generated }
LeInlineCodeNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitInlineCode: self
]

{ #category : #generated }
LeInlineCodeNode >> code [
	^ code
]

{ #category : #generated }
LeInlineCodeNode >> code: aSmaCCToken [
	code := aSmaCCToken
]

{ #category : #generated }
LeInlineCodeNode >> tokenVariables [
	^ #(#code)
]
