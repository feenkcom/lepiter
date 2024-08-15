Class {
	#name : #LeStringSnippetViewModel,
	#superclass : #LeCodeSnippetViewModel,
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
LeStringSnippetViewModel >> initializeCoderAddOns: aTextualCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"

	super initializeCoderAddOns: aTextualCoderViewModel.
	
	aTextualCoderViewModel
		"Indent LeSnippet"
		addShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move Snippet up"
		addShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Move Snippet down"
		addShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown))
]

{ #category : #'api - snippet model' }
LeStringSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.

	self updateResultVariableBindings
]

{ #category : #'api - snippet model' }
LeStringSnippetViewModel >> onStringBindingNameChanged: anAnnouncement [
	LeBindingNameUpdater new
		oldName: anAnnouncement oldName;
		newName: anAnnouncement newName;
		newValue: self contentString; 
		bindings: self snippetBindings;
		onSuccess: [ self announce: anAnnouncement ];
		update
]

{ #category : #'private - announcement handling' }
LeStringSnippetViewModel >> onStringFormatChanged: anAnnouncement [
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
LeStringSnippetViewModel >> parser [
	^ self snippetModel parser
]

{ #category : #'filter view' }
LeStringSnippetViewModel >> parserClass [
	^ self parser class
]

{ #category : #'api - accessing' }
LeStringSnippetViewModel >> selectParserClass: aParserClass [
	self hasSnippetModel ifFalse: [ ^ self ].
	self snippetModel selectParserClass: aParserClass
]

{ #category : #'api - shared context' }
LeStringSnippetViewModel >> sharedSnippetContext: aLeSharedSnippetContext [
	super sharedSnippetContext: aLeSharedSnippetContext.
	
	self updateResultVariableBindings
]

{ #category : #accessing }
LeStringSnippetViewModel >> snippetElementClass [
	^ LeStringSnippetElement
]

{ #category : #'api - snippet model' }
LeStringSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.

	self snippetModel announcer weak
		when: LeStringFormatChanged
		send: #onStringFormatChanged:
		to: self;
		when: LeStringBindingNameChanged
		send: #onStringBindingNameChanged:
		to: self
]

{ #category : #'api - snippet model' }
LeStringSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.

	self snippetModel announcer unsubscribe: self
]

{ #category : #'private - updating' }
LeStringSnippetViewModel >> updateResultVariableBindings [
	LeBindingNameUpdater new
		newName: self bindingName;
		newValue: self contentString;
		bindings: self snippetBindings;
		update
]
