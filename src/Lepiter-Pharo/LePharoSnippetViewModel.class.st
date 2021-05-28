Class {
	#name : #LePharoSnippetViewModel,
	#superclass : #LeCodeSnippetViewModel,
	#category : #'Lepiter-Pharo-Snippet'
}

{ #category : #initialization }
LePharoSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"
	
	aCoderViewModel bindingStrategy bindings
		localAt: #thisSnippetViewModel
		put: self.

	aCoderViewModel bindingStrategy bindings
		localAt: #thisSnippet
		put: self snippetModel.

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

{ #category : #'api - snippet model' }
LePharoSnippetViewModel >> setSelfObjectFromBindings [
	"Set the receiver's coderViewModel self object based on the receiver in the bindings"

	self coderViewModel selfObject: self snippetBindings receiver
]

{ #category : #'api - bindings' }
LePharoSnippetViewModel >> snippetBindings: aGtSnippetBindings [
	super snippetBindings: aGtSnippetBindings.
	
	coderViewModel sharedBindings: aGtSnippetBindings
]

{ #category : #accessing }
LePharoSnippetViewModel >> snippetElementClass [
	^ LePharoSnippetElement
]
