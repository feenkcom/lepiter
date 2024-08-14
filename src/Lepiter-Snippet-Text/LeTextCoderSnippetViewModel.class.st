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

{ #category : #'filter view' }
LeTextCoderSnippetViewModel >> collapsedTextPromise [
	^ self coderViewModel coderModel ast
		then: [ :each | 
			| string text index |
			string := self snippetModel contentAsString asString.
			text := string asRopedText.
			self leHighlighter
				ifNotNil: [ :highlighter | highlighter style: text ast: each ast ].
			index := self indexOfHighlightIn: text.
			LeSnippetStyler new
				snippetViewModel: self;
				style: text ast: each ast.
			self clipTextIn: text around: index ]
]

{ #category : #'filter view' }
LeTextCoderSnippetViewModel >> expandedElement [
	| element |
	element := super expandedElement.
	element padding: element padding + (BlInsets left: 6).
	^ element
]

{ #category : #initialization }
LeTextCoderSnippetViewModel >> initialize [
	super initialize.
	
	shouldShowMarkup := false.
	
	textCoder := GtTextCoder new.
	textCoder parser: LeParser.
	textCoderViewModel := textCoder asCoderViewModel.
	textCoderViewModel completionStrategy: LeCompletionStrategy new.
	textCoderViewModel addStyler: (LeTextCoderStyler new lepiterStyler: (LeSnippetStyler new snippetViewModel: self)).

	self initializeCoderAddOns: textCoderViewModel
]

{ #category : #'api - snippet model' }
LeTextCoderSnippetViewModel >> initializeCoderAddOns: aTextualCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"

	aTextualCoderViewModel
		"Lose focus LeSnippet"
		addShortcut: (BrEditorShortcut loseFocus combination: (self keyboardShortcut: #LoseFocus));
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
		addShortcut: (BrEditorShortcut lineEnding combination: (self keyboardShortcut: #SecondaryNewLine));
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
	| changedText editCommand |
	aGtCoderSourceCodeChanged source = self ifTrue: [ ^ self ].
	
	changedText := aGtCoderSourceCodeChanged coder currentSourceText.
	self snippetModel text characters = changedText characters ifTrue: [ 
		"In case the content is identical we issue no command. 
		This can happen if multiple view models are opened on the same
		snippet model. When the second view model updates it should not
		trigger any new command."
		^ self ].
	
	editCommand := aGtCoderSourceCodeChanged textEditCommand 
		ifNil: [
			(self snippetModel commandBuilder editTextualSnippetCommand
				string: changedText asString
				withSource: self -> aGtCoderSourceCodeChanged isSynchronous) ]
		ifNotNil: [
			self snippetModel commandBuilder editTextValueSnippetCommand
				textEditCommand: aGtCoderSourceCodeChanged textEditCommand;
				source: self -> aGtCoderSourceCodeChanged isSynchronous ].
	
	editCommand execute
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
		sourceCodeSynchronously: (GtCoderExplicitTextSource new text: self snippetModel text copyWithoutExternalReferences).
	self coderViewModel completionStrategy database: self snippetModel database.
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
		ifTrue: [ 
			self coderViewModel coder 
				currentSourceTextSynchronously: self snippetModel text ]
		ifFalse: [ 
			self coderViewModel coder 
				currentSourceText: self snippetModel text
				withEditCommand: aLeSnippetTextChanged textEditCommand
			
			"aLeSnippetTextChanged textEditCommand
				ifNil: [	
					self coderViewModel coder 
						currentSourceText: self snippetModel text ]
				ifNotNil: [ :aTextEditCommand | 
					self coderViewModel 
						applyTextEditCommand: aTextEditCommand ]" ]
]

{ #category : #'api - text' }
LeTextCoderSnippetViewModel >> requestStyleSourceText [
	textCoder requestStyleSourceText
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
