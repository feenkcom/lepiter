Class {
	#name : #LeSplitSnippetCommandResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'insertedSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeSplitSnippetCommandResult >> insertedSnippet [
	^ insertedSnippet
]

{ #category : #accessing }
LeSplitSnippetCommandResult >> insertedSnippet: aSnippet [
	insertedSnippet := aSnippet
]
