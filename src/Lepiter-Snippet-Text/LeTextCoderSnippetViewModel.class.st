Class {
	#name : #LeTextCoderSnippetViewModel,
	#superclass : #LeTextualSnippetViewModel,
	#instVars : [
		'shouldShowMarkup',
		'textCoder',
		'textCoderViewModel'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #accessing }
LeTextCoderSnippetViewModel >> coderViewModel [
	^ textCoderViewModel
]

{ #category : #initialization }
LeTextCoderSnippetViewModel >> initialize [
	super initialize.
	
	shouldShowMarkup := false.
	
	textCoder := GtTextCoder new.
	textCoder parser: LeParser.
	textCoder completionStrategy: LeCompletionStrategy new.
	textCoderViewModel := textCoder asCoderViewModel.
	textCoderViewModel addStyler: (LeTextCoderStyler new lepiterStyler: (LeSnippetStyler new snippetViewModel: self)).

	self initializeCoderAddOns: textCoderViewModel
]

{ #category : #'api - snippet model' }
LeTextCoderSnippetViewModel >> initializeCoderAddOns: aTextualCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"

	aTextualCoderViewModel
		"Lose focus LeSnippet"
		addShortcut: (BrEditorLoseFocusShortcut new combination: (self keyboardShortcut: #LoseFocus));
		"Indent LeSnippet"
		addShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move snippet up"
		addShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Move snippet down"
		addShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown));
		"Split the current snippet"
		addShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #SplitSnippet));
		"we also split on new line"
		addShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #NewLine));
		"New Line in LeSnippet"
		addShortcut: (BrEditorLineEndingShortcut new combination: (self keyboardShortcut: #SecondaryNewLine));
		"Delete previous character, or merge with previous block"
		addShortcut: (LeSnippetDeletePreviousShortcut new combination: (self keyboardShortcut: #DeletePrevious));
		"Delete next character, or merge with following block"
		addShortcut: (LeSnippetDeleteNextShortcut new combination: (self keyboardShortcut: #DeleteNext));
		"Primary-R -> Rename"
		addShortcut: (LeSnippetRenameSnippetShortcut new combination: (self keyboardShortcut: #RenameSnippet)).
]

{ #category : #'api - snippet' }
LeTextCoderSnippetViewModel >> moveCursorAt: aCursorPosition [
	"Move the cursor at the given position of the textual snippet"

	self coderViewModel moveCursorTo: aCursorPosition
]

{ #category : #'private - event handling' }
LeTextCoderSnippetViewModel >> onCoderSourceModified: aGtCoderSourceCodeChanged [
	aGtCoderSourceCodeChanged source = self
		ifTrue: [ ^ self ].

	self snippetModel
		updateText: aGtCoderSourceCodeChanged coder sourceText
		source: (self -> aGtCoderSourceCodeChanged isSynchronous)
]

{ #category : #'api - focus' }
LeTextCoderSnippetViewModel >> onFocusChanged: aBoolean [
	self coderViewModel focused: aBoolean
]

{ #category : #'api - snippet model' }
LeTextCoderSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self snippetChildren: (self snippetModel children collect: [ :eachChildSnippet | eachChildSnippet asSnippetViewModel ]).

	textCoder
		sourceCodeSynchronously: (GtCoderExplicitSourceText new text: self snippetModel text copyWithoutExternalReferences).
	textCoder completionStrategy database: self snippetModel database.
]

{ #category : #'private - event handling' }
LeTextCoderSnippetViewModel >> onSnippetTextChanged: aLeSnippetTextChanged [
	"I am triggered when a ${class:LeTextSnippet}$'s text is modified"
	| isAnnouncedByMe |
	
	isAnnouncedByMe := aLeSnippetTextChanged source = (self -> true)
		or: [ aLeSnippetTextChanged source = (self -> false) ].
	
	isAnnouncedByMe
		ifTrue: [ ^ self ].
	
	"#value can be anything, we are therefore explicitly checking for true"
	aLeSnippetTextChanged source value == true
		ifTrue: [ self coderViewModel coder currentSourceTextSynchronously: self snippetModel text ]
		ifFalse: [ self coderViewModel coder currentSourceText: self snippetModel text ]
]

{ #category : #accessing }
LeTextCoderSnippetViewModel >> shouldShowMarkup [
	^ shouldShowMarkup
]

{ #category : #accessing }
LeTextCoderSnippetViewModel >> shouldShowMarkup: aBoolean [
	shouldShowMarkup := aBoolean
]

{ #category : #accessing }
LeTextCoderSnippetViewModel >> snippetElementClass [
	^ LeTextCoderSnippetElement
]

{ #category : #'api - snippet model' }
LeTextCoderSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.

	self coderViewModel coder announcer weak
		when: GtCoderSourceCodeChanged
		send: #onCoderSourceModified:
		to: self.

	self snippetModel weak
		when: LeSnippetTextChanged
		send: #onSnippetTextChanged:
		to: self
]

{ #category : #'api - snippet model' }
LeTextCoderSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.
	
	self coderViewModel coder unsubscribe: self.
	self snippet unsubscribe: self
]
