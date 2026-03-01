"
Abstract node for gtPragma annotation arguments.
"
Class {
	#name : #LePragmaArgumentNode,
	#superclass : #LePragmaParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #'Lepiter-Snippet-Pragma'
}

{ #category : #generated }
LePragmaArgumentNode >> acceptVisitor: aPragmaParseVisitor [
	^ aPragmaParseVisitor visitPragmaArgument: self
]

{ #category : #generated }
LePragmaArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LePragmaArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LePragmaArgumentNode >> name [
	^ name
]

{ #category : #generated }
LePragmaArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LePragmaArgumentNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LePragmaArgumentNode >> value [
	^ value
]

{ #category : #generated }
LePragmaArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
