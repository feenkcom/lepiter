Class {
	#name : #LeSnippetIndentSnippetShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetIndentSnippetShortcut >> description [
	^ 'Indents the snippet.'
]

{ #category : #accessing }
LeSnippetIndentSnippetShortcut >> name [
	^ 'Indent'
]

{ #category : #evaluation }
LeSnippetIndentSnippetShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement snippetViewModel requestIndent
]
