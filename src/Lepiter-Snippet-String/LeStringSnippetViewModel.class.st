Class {
	#name : #LeStringSnippetViewModel,
	#superclass : #LeTextualSnippetViewModel,
	#instVars : [
		'textCoder',
		'textCoderViewModel'
	],
	#category : #'Lepiter-Snippet-String'
}

{ #category : #accessing }
LeStringSnippetViewModel >> bindingName [
	^ self snippetModel bindingName
]

{ #category : #accessing }
LeStringSnippetViewModel >> bindingName: aNameString [
	^ self snippetModel bindingName: aNameString
]

{ #category : #accessing }
LeStringSnippetViewModel >> coderViewModel [
	^ textCoderViewModel
]

{ #category : #accessing }
LeStringSnippetViewModel >> contentString [
	^ self snippetModel contentString
]

{ #category : #accessing }
LeStringSnippetViewModel >> contentString: aString [
	^ self snippetModel contentString: aString
]

{ #category : #accessing }
LeStringSnippetViewModel >> format [
	^ self snippet format
]

{ #category : #accessing }
LeStringSnippetViewModel >> format: aFormatString [
	^ self snippet format: aFormatString
]

{ #category : #initialization }
LeStringSnippetViewModel >> initialize [
	super initialize.

	textCoder := GtTextCoder new.
	textCoder parser: LeParser.
	textCoderViewModel := textCoder asCoderViewModel.
	textCoderViewModel completionStrategy: LeCompletionStrategy new.
	textCoderViewModel
		addStyler: (LeTextCoderStyler new
				lepiterStyler: (LeSnippetStyler new snippetViewModel: self)).

	self initializeCoderAddOns: textCoderViewModel
]

{ #category : #initialization }
LeStringSnippetViewModel >> initializeCoderAddOns: aTextualCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"

	
]

{ #category : #'api - snippet' }
LeStringSnippetViewModel >> moveCursorAt: aCursorPosition [
	"Move the cursor at the given position of the textual snippet"

	self coderViewModel moveCursorTo: aCursorPosition
]

{ #category : #'private - event handling' }
LeStringSnippetViewModel >> onCoderSourceModified: aGtCoderSourceCodeChanged [
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
LeStringSnippetViewModel >> onFocusChanged: aBoolean [
	self coderViewModel focused: aBoolean
]

{ #category : #'api - snippet model' }
LeStringSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self snippetChildren: (self snippetModel children collect: [ :eachChildSnippet | eachChildSnippet asSnippetViewModel ]).

	textCoder
		sourceCodeSynchronously: (GtCoderExplicitTextSource new text: self snippetModel text copyWithoutExternalReferences).
	self coderViewModel completionStrategy database: self snippetModel database.
]

{ #category : #'private - event handling' }
LeStringSnippetViewModel >> onSnippetTextChanged: aLeSnippetTextChanged [
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
LeStringSnippetViewModel >> requestStyleSourceText [
	textCoder requestStyleSourceText
]

{ #category : #accessing }
LeStringSnippetViewModel >> snippetElementClass [
	^ LeStringSnippetElement
]

{ #category : #'api - snippet model' }
LeStringSnippetViewModel >> subscribeToSnippetModel [
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
LeStringSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.
	
	self coderViewModel coder unsubscribe: self.
	self snippet unsubscribe: self
]
