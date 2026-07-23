Class {
	#name : #LeSnippetDeleteNextShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetDeleteNextShortcut >> description [
	^ 'Delete next character, or merge with the next snippet'
]

{ #category : #accessing }
LeSnippetDeleteNextShortcut >> initialize [
	super initialize.
	
	self 
		shortcutId: LeShortcutIds default deleteNextShortcutId
		inRegistry: BlShortcutKeymapRegistry default lepiter 
]

{ #category : #accessing }
LeSnippetDeleteNextShortcut >> name [
	^ 'Delete next'
]

{ #category : #evaluation }
LeSnippetDeleteNextShortcut >> performOnEditor: aBrTextEditor editorElement: anEditorElement snippetElement: aSnippetElement dueTo: aShortcutEvent [
	anEditorElement
		selectedStringAndIntervalDo: [ :aSelectedString :aSelectedInterval :aTextSize :aDocumentId :aCaretOffset |
			BrEditorShortcut deleteOneLetterAfterCursor 
				performDueTo: aShortcutEvent ]
		orCursorPositionDo: [ :aStringPosition :aTextSize :aDocumentId :aCaretOffset | 
			aCaretOffset = aTextSize
				ifTrue: [ aSnippetElement mergeWithNext ]
				ifFalse: [ BrEditorShortcut deleteOneLetterAfterCursor 
					performDueTo: aShortcutEvent ] ]
]
