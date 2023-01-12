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
LeSnippetCommandBuilder >> transferChildrenCommand [
	^ LeTransferSnippetChildrenCommand forSnippet: self targetSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> transferChildrenCommandFrom: anotherSnippet [
	^ self transferChildrenCommand
		sourceSnippet: anotherSnippet
]

{ #category : #'build - commands' }
LeSnippetCommandBuilder >> unindentSnippetCommand [ 
	^ LePageUnindentSnippetCommand forSnippet: self targetSnippet
]
