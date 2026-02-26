Class {
	#name : #LeFileReferencePathNode,
	#superclass : #LeFileReferenceArgumentNode,
	#instVars : [
		'value'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferencePathNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferencePath: self
]

{ #category : #generated }
LeFileReferencePathNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LeFileReferencePathNode >> value [
	^ value
]

{ #category : #generated }
LeFileReferencePathNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
