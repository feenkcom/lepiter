"
I perform a word explanation search on when an editor shortcut is pressed (typically the Enter key).

"
Class {
	#name : #LeWordSearchExplanationShortcut,
	#superclass : #LeSnippetEditorShortcut,
	#category : 'Lepiter-Snippet-Words-Shortcuts'
}

{ #category : #accessing }
LeWordSearchExplanationShortcut >> description [
	^ 'Search word explanation on the Internet'
]

{ #category : #accessing }
LeWordSearchExplanationShortcut >> name [
	^ 'Search word explanation'
]

{ #category : #evaluation }
LeWordSearchExplanationShortcut >> performOnEditor: aBrTextEditor snippet: aLeSnippetElement dueTo: aShortcutEvent [
	aLeSnippetElement snippetViewModel searchExplanation.
]
