Class {
	#name : #LeShellScriptSnippetViewModel,
	#superclass : #LeCodeSnippetViewModel,
	#category : #'Lepiter-Snippet-Shell'
}

{ #category : #accessing }
LeShellScriptSnippetViewModel >> bindingName [
	^ self snippetModel bindingName
]

{ #category : #initialization }
LeShellScriptSnippetViewModel >> initializeCoderAddOns: aCoderViewModel [
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

{ #category : #'api - accessing' }
LeShellScriptSnippetViewModel >> snippetElementClass [
	^ LeShellScriptSnippetElement
]
