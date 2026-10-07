Class {
	#name : #GtShellScriptProgramNode,
	#superclass : #SmaCCParseNode,
	#instVars : [
		'string'
	],
	#category : #'Lepiter-Snippet-Shell-Parser'
}

{ #category : #generated }
GtShellScriptProgramNode >> acceptVisitor: aProgramVisitor [
	^ aProgramVisitor visitProgram: self
]

{ #category : #generated }
GtShellScriptProgramNode >> string [
	^ string
]

{ #category : #generated }
GtShellScriptProgramNode >> string: aSmaCCToken [
	string := aSmaCCToken
]

{ #category : #generated }
GtShellScriptProgramNode >> tokenVariables [
	^ #(#string)
]
