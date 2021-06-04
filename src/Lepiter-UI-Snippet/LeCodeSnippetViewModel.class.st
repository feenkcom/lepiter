Class {
	#name : #LeCodeSnippetViewModel,
	#superclass : #LeTextualSnippetViewModel,
	#instVars : [
		'coderViewModel'
	],
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #accessing }
LeCodeSnippetViewModel >> coderViewModel [
	^ coderViewModel
]

{ #category : #'api - snippet model' }
LeCodeSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
]

{ #category : #'api - snippet' }
LeCodeSnippetViewModel >> isCoderFocused [
	<return: #Boolean>

	^ self coderViewModel focused
]

{ #category : #'api - snippet' }
LeCodeSnippetViewModel >> moveCursorAt: aCursorPosition [
	"Move the cursor at the given position of the textual snippet"
	
	coderViewModel cursors: (BrTextEditorCursor at: aCursorPosition)
]

{ #category : #'api - snippet model' }
LeCodeSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.

	coderViewModel := self snippetModel coder asCoderUIModel.
	self initializeCoderAddOns: coderViewModel
]

{ #category : #'api - bindings' }
LeCodeSnippetViewModel >> snippetBindings: aGtSnippetBindings [
	super snippetBindings: aGtSnippetBindings.
	
	
]

{ #category : #accessing }
LeCodeSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	
	^ super snippetView
		needsContentDecorationBar: true;
		beDocumentWidth
]
