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
LeSnippetUnindentSnippetShortcut >> name [
	^ 'Unindent'
]

{ #category : #evaluation }
LeSnippetUnindentSnippetShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement snippetViewModel requestUnindent
]
