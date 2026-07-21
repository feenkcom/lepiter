Class {
	#name : #LeSnippetMoveSnippetDownShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : 'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetMoveSnippetDownShortcut >> description [
	^ 'Moves snippet down, shifting the other snippets up.'
]

{ #category : #initialization }
LeSnippetMoveSnippetDownShortcut >> initialize [
	super initialize.
	
	self 
		shortcutId: LeShortcutIds default moveSnippetDownShortcutId
		inRegistry: BlShortcutKeymapRegistry default lepiter 
]

{ #category : #accessing }
LeSnippetMoveSnippetDownShortcut >> name [
	^ 'Move snippet down'
]

{ #category : #evaluation }
LeSnippetMoveSnippetDownShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement snippetViewModel requestMoveDown
]
