Class {
	#name : #LeSymbolNameNode,
	#superclass : #LeSymbolParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'Lepiter-Snippet-Symbol'
}

{ #category : #generated }
LeSymbolNameNode >> acceptVisitor: aSymbolParseVisitor [
	^ aSymbolParseVisitor visitSymbolName: self
]

{ #category : #generated }
LeSymbolNameNode >> equals [
	^ equals
]

{ #category : #generated }
LeSymbolNameNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LeSymbolNameNode >> name [
	^ name
]

{ #category : #generated }
LeSymbolNameNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeSymbolNameNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LeSymbolNameNode >> value [
	^ value
]

{ #category : #generated }
LeSymbolNameNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
