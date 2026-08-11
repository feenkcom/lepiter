Class {
	#name : #LeObjectReferenceArgumentNode,
	#superclass : #LeObjectReferenceParseNode,
	#instVars : [
		'name',
		'equals',
		'value'
	],
	#category : #'Lepiter-Snippet-ObjectReference'
}

{ #category : #generated }
LeObjectReferenceArgumentNode >> acceptVisitor: anObjectReferenceParseVisitor [
	^anObjectReferenceParseVisitor visitObjectReferenceArgument: self
]

{ #category : #generated }
LeObjectReferenceArgumentNode >> equals [
	^equals
]

{ #category : #generated }
LeObjectReferenceArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LeObjectReferenceArgumentNode >> name [
	^name
]

{ #category : #generated }
LeObjectReferenceArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeObjectReferenceArgumentNode >> tokenVariables [
	^#(#value #name #equals)
]

{ #category : #generated }
LeObjectReferenceArgumentNode >> value [
	^value
]

{ #category : #generated }
LeObjectReferenceArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
