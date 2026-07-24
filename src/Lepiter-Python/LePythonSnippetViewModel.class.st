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
		addShortcut: LeSnippetSplitSnippetShortcut new;
		"Delete previous character, or merge with previous snippet"	
		addShortcut: LeSnippetDeletePreviousShortcut new;
		"Indent LeSnippet"
		addShortcut: LeSnippetIndentSnippetShortcut new;
		"Unindent LeSnippet"
		addShortcut: LeSnippetUnindentSnippetShortcut new;
		"Move Snippet up"
		addShortcut: LeSnippetMoveSnippetUpShortcut new;
		"Move Snippet down"
		addShortcut: LeSnippetMoveSnippetDownShortcut new
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
