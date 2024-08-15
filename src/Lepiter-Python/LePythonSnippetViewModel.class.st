Class {
	#name : #LePythonSnippetViewModel,
	#superclass : #LeCodeSnippetViewModel,
	#category : #'Lepiter-Python-Snippet'
}

{ #category : #initialization }
LePythonSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"

	aCoderViewModel
		"Create New snippet (after the current snippet)"
		addShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #SplitSnippet));
		"Delete previous character, or merge with previous snippet"	
		addShortcut: (LeSnippetDeletePreviousShortcut new combination: (self keyboardShortcut: #DeletePrevious));
		"Indent LeSnippet"
		addShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move Snippet up"
		addShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Move Snippet down"
		addShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown))
]

{ #category : #'api - bindings' }
LePythonSnippetViewModel >> onSelfObjectChanged [
	coderViewModel selfObject: sharedContext selfObject
]

{ #category : #'filter view' }
LePythonSnippetViewModel >> parserClass [
	^ PythonParser
]

{ #category : #'api - bindings' }
LePythonSnippetViewModel >> sharedSnippetContext: aLeSharedSnippetContext [
	sharedContext unsubscribe: self.

	super sharedSnippetContext: aLeSharedSnippetContext.
	self onSelfObjectChanged.

	aLeSharedSnippetContext
		whenSelfObjectChangedSend: #onSelfObjectChanged
		to: self
]

{ #category : #accessing }
LePythonSnippetViewModel >> snippetElementClass [
	^ LePythonSnippetElement
]
