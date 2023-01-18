Class {
	#name : #LeTextualSnippetViewState,
	#superclass : #Object,
	#instVars : [
		'cursorPosition'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeTextualSnippetViewState >> cursorPosition [
	^ cursorPosition
]

{ #category : #accessing }
LeTextualSnippetViewState >> cursorPosition: anInteger [
	cursorPosition := anInteger
]

{ #category : #'updating - view model' }
LeTextualSnippetViewState >> updateSnippetViewModelFor: aSnippetViewModel [
	self cursorPosition ifNotNil: [ :aCursorPosition |
		aSnippetViewModel moveCursorAt: aCursorPosition ]
]
