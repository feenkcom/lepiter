Class {
	#name : #LeFileReferenceLabelNode,
	#superclass : #LeFileReferenceArgumentNode,
	#instVars : [
		'value'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #generated }
LeFileReferenceLabelNode >> acceptVisitor: aFileReferenceParseVisitor [
	^ aFileReferenceParseVisitor visitFileReferenceLabel: self
]

{ #category : #generated }
LeFileReferenceLabelNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LeFileReferenceLabelNode >> value [
	^ value
]

{ #category : #generated }
LeFileReferenceLabelNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
