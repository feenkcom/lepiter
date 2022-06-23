Class {
	#name : #LeCoderTextElement,
	#superclass : #BlElement,
	#instVars : [
		'snippetElement'
	],
	#category : #'Lepiter-UI-Coder'
}

{ #category : #'instance-creation' }
LeCoderTextElement class >> coderElementFor: aString [
	"Answer a snippet element for the supplied string"

	^ self new initializeForText: aString
]

{ #category : #initialization }
LeCoderTextElement >> initializeForText: aString [
	| snippet viewModel snippetView |

	snippet := LeTextSnippet builder string: aString; build.
	viewModel := snippet asSnippetViewModel.
	viewModel coderViewModel addShortcut: 
		(BrEditorShortcut lineEnding combination: (LeSnippetElement keyboardShortcut: #NewLine)).
	snippetView := viewModel snippetView.
	snippetView needsEmbellishments: false.
	snippetElement := snippetView asElement.
	snippetElement vMatchParent.
	snippetElement snippetViewModel: viewModel.
	snippetElement padding: (BlInsets all: 10).

	self constraintsDo: [ :c |
		c vertical matchParent.
		c horizontal matchParent. ].
	self addChild: snippetElement.
]

{ #category : #accessing }
LeCoderTextElement >> page [ 
	"Answer the page used to hold the receiver's string"

	^ snippetElement page
]
