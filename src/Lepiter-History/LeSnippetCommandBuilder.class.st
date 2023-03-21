Class {
	#name : #LeSnippetCommandBuilder,
	#superclass : #LeCommandBuilder,
	#category : #'Lepiter-History-Builders'
}

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> appendSnippetContentCommand [ 
	^ LeAppendSnippetContentCommand forSnippet: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> editSnippetStateCommand [ 
	^ LeEditGenericSnippetCommand new
		targetContent: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> editTextValueSnippetCommand [ 
	^ LeEditTextValueSnippetCommand new
		targetContent: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> editTextualSnippetCommand [ 
	^ LeTextualEditSnippetCommand new
		targetContent: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> indentSnippetCommand [ 
	^ LePageIndentSnippetCommand forSnippet: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> mergeSnippetCommandWith: aNextSnippet [
	self assert: [ self targetContent class = aNextSnippet class ].
	
	^ LeMergeSnippetCommand merge: self targetContent with: aNextSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> moveDownSnippetCommand [ 
	^ LePageMoveDownSnippetCommand forSnippet: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> moveUpSnippetCommand [ 
	^ LePageMoveUpSnippetCommand forSnippet: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> splitSnippetCommandAtPosition: aCursorPosition [
	^ LeSplitSnippetCommand 
		splitSnippet: self targetSnippet
		atCursorPosition: aCursorPosition
]

{ #category : #accessing }
LeSnippetCommandBuilder >> targetSnippet [
	^ self targetContent
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> transferChildrenFromSnippetCommand [
	^ LeTransferChildrenFromSnippetCommand forSnippet: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> transferChildrenToSnippetCommand [
	^ LeTransferChildrenToSnippetCommand forSnippet: self targetSnippet
]

{ #category : #accessing }
LeSnippetCommandBuilder >> undoSnippetStateCommand [
	^ self editSnippetStateCommand
		snippetState: self targetSnippet extractUpdatableState
]

{ #category : #'as yet unclassified' }
LeSnippetCommandBuilder >> undoSnippetStateCommandBasedOnState: aSnippetState [ 
	^ self editSnippetStateCommand
		snippetState: (self targetSnippet 
			extractUpdatableStateBasedOnState: aSnippetState )
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> unindentSnippetCommand [ 
	^ LePageUnindentSnippetCommand forSnippet: self targetSnippet
]

{ #category : #accessing }
LeSnippetCommandBuilder >> updateSnippetStateCommandBasedOn: aNewSnippet [
	self assert: [ aNewSnippet  notNil ].
	self assert: [ self targetContent class = aNewSnippet class ].
	
	^ self editSnippetStateCommand
		snippetState: aNewSnippet extractSpecificState
]
