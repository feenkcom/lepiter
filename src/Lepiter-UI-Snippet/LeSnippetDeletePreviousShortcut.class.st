Class {
	#name : #LeSnippetDeletePreviousShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : 'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetDeletePreviousShortcut >> description [
	^ 'Delete previous character, or merge with the previous snippet'
]

{ #category : #initialization }
LeSnippetDeletePreviousShortcut >> initialize [
	super initialize.
	
	self 
		shortcutId: LeShortcutIds default deletePreviousShortcutId
		inRegistry: BlShortcutKeymapRegistry default lepiter 
]

{ #category : #accessing }
LeSnippetDeletePreviousShortcut >> name [
	^ 'Delete previous'
]

{ #category : #evaluation }
LeSnippetDeletePreviousShortcut >> performOnEditor: aBrTextEditor editorElement: anEditorElement snippetElement: aSnippetElement dueTo: aShortcutEvent [
	anEditorElement
		selectedStringAndIntervalDo: [ :aSelectedString :aSelectedInterval :aTextSize :aDocumentId :aCaretOffset |
			BrEditorShortcut deleteOneLetterBeforeCursor 
				performDueTo: aShortcutEvent ]
		orCursorPositionDo: [ :aStringPosition :aTextSize :aDocumentId :aCaretOffset | 
			aCaretOffset isZero
				ifTrue: [ aSnippetElement mergeWithPrevious ]
				ifFalse: [ BrEditorShortcut deleteOneLetterBeforeCursor 
					performDueTo: aShortcutEvent ] ]
]
