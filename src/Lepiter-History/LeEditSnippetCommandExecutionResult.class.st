Class {
	#name : #LeEditSnippetCommandExecutionResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'previousSnippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeEditSnippetCommandExecutionResult >> previousSnippetState [

	^ previousSnippetState
]

{ #category : #accessing }
LeEditSnippetCommandExecutionResult >> previousSnippetState: anObject [

	previousSnippetState := anObject
]
