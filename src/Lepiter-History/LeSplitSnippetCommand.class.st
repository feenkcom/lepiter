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
	| builder command |
	
	builder := self targetSnippet parent commandBuilder.
	command := builder 
		insertChildSnippetOfTypeCommandForType: self targetSnippet class.
	command insertBefore: self targetSnippet. 
	command initialSnippetState
		addAttribute: (LeTextSnippetStringAttribute new
			string: aSnippetText asString).
	
	self addSubcommand: command 
]

{ #category : #initialization }
LeSplitSnippetCommand >> addUpdateSnippetCommandWithtext: aSnippetText [ 
	| editCommand |
	editCommand := self targetSnippet commandBuilder editSnippetCommand.
	editCommand string: aSnippetText asString.
	
	self addSubcommand: editCommand.
]

{ #category : #execution }
LeSplitSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [ 
		self executeSubcommands ]
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
LeSplitSnippetCommand >> createCommandSpecification [
	^ LeGenericCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetContent uid;
		commandTypeName: self className;
		attributeAt: #cursorPosition put: self cursorPosition;
		yourself
]

{ #category : #'execution - utils' }
LeSplitSnippetCommand >> createUndoCommandSpecification [
	| specification | 
	specification := LeCompositeCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetContent uid;
		commandTypeName: self className;
		label: 'Undo Split'.
	
	self subcommands do: [ :aSubcommand |
		 specification 
		 	addSubcommandSpecification: aSubcommand createUndoCommandSpecification ].
	
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

{ #category : #accessing }
LeSplitSnippetCommand >> label [
	^ 'Split Snippet'
]

{ #category : #initialization }
LeSplitSnippetCommand >> splitAtCursorPosition: aCursorPosition [
	| currentSnippetText newSnippetText existingSnippetNewText |
	self assert: [ subcommands isEmpty ].
	
	currentSnippetText := self targetSnippet text copy.
	newSnippetText := currentSnippetText copyFrom: 1 to: aCursorPosition.
	self addInsertNewSnippetAboveCommandWithText: newSnippetText.
		
	existingSnippetNewText := self 
		computeCurrentSnippetTextFrom: currentSnippetText 
		atPosition: aCursorPosition.
	self addUpdateSnippetCommandWithtext: existingSnippetNewText.
]
