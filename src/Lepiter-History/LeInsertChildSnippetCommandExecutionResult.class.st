Class {
	#name : #LeInsertChildSnippetCommandExecutionResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'insertedSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeInsertChildSnippetCommandExecutionResult >> insertedSnippet [

	^ insertedSnippet
]

{ #category : #accessing }
LeInsertChildSnippetCommandExecutionResult >> insertedSnippet: anObject [

	insertedSnippet := anObject
]
