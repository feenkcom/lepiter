Class {
	#name : #LeEditSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditSnippetCommandExamples
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertFullMetadataSetForSnippet: aSnippet.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertEditedTargetSnippetMetadata [
	self assertEditedSnippetMetadataFor: self targetSnippet.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertOnlyEditTimestampMetadataFor: aSnippet [ 
	self assert: aSnippet createTime isNil.
	self assert: aSnippet editTime notNil.
	
	self assert: aSnippet createEmail isNil.
	self assert: aSnippet editEmail isNil.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertTargetPageContentChanged [
	self assert: self targetPage children size equals: 1.
	self 
		assert: self targetPage children first children size 
		equals: 0.
	
	self assertTargetSnippetContentChanged.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self subclassResponsibility
]

{ #category : #'examples - commands' }
LeEditSnippetCommandExamples >> createEditSnippetCommand [
	<gtExample>
	| command |
	
	self ensurePageWithTargetSnippet.
	command := self instantiateEditSnippetCommand.
		
	self assertValidCommandFor: command.
	
	^ command
]

{ #category : #'setup  pages' }
LeEditSnippetCommandExamples >> createTargetDatabase [
	^ LeDatabase new 
]

{ #category : #'examples - setup  pages' }
LeEditSnippetCommandExamples >> ensurePageWithTargetSnippet [
	<gtExample>
	| page |
	
	page := self targetPage.
	page addSnippet: self initialTargetSnippet. 
	
	^ page
]

{ #category : #'examples - execution undo/redo' }
LeEditSnippetCommandExamples >> executeCommand_executeUndoCommand [
	<gtExample>
	| command initialSnippetState editHistory |
	
	command := self createEditSnippetCommand.
	initialSnippetState := self targetSnippet extractUpdatableState.
	
	command execute.
	self targetPage editHistory undoCurrent.
	
	editHistory := self targetPage editHistory.
	self assert:  editHistory eventStore events size equals: 2.
	self assert:  editHistory undoActions size equals: 0.
	self assert:  editHistory redoActions size equals: 1.
	
	self 
		assert: self targetSnippet  extractUpdatableState
		equals: initialSnippetState.
	
	^ self targetPage 
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand [
	<gtExample>
	| command result |
	
	command := self createEditSnippetCommand.
	result := command execute.
	
	self assertExecutionResultFor: result.
	
	^ result
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand_pageStructure [
	<gtExample>
	
	self executeEditSnippetCommand.
	
	self assertOneEventInPageHistory.
	self assertTargetPageContentChanged.
	self assertTargePageIsSerialisable.
	self assertEditedTargetSnippetMetadata.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand_traceEvent [
	<gtExample>
	| result traceEvent |
	
	result := self executeEditSnippetCommand.
	traceEvent := result traceEvent.
	
	self assert: traceEvent uid notNil.
	self assert: traceEvent timestamp notNil.
	self assert: traceEvent mainCommandSpecification notNil.
	self assert: traceEvent undoCommandSpecification notNil.
	
	self 
		assert: traceEvent undoCommandSpecification identityHash
		equals: result undoSpecification identityHash.
	
	^ traceEvent
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand_undoSpecification [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditSnippetCommand.
	undoSpecification := result undoSpecification.
	
	self 
		assert: undoSpecification contentUid 
		equals: self targetSnippet uid.
	self 
		assert: undoSpecification commandTypeName 
		equals: LeEditGenericSnippetCommand name.
	
	^ undoSpecification
]

{ #category : #accessing }
LeEditSnippetCommandExamples >> initialTargetSnippet [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditSnippetCommandExamples >> instantiateEditSnippetCommand [
	self subclassResponsibility
]

{ #category : #accessing }
LeEditSnippetCommandExamples >> targetSnippet [
	^ self targetPage children first
]
