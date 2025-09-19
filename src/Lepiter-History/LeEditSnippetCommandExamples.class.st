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
	<return: #SubclassResponsibility>
	| command |
	self ensurePageWithTargetSnippet.
	command := self instantiateEditSnippetCommand.

	self assertValidCommandFor: command.

	^ command
]

{ #category : #'examples - setup  pages' }
LeEditSnippetCommandExamples >> ensurePageWithTargetSnippet [
	<gtExample>
	<return: #SubclassResponsibility>
	| page |
	page := self targetPage.
	page addSnippet: self initialTargetSnippet.

	^ page
]

{ #category : #'examples - execution undo/redo' }
LeEditSnippetCommandExamples >> executeCommand_executeUndoCommand [
	<gtExample>
	<return: #SubclassResponsibility>
	| command initialSnippetState result |
	command := self createEditSnippetCommand.
	initialSnippetState := self targetSnippet extractUpdatableState.

	command execute.
	result := self targetPage editHistory undoCurrent.

	self
		assert: self targetSnippet extractUpdatableState
		equals: initialSnippetState.

	self assertExecutionResultFor: result.

	^ result
]

{ #category : #'examples - execution undo/redo' }
LeEditSnippetCommandExamples >> executeCommand_executeUndoCommand_editHistory [
	<gtExample>
	<return: #SubclassResponsibility>
	| editHistory |
	self executeCommand_executeUndoCommand.

	editHistory := self targetPage editHistory.
	self assert: editHistory eventStore events size equals: 2.
	self assert: editHistory undoActions size equals: 0.
	self assert: editHistory redoActions size equals: 1.

	^ self targetPage
]

{ #category : #'examples - execution undo/redo' }
LeEditSnippetCommandExamples >> executeCommand_executeUndo_executeRedoCommand [
	<gtExample>
	<return: #SubclassResponsibility>
	| result |
	self executeCommand_executeUndoCommand.

	result := self targetPage editHistory redoCurrent.

	self assertExecutionResultFor: result.

	^ result
]

{ #category : #'examples - execution undo/redo' }
LeEditSnippetCommandExamples >> executeCommand_executeUndo_executeRedoCommand_editHistory [
	<gtExample>
	<return: #SubclassResponsibility>
	| editHistory |
	self executeCommand_executeUndo_executeRedoCommand.

	editHistory := self targetPage editHistory.
	self assert: editHistory eventStore events size equals: 3.
	self assert: editHistory undoActions size equals: 1.
	self assert: editHistory redoActions size equals: 0.

	^ self targetPage
]

{ #category : #'examples - execution undo/redo' }
LeEditSnippetCommandExamples >> executeCommand_executeUndo_executeRedoCommand_pageStructure [
	<gtExample>
	<return: #SubclassResponsibility>
	self executeCommand_executeUndo_executeRedoCommand.

	self assertTargetPageContentChanged.
	self assertTargePageIsSerialisable.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand [
	<gtExample>
	<return: #SubclassResponsibility>
	| command result |
	command := self createEditSnippetCommand.
	result := command execute.

	self assertExecutionResultFor: result.

	^ result
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand_pageStructure [
	<gtExample>
	<return: #SubclassResponsibility>
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
	<return: #SubclassResponsibility>
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
	<return: #SubclassResponsibility>
	| result undoSpecification |
	result := self executeEditSnippetCommand.
	undoSpecification := result undoSpecification.

	self assert: undoSpecification contentUid equals: self targetSnippet uid.

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
