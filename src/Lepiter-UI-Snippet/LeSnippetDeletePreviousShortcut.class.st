Class {
	#name : #LeSnippetDeletePreviousShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : #'Lepiter-UI-Snippet-Shortcuts'
}

{ #category : #accessing }
LeSnippetDeletePreviousShortcut >> description [
	^ 'Delete previous character, or merge with the previous snippet'
]

{ #category : #accessing }
LeSnippetDeletePreviousShortcut >> name [
	^ 'Delete previous'
]

{ #category : #evaluation }
LeSnippetDeletePreviousShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	(aBrTextEditor cursors first position isZero and: [ aBrTextEditor hasSelection not ])
		ifTrue: [ ^ aLeSnippetElement mergeWithPrevious ].

	BrEditorShortcut deleteOneLetterBeforeCursor
		performDueTo: aShortcutEvent
]
