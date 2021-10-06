Class {
	#name : #LePharoSnippetViewModel,
	#superclass : #LeCodeSnippetViewModel,
	#category : 'Lepiter-Pharo-Snippet'
}

{ #category : #initialization }
LePharoSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
	"Initialise the keyboard shortcuts in the code editor"
	
	aCoderViewModel localBindings
		localAt: #thisSnippetViewModel
		put: self.

	aCoderViewModel localBindings
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

{ #category : #'api - bindings' }
LePharoSnippetViewModel >> onSelfObjectChanged [
	coderViewModel selfObject: sharedContext selfObject
]

{ #category : #'api - bindings' }
LePharoSnippetViewModel >> sharedSnippetContext: aLeSharedSnippetContext [
	sharedContext unsubscribe: self.
	
	super sharedSnippetContext: aLeSharedSnippetContext.

	coderViewModel
		sharedBindings: aLeSharedSnippetContext sharedBindings;
		selfObject: aLeSharedSnippetContext selfObject.
		
	aLeSharedSnippetContext whenSelfObjectChangedSend: #onSelfObjectChanged to: self
]

{ #category : #accessing }
LePharoSnippetViewModel >> snippetElementClass [
	^ LePharoSnippetElement
]
