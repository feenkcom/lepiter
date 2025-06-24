Class {
	#name : #LeEditSnippetStateCommandExamples,
	#superclass : #LeEditSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditSnippetStateCommandExamples class >> isAbstract [ 
	^ self name = #LeEditSnippetStateCommandExamples
]

{ #category : #'examples - commands' }
LeEditSnippetStateCommandExamples >> attributesForUndo [
	^ #(createTime createEmail editTime editEmail), self changedStateAttributes
]

{ #category : #'examples - commands' }
LeEditSnippetStateCommandExamples >> changedStateAttributes [
	self subclassResponsibility
]

{ #category : #'examples - commands' }
LeEditSnippetStateCommandExamples >> createEditSnippetCommand [
	<gtExample>
	<return: #SubclassResponsibility>
	| command |
	command := super createEditSnippetCommand.

	self
		assert: command snippetState attributeNames sorted
		equals: self changedStateAttributes sorted.

	^ command
]

{ #category : #'examples - execution undo/redo' }
LeEditSnippetStateCommandExamples >> executeCommand_executeUndoCommand [
	<gtExample>
	<return: #SubclassResponsibility>
	| result |
	result := super executeCommand_executeUndoCommand.

	self assertExecutionResultFor: result targetCommandResult.
	self
		assert: result targetCommandResult undoSpecification snippetState
				shouldTransformForLogStorage not.

	^ result
]

{ #category : #'examples - execution' }
LeEditSnippetStateCommandExamples >> executeEditSnippetCommand_undoSpecification [
	<gtExample>
	<return: #SubclassResponsibility>
	| undoSpecification |
	undoSpecification := super executeEditSnippetCommand_undoSpecification.

	self
		assert: undoSpecification commandTypeName
		equals: LeEditGenericSnippetCommand name.

	^ undoSpecification
]

{ #category : #'examples - execution' }
LeEditSnippetStateCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	<return: #SubclassResponsibility>
	| command result initialSnippetState undoSpecification |
	command := self createEditSnippetCommand.
	initialSnippetState := self targetSnippet
			extractUpdatableStateBasedOnState: command snippetState.
	result := command execute.

	undoSpecification := result undoSpecification.

	self assert: (undoSpecification snippetState hasAttributeNamed: #uid) not.
	self
		assert: undoSpecification snippetState attributeNames sorted
		equals: self attributesForUndo sorted.

	self assert: initialSnippetState equals: undoSpecification snippetState.

	^ undoSpecification
]
