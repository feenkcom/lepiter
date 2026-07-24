Class {
	#name : #LeJavaScriptSnippetViewModel,
	#superclass : #LeCodeSnippetViewModel,
	#category : #'Lepiter-JavaScript-Snippet'
}

{ #category : #initialization }
LeJavaScriptSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
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

{ #category : #'filter view' }
LeJavaScriptSnippetViewModel >> parserClass [
	^ JSParser
]

{ #category : #accessing }
LeJavaScriptSnippetViewModel >> snippetElementClass [
	^ LeJavaScriptSnippetElement
]
