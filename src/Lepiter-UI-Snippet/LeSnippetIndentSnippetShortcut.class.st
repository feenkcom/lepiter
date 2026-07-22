Class {
	#name : #LeSnippetIndentSnippetShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetIndentSnippetShortcut >> description [
	^ 'Indents the snippet.'
]

{ #category : #initialization }
LeSnippetIndentSnippetShortcut >> initialize [
	super initialize.
	
	self 
		shortcutId: LeShortcutIds default indentSnippetShortcutId
		inRegistry: BlShortcutKeymapRegistry default lepiter 
]

{ #category : #accessing }
LeSnippetIndentSnippetShortcut >> name [
	^ 'Indent'
]

{ #category : #evaluation }
LeSnippetIndentSnippetShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement snippetViewModel requestIndent
]
