"
# Textual Snippet View Model
Is a text oriented {{gtClass:LeSnippetViewModel}}.
Textual snippets support merging, splitting and seamless cursor navigation between them.

"
Class {
	#name : #LeTextualSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> focusDueToNavigationDown [
	super focusDueToNavigationDown.
	
	self moveCursorAtStart
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> focusDueToNavigationUp [
	super focusDueToNavigationUp.
	
	self moveCursorAtEnd
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> mergeWithNext [
	"Try to merge the contents of the receiver with the next textual snippet (the next sibling, or the parent's next)
	if they are of the same type."
	
	self snippetsCollectionDo: [ :aSnippetsCollection |
		self snippetModel 
			nextSnippetDo: [ :nextSnippet |
				self snippetModel class = nextSnippet class
					ifTrue: [
						| mergedSnippet newSnippetViewModel thisSnippetTextSize |
					
						thisSnippetTextSize := self snippetModel text size.
						mergedSnippet := self snippetModel 
							mergeAndRemoveSelfOrSnippetThroughCommandFor: nextSnippet.
					
						newSnippetViewModel := aSnippetsCollection findOrCreateSnippetViewModel: mergedSnippet.
						newSnippetViewModel focused: true.
						newSnippetViewModel moveCursorAt: thisSnippetTextSize ] ] 
			ifNone: [ ] ]
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> mergeWithPrevious [
	"Try to merge the contents of the receiver with the previous textual snippet (the previous sibling, or the parent's previous)
	if they are of the same type."

	self snippetsCollectionDo: [ :aSnippetsCollection |
		self snippetModel 
			previousSnippetDo: [ :previousSnippet |
				self snippetModel class = previousSnippet class
					ifTrue: [
						| mergedSnippet newSnippetViewModel previousSnippetTextSize |
						
						previousSnippetTextSize := previousSnippet text size.
						mergedSnippet := previousSnippet 
							mergeAndRemoveSelfOrSnippetThroughCommandFor: self snippetModel.
						
						newSnippetViewModel := aSnippetsCollection findOrCreateSnippetViewModel: mergedSnippet.
						newSnippetViewModel focused: true.
						newSnippetViewModel moveCursorAt: previousSnippetTextSize ] ] 
			ifNone: [ ] ]
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> moveCursorAt: aCursorPosition [
	"Move the cursor at the given position of the textual snippet if applicable.
	If a custom snippet is not supposed to handle cursor movement programmatically implement this method and leave it empty"

	self subclassResponsibility
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> moveCursorAtEnd [
	"Move the cursor at the end of the textual snippet"

	self moveCursorAt: self snippetModel text size
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> moveCursorAtStart [
	"Move the cursor at the start of the textual snippet"

	self moveCursorAt: 0
]

{ #category : #private }
LeTextualSnippetViewModel >> notifyCursorsChanged: aBrTextEditorCursor from: aSourceObject [
	self announce: (LeTextualSnippetCursorsChanged new cursors: aBrTextEditorCursor; source: aSourceObject)
]

{ #category : #'api - accessing' }
LeTextualSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	
	^ super snippetView beParagraphWidth
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> splitAt: aCursorPosition [
	"Split the block being edited at the current cursor position. Children stay with the receiver.
	This means:
	- creating a new block before the receiver's block and adding the text before the cursor.
	- deleting the text before the cursor in the receiver's block"

	self snippetsCollectionDo: [ :aSnippetsCollection | 
		| currentSnippetText |
		currentSnippetText := self snippetModel text copy.
		
		(aCursorPosition isZero and: [ currentSnippetText isNotEmpty ])
			ifTrue: [ ^ self splitAtStart ].
		aCursorPosition = currentSnippetText size
			ifTrue: [ ^ self splitAtEnd ].
		self splitAtCursorPosition: aCursorPosition ]
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> splitAtCursorPosition: aCursorPosition [

	self snippetsCollectionDo: [ :aSnippetsCollection | 
		| splitCommand splitResult newSnippetViewModel |
		
		splitCommand := self snippetModel 
			splitSnippetCommandAtPosition:  aCursorPosition.
		splitResult := splitCommand execute.
		
		newSnippetViewModel := aSnippetsCollection
			findOrCreateSnippetViewModel: splitResult insertedSnippet.
		newSnippetViewModel focused: false.
		
		self focused: true.
		self moveCursorAtStart.
		aSnippetsCollection scrollToViewModel: self ]
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> splitAtEnd [
	"Splitting a textual snippet at the end creates a new snippet that is either:
	- a sibling of the receiver if there are no children.
	- the first child of the receiver.
	We give focus to the newly created snippet"

	self snippetsCollectionDo: [ :aSnippetsCollection |
		| newSnippet newSnippetViewModel |
		
		newSnippet := self 
			addChildOrSiblingSnippetBasedOn: self snippetModel.
		
		newSnippetViewModel := aSnippetsCollection findOrCreateSnippetViewModel: newSnippet.
		newSnippetViewModel focused: true.
		newSnippetViewModel moveCursorAtStart.
		aSnippetsCollection scrollToViewModel: newSnippetViewModel ]
]

{ #category : #'api - snippet' }
LeTextualSnippetViewModel >> splitAtStart [
	"When splitting at the start of the snippet we want a new snippet above the current one"

	self snippetsCollectionDo: [ :aSnippetsCollection |
		| newSnippet newSnippetViewModel |
		
		newSnippet := self 
			addSnippetBeforeSelfBasedOn: self snippetModel.
		
		newSnippetViewModel := aSnippetsCollection findOrCreateSnippetViewModel: newSnippet.
		newSnippetViewModel focused: true.
		newSnippetViewModel moveCursorAtStart ]
]
