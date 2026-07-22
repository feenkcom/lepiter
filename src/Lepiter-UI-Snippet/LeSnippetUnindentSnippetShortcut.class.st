Class {
	#name : #LeSnippetUnindentSnippetShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetUnindentSnippetShortcut >> description [
	^ 'Unindents the snippet.'
]

{ #category : #accessing }
LeSnippetUnindentSnippetShortcut >> initialize [
	super initialize.
	
	self 
		shortcutId: LeShortcutIds default unindentSnippetShortcutId
		inRegistry: BlShortcutKeymapRegistry default lepiter 
]

{ #category : #accessing }
LeSnippetUnindentSnippetShortcut >> name [
	^ 'Unindent'
]

{ #category : #evaluation }
LeSnippetUnindentSnippetShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement snippetViewModel requestUnindent
]
