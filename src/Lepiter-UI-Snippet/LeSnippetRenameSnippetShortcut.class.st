Class {
	#name : #LeSnippetRenameSnippetShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : 'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetRenameSnippetShortcut >> description [
	^ 'Requests to rename a snippet.'
]

{ #category : #initialization }
LeSnippetRenameSnippetShortcut >> initialize [
	super initialize.
	
	self 
		shortcutId: LeShortcutIds default renameSnippetShortcutId
		inRegistry: BlShortcutKeymapRegistry default lepiter 
]

{ #category : #accessing }
LeSnippetRenameSnippetShortcut >> name [
	^ 'Rename snippet'
]

{ #category : #evaluation }
LeSnippetRenameSnippetShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement renamePageIn: aShortcutEvent currentTarget
]
