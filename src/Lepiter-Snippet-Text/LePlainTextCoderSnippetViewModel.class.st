Class {
	#name : #LePlainTextCoderSnippetViewModel,
	#superclass : #LeTextualSnippetViewModel,
	#instVars : [
		'textCoder',
		'textCoderViewModel'
	],
	#category : #'Lepiter-Snippet-Text-Snippet'
}

{ #category : #accessing }
LePlainTextCoderSnippetViewModel >> coderViewModel [
	^ textCoderViewModel
]

{ #category : #'filter view' }
LePlainTextCoderSnippetViewModel >> expandedElement [
	| element |
	element := super expandedElement.
	element padding: element padding + (BlInsets left: 6).
	^ element
]

{ #category : #initialization }
LePlainTextCoderSnippetViewModel >> initialize [
	super initialize.
	self initializeTextCoderViewModel.
	self initializeCoderAddOns: textCoderViewModel
]

{ #category : #initialization }
LePlainTextCoderSnippetViewModel >> initializeCoderAddOns: aTextualCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"

	aTextualCoderViewModel
		"Lose focus LeSnippet"
		addShortcut: BrEditorShortcut loseFocus;
		"Indent LeSnippet"
		addShortcut: LeSnippetIndentSnippetShortcut new;
		"Unindent LeSnippet"
		addShortcut: LeSnippetUnindentSnippetShortcut new;
		"Move snippet up"
		addShortcut: LeSnippetMoveSnippetUpShortcut new;
		"Move snippet down"
		addShortcut: LeSnippetMoveSnippetDownShortcut new;
		"Split the current snippet"
		addShortcut: LeSnippetSplitSnippetShortcut new;
		"New Line in LeSnippet"
		addShortcut: BrEditorShortcut lineEnding;
		"Delete previous character, or merge with previous block"
		addShortcut: LeSnippetDeletePreviousShortcut new;
		"Delete next character, or merge with following block"
		addShortcut: LeSnippetDeleteNextShortcut new;
		"Primary-R -> Rename"
		addShortcut: LeSnippetRenameSnippetShortcut new.
]

{ #category : #initialization }
LePlainTextCoderSnippetViewModel >> initializeTextCoderViewModel [
	self subclassResponsibility
]

{ #category : #'api - snippet' }
LePlainTextCoderSnippetViewModel >> moveCursorAt: aCursorPosition [
	"Move the cursor at the given position of the textual snippet"

	self coderViewModel moveCursorTo: aCursorPosition
]

{ #category : #'private - event handling' }
LePlainTextCoderSnippetViewModel >> onCoderSourceModified: aGtCoderSourceCodeChanged [
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
LePlainTextCoderSnippetViewModel >> onFocusChanged: aBoolean [
	super onFocusChanged: aBoolean.
	self coderViewModel focused: aBoolean
]

{ #category : #'api - snippet model' }
LePlainTextCoderSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self snippetChildren: (self snippetModel children collect: [ :eachChildSnippet | eachChildSnippet asSnippetViewModel ]).

	textCoder
		sourceCodeSynchronously: (GtCoderExplicitTextSource new text: self snippetModel text copyWithoutExternalReferences).
]

{ #category : #'private - event handling' }
LePlainTextCoderSnippetViewModel >> onSnippetTextChanged: aLeSnippetTextChanged [
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
LePlainTextCoderSnippetViewModel >> requestStyleSourceText [
	textCoder requestStyleSourceText
]

{ #category : #'api - snippet model' }
LePlainTextCoderSnippetViewModel >> subscribeToSnippetModel [
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
LePlainTextCoderSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.
	
	self coderViewModel coder unsubscribe: self.
	self snippet unsubscribe: self
]
