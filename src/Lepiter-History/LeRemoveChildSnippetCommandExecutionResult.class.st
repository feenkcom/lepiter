Class {
	#name : #LeRemoveChildSnippetCommandExecutionResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'nextFocusedSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeRemoveChildSnippetCommandExecutionResult >> nextFocusedSnippet [
	^ nextFocusedSnippet
]

{ #category : #accessing }
LeRemoveChildSnippetCommandExecutionResult >> nextFocusedSnippet: anObject [
	nextFocusedSnippet := anObject
]
