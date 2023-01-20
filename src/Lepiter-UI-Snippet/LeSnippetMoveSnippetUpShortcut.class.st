Class {
	#name : #LeSnippetMoveSnippetUpShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetMoveSnippetUpShortcut >> description [
	^ 'Moves snippet up, shifting the other snippets down.'
]

{ #category : #accessing }
LeSnippetMoveSnippetUpShortcut >> name [
	^ 'Move snippet up'
]

{ #category : #evaluation }
LeSnippetMoveSnippetUpShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement snippetViewModel requestMoveUp
]
