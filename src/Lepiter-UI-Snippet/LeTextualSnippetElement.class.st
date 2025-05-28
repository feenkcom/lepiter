"
I represent a base element for a textual snippet.
See my {{gtClass:LeTextualSnippetElement|expanded|show=#gtSubclassesFor:}} for concrete implementations.

KeyboardShortcuts holds a list of named shortcuts used by subclasses.  No keyboard shortcuts should be defined directly in subclasses to allow a different binding to be defined for non-English keyboards (if required / desired).

"
Class {
	#name : #LeTextualSnippetElement,
	#superclass : #LeSnippetElement,
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #accessing }
LeTextualSnippetElement >> editor [
	"Required by ${method:LeTextualSnippetElement>>#registerFocusEventHandlers}$"
	^ self subclassResponsibility
]

{ #category : #accessing }
LeTextualSnippetElement >> keyboardShortcut: aSymbol [
	"Answer the named keyboard shortcut"

	^ self class keyboardShortcut: aSymbol
]

{ #category : #'api - snippet' }
LeTextualSnippetElement >> mergeWithNext [
	"Request this snippet to be merged with the snippet that is below me"

	self snippetViewModel mergeWithNext
]

{ #category : #'api - snippet' }
LeTextualSnippetElement >> mergeWithPrevious [
	"Request this snippet to be merged with the snippet that is above me"

	self snippetViewModel mergeWithPrevious
]

{ #category : #'api - snippet view model' }
LeTextualSnippetElement >> onPostSnippetViewModelChanged [
	super onPostSnippetViewModelChanged.
	self snippetViewModel
		ifNotNil: [ self snippetViewModel announcer weak
				when: LeSnippetRequestRemoveSelection
				send: #removeSelection
				to: self ]
]

{ #category : #private }
LeTextualSnippetElement >> removeSelection [
	self editor ifNotNil: [ :anEditor | anEditor deselecter all deselect ]
]

{ #category : #'api - snippet' }
LeTextualSnippetElement >> splitAt: aCursorPosition [
	"Split the block being edited at the given cursor position.  Children stay with the receiver.
	This means:
	- creating a new block before the receiver's block and adding the text before the cursor.
	- deleting the text before the cursor in the receiver's block"

	self snippetViewModel splitAt: aCursorPosition
]

{ #category : #'api - snippet' }
LeTextualSnippetElement >> splitAtEnd [
	"Pressing enter at the end of the cursor creates a new block that is either:
	- a sibling of the receiver if there are no children.
	- the first child of the receiver."

	self snippetViewModel splitAtEnd
]

{ #category : #'api - snippet' }
LeTextualSnippetElement >> splitAtStart [
	"Pressing enter at the start of the line we want a new block above the current line with the cursor"

	self snippetViewModel splitAtStart
]
