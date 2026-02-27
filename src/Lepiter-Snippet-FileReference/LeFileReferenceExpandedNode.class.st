Class {
	#name : #LeFileReferenceExpandedNode,
	#superclass : #LeFileReferenceArgumentNode,
	#instVars : [
		'value'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferenceExpandedNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferenceExpanded: self
]

{ #category : #generated }
LeFileReferenceExpandedNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LeFileReferenceExpandedNode >> value [
	^ value
]

{ #category : #generated }
LeFileReferenceExpandedNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
