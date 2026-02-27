Class {
	#name : #LeFileReferenceHeightNode,
	#superclass : #LeFileReferenceArgumentNode,
	#instVars : [
		'value'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferenceHeightNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferenceHeight: self
]

{ #category : #generated }
LeFileReferenceHeightNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LeFileReferenceHeightNode >> value [
	^ value
]

{ #category : #generated }
LeFileReferenceHeightNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
