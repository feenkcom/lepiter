Class {
	#name : #LeCodeSnippetViewModel,
	#superclass : #LeTextualSnippetViewModel,
	#instVars : [
		'coderViewModel'
	],
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #'api - accessing' }
LeCodeSnippetViewModel >> coderViewModel [
	^ coderViewModel
]

{ #category : #'filter view' }
LeCodeSnippetViewModel >> collapsedTextPromise [
	^ self coderViewModel coderModel ast
		then: [ :each | 
			| string text index |
			string := self snippetModel contentAsString asString.
			text := string asRopedText.
			self highlighter
				ifNotNil: [ :highlighter | highlighter style: text ast: each ast ].
			index := self indexOfHighlightIn: text.
			text glamorousCodeFontAndSize.
			(GtPharoStyler new coderViewModel: self coderViewModel)
				style: text
				ast: each ast.
			self clipTextIn: text around: index ]
]

{ #category : #'api - focus' }
LeCodeSnippetViewModel >> focusDueToNavigationDown [
	super focusDueToNavigationDown.
	
	self coderViewModel
		focused: true;
		moveCursorAtEnd
]

{ #category : #'api - focus' }
LeCodeSnippetViewModel >> focusDueToNavigationUp [
	super focusDueToNavigationUp.
	
	self coderViewModel
		focused: true;
		moveCursorAtEnd
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

	coderViewModel := self snippetModel coder asCoderViewModel.
	self initializeCoderAddOns: coderViewModel
]

{ #category : #accessing }
LeCodeSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	
	^ super snippetView
		needsContentDecorationBar: true;
		beFullWidth
]

{ #category : #'api - accessing' }
LeCodeSnippetViewModel >> spawnDestination [
	^ self coderViewModel coderModel spawnDestination
]

{ #category : #'api - accessing' }
LeCodeSnippetViewModel >> spawnDestination: aSpawnDesiredDestination [
	self coderViewModel coderModel spawnDestination: aSpawnDesiredDestination
]
