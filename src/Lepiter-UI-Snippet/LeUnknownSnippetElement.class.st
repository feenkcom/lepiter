Class {
	#name : #LeUnknownSnippetElement,
	#superclass : #LeTextualSnippetElement,
	#instVars : [
		'editorElement'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #accessing }
LeUnknownSnippetElement >> editor [
	^ editorElement editor
]

{ #category : #initialization }
LeUnknownSnippetElement >> initialize [
	super initialize.

	self initializeTextEditor.
	self initializeTextEditorShortcuts
]

{ #category : #initialization }
LeUnknownSnippetElement >> initializeTextEditor [
	editorElement := BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		styler: JSONParser gtStyler;
		padding: (BlInsets top: 0 left: 2 bottom: 0 right: 0).

	editorElement editor addEventHandler: (LeEditorReachedBorderEventHandler new snippetElement: self).

	editorElement editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onTextEditorModified: anEvent ].
]

{ #category : #initialization }
LeUnknownSnippetElement >> initializeTextEditorShortcuts [
	"Initialise the receiver's text editor shortcuts"
	
	editorElement
		"Create New snippet (after the current snippet)"
		addEditorShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #SplitSnippet));
		"Delete previous character, or merge with previous snippet"
		addEditorShortcut: (LeSnippetDeletePreviousShortcut new combination: (self keyboardShortcut: #DeletePrevious));
		"Delete next character, or merge with following snippet"
		addEditorShortcut: (LeSnippetDeleteNextShortcut new combination: (self keyboardShortcut: #DeleteNext));
		"New Line in LeSnippet"
		addEditorShortcut: (BrEditorShortcut lineEnding combination: (self keyboardShortcut: #NewLine));
		"Lose focus LeSnippet"
		addEditorShortcut: (BrEditorShortcut loseFocus combination: (self keyboardShortcut: #LoseFocus));
		"Indent LeSnippet"
		addEditorShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addEditorShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move snippet up"
		addEditorShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Alt-Shift-Down -> Move snippet down"
		addEditorShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown));
		"Primary-R -> Rename"
		addEditorShortcut: (LeSnippetRenameSnippetShortcut new combination: (self keyboardShortcut: #RenameSnippet)).
]

{ #category : #'api - snippet view model' }
LeUnknownSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self updateEditorText
]

{ #category : #'api - snippet view model' }
LeUnknownSnippetElement >> onSnippetViewModelFocused: aBoolean [
	aBoolean
		ifTrue: [ editorElement requestFocus ]
		ifFalse: [ editorElement loseFocus ]
]

{ #category : #'private - event handling' }
LeUnknownSnippetElement >> onTextEditorModified: anEvent [
	"I am triggered when a editor's text is modified"

	self snippet jsonString: anEvent text asString source: self
]

{ #category : #'api - view' }
LeUnknownSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ editorElement
]

{ #category : #'api - view' }
LeUnknownSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ nil
]

{ #category : #'private - updating' }
LeUnknownSnippetElement >> updateEditorText [
	"Update the receiver's editor.
	As this can be called from an announcement it may be in any process (not just the UI process)"

	(self snippet hasText and: [ 
		self snippet jsonString = editorElement text characters ]) 
			ifTrue: [ ^ self ].

	self enqueueTask: (BlTaskAction new action: [ 	editorElement text: self text asRopedText ])
]
