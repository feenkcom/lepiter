"
LeCoderCommentElement is a container for the single snippet element used when editing class comments, see {{gtClass:LePharoClassDatabase}} for more information.

LeCoderCommentElement handles the shortcuts for increasing and decreasing font size while editing.

"
Class {
	#name : #LeCoderCommentElement,
	#superclass : #BlElement,
	#traits : 'TLeWithFontSize',
	#classTraits : 'TLeWithFontSize classTrait',
	#instVars : [
		'snippetElement'
	],
	#category : #'Lepiter-UI-Coder'
}

{ #category : #'api - accessing' }
LeCoderCommentElement class >> coderElementFor: aSymbol [
	"Answer a snippet element for the supplied class name"

	^ self new initializeForClassName: aSymbol
]

{ #category : #initialization }
LeCoderCommentElement >> initializeForClassName: aSymbol [
	| page snippet viewModel snippetView |

	page := LePharoClassDatabase uniqueInstance pageNamed: aSymbol.
	snippet := page children first.
	viewModel := snippet asSnippetViewModel.
	viewModel coderViewModel addShortcut: 
		(BrEditorShortcut lineEnding combination: (LeSnippetElement keyboardShortcut: #NewLine)).
	snippetView := viewModel snippetView.
	snippetView needsEmbellishments: false.
	snippetElement := snippetView asElement.
	snippetElement vMatchParent.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).

	self initializeFontSizeShortcuts.
	self constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent. ].
	self addChild: snippetElement.

]

{ #category : #accessing }
LeCoderCommentElement >> page [ 
	"Answer the page used to hold the receiver's class comment"

	^ snippetElement page
]
