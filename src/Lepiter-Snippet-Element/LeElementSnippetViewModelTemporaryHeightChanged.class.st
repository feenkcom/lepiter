Class {
	#name : #LeElementSnippetViewModelTemporaryHeightChanged,
	#superclass : #LeElementSnippetViewModelTemporaryChanged,
	#instVars : [
		'elementHeight',
		'codeHeight'
	],
	#category : #'Lepiter-Snippet-Element-Events'
}

{ #category : #accessing }
LeElementSnippetViewModelTemporaryHeightChanged >> codeHeight [
	^ codeHeight
]

{ #category : #accessing }
LeElementSnippetViewModelTemporaryHeightChanged >> codeHeight: anObject [
	codeHeight := anObject
]

{ #category : #accessing }
LeElementSnippetViewModelTemporaryHeightChanged >> elementHeight [
	^ elementHeight
]

{ #category : #accessing }
LeElementSnippetViewModelTemporaryHeightChanged >> elementHeight: anObject [
	elementHeight := anObject
]
