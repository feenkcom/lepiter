Class {
	#name : #LeEditSnippetStateCommandExamples,
	#superclass : #LeEditSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #'examples - execution undo/redo' }
LeEditSnippetStateCommandExamples >> executeCommand_executeUndoCommand [
	<gtExample>
	| result |
	
	result := super executeCommand_executeUndoCommand.
	
	self assertExecutionResultFor: result targetCommandResult.
	self assert: result targetCommandResult undoSpecification 
		snippetState shouldTransformForLogStorage not.
	
	^ result
]

{ #category : #'examples - execution' }
LeEditSnippetStateCommandExamples >> executeEditSnippetCommand_undoSpecification [
	<gtExample>
	| undoSpecification |
	
	undoSpecification := super executeEditSnippetCommand_undoSpecification.
	
	self 
		assert: undoSpecification commandTypeName 
		equals: LeEditGenericSnippetCommand name.
	
	^ undoSpecification
]
