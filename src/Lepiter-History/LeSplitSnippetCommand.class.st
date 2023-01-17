Class {
	#name : #LeSplitSnippetCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'cursorPosition'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #'instance creation' }
LeSplitSnippetCommand class >> splitSnippet: aTargetSnippet atCursorPosition: aCursorPosition [
	^ (self forSnippet: aTargetSnippet)
		splitAtCursorPosition: aCursorPosition
]

{ #category : #'initialization - commands' }
LeSplitSnippetCommand >> addInsertNewSnippetAboveCommandWithText: aSnippetText [
	| command |
	
	command := self targetSnippet 
		insertSnippetBeforeSelfCommandOfType: self targetSnippet class.
	command initialSnippetState
		addAttribute: (LeTextualSnippetTextAttribute new
			text: aSnippetText).
	
	self addSubcommand: command 
]

{ #category : #initialization }
LeSplitSnippetCommand >> addUpdateSnippetCommandWithText: aSnippetText [ 
	| editCommand |
	editCommand := self targetSnippet commandBuilder editTextualSnippetCommand.
	editCommand string: aSnippetText asString.
	
	self addSubcommand: editCommand.
]

{ #category : #execution }
LeSplitSnippetCommand >> basicExecute [ 
	| undoSpecification subcommandResults |
	
	subcommandResults := self executeSubcommands.
	undoSpecification := self 
		createUndoCommandSpecificationFromResults: subcommandResults.
	
	^ self createCommandResult 
		undoSpecification: undoSpecification;
		insertedSnippet: subcommandResults first insertedSnippet.
]

{ #category : #utils }
LeSplitSnippetCommand >> computeCurrentSnippetTextFrom: aText atPosition: aCursorPosition [
	| snippetText |
	snippetText := aText
		copyFrom: aCursorPosition + 1
		to: aText size.
	snippetText trimmer
		leftLineBreaks;
		trim.
	^ snippetText
]

{ #category : #'execution - utils' }
LeSplitSnippetCommand >> createCommandResult [
	^ LeSplitSnippetCommandResult forCommand: self
]

{ #category : #'execution - utils' }
LeSplitSnippetCommand >> createCommandSpecification [
	^ LeGenericCommandSpecification new 
		contentUid: self targetContent uid;
		commandTypeName: self className;
		attributeAt: #cursorPosition put: self cursorPosition;
		yourself
]

{ #category : #'execution - utils' }
LeSplitSnippetCommand >> createUndoCommandSpecificationFromResults: subcommandResults [
	| specification | 
	specification := LeCompositeCommandSpecification new 
		contentUid: self targetContent uid;
		commandTypeName: LeGenericCompositeCommand name;
		label: 'Undo Split'.
	
	subcommandResults do: [ :aSubcommandResult |
		 specification 
		 	addSubcommandSpecification: aSubcommandResult undoSpecification ].
	
	^ specification
]

{ #category : #accessing }
LeSplitSnippetCommand >> cursorPosition [
	^ cursorPosition
]

{ #category : #'gt - extensions' }
LeSplitSnippetCommand >> gtViewSubcommandsFor: aView [ 
	<gtView>
	
	^ aView list 
		title: 'Subcommands';
		items: [ self subcommands ]
]

{ #category : #initialization }
LeSplitSnippetCommand >> initializeFromSpecification: aCommandSpecification withBuilder: aBuilder [
	super initializeFromSpecification: aCommandSpecification withBuilder: aBuilder.
	
	self splitAtCursorPosition: (aCommandSpecification 
		attributeAt: #cursorPosition)
]

{ #category : #accessing }
LeSplitSnippetCommand >> label [
	^ 'Split Snippet'
]

{ #category : #initialization }
LeSplitSnippetCommand >> splitAtCursorPosition: aCursorPosition [
	| currentSnippetText newSnippetText existingSnippetNewText |
	
	self assert: [ subcommands isEmpty ].
	self assert: [ aCursorPosition isZero not ].
	self assert: [ aCursorPosition ~= self targetSnippet text size ].
	
	cursorPosition := aCursorPosition.
	
	currentSnippetText := self targetSnippet text copy.
	newSnippetText := currentSnippetText copyFrom: 1 to: aCursorPosition.
	self addInsertNewSnippetAboveCommandWithText: newSnippetText.
		
	existingSnippetNewText := self 
		computeCurrentSnippetTextFrom: currentSnippetText 
		atPosition: aCursorPosition.
	self addUpdateSnippetCommandWithText: existingSnippetNewText.
]
