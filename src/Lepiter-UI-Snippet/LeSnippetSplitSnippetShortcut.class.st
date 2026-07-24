Class {
	#name : #LeSnippetSplitSnippetShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetSplitSnippetShortcut >> description [
	^ 'Split the snippet being edited at the current cursor position. Children stay with the receiver.
	This means:
	- creating a new snippet before the receiver''s snippet and adding the text before the cursor.
	- deleting the text before the cursor in the receiver''s snippet'
]

{ #category : #initialization }
LeSnippetSplitSnippetShortcut >> initialize [
	super initialize.
	
	self 
		shortcutId: LeShortcutIds default splitSnippetShortcutId
		inRegistry: BlShortcutKeymapRegistry default lepiter 
]

{ #category : #accessing }
LeSnippetSplitSnippetShortcut >> name [
	^ 'Split snippet'
]

{ #category : #evaluation }
LeSnippetSplitSnippetShortcut >> performOnEditor: aBrTextEditor editorElement: anEditorElement snippetElement: aSnippetElement dueTo: aShortcutEvent [
	anEditorElement
		selectedStringAndIntervalDo: [ :aSelectedString :aSelectedInterval :aTextSize :aDocumentId :aCaretOffset | aSnippetElement splitAt: aCaretOffset ]
		orCursorPositionDo: [ :aStringPosition :aTextSize :aDocumentId :aCaretOffset | aSnippetElement splitAt: aCaretOffset ]
]
