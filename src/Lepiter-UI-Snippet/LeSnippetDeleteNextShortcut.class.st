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
LeSnippetDeleteNextShortcut >> name [
	^ 'Delete next'
]

{ #category : #evaluation }
LeSnippetDeleteNextShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	
	"#textSnaphot is safe to use from a non-UI thread"
	(aBrTextEditor cursors first position = aBrTextEditor textSnapshot size
		and: [ aBrTextEditor hasSelection not ])
			ifTrue: [ ^ aLeSnippetElement mergeWithNext ].

	BrEditorShortcut deleteOneLetterAfterCursor
		performDueTo: aShortcutEvent
]
