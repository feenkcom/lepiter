Class {
	#name : #LeEditTextValueSnippetCommandExamples,
	#superclass : #LeEditSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditTextValueSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditTextValueSnippetCommandExamples
]

{ #category : #asserting }
LeEditTextValueSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self 
		assert: self targetSnippet string 
		equals: self modifiedStringValue.
]

{ #category : #'examples - execution undo/redo' }
LeEditTextValueSnippetCommandExamples >> executeCommand_executeUndoCommand [
	<gtExample>
	<return: #SubclassResponsibility>
	| result |
	result := super executeCommand_executeUndoCommand.

	self assert: result targetCommandResult subcommandResults size equals: 2.
	result targetCommandResult subcommandResults
		do: [ :aResult | self assertExecutionResultFor: aResult ].

	self
		assert: result targetCommandResult subcommandResults second undoSpecification
				snippetState shouldTransformForLogStorage not.

	^ result
]

{ #category : #'examples - execution' }
LeEditTextValueSnippetCommandExamples >> executeEditSnippetCommand_undoSpecification [
	<gtExample>
	<return: #SubclassResponsibility>
	| undoSpecification |
	undoSpecification := super executeEditSnippetCommand_undoSpecification.

	self
		assert: undoSpecification commandTypeName
		equals: LeContentCompositeCommand name.
	self
		assert: undoSpecification subcommandSpecifications first commandTypeName
		equals: LeEditTextValueSnippetCommand name.
	self
		assert: undoSpecification subcommandSpecifications second commandTypeName
		equals: LeEditGenericSnippetCommand name.

	^ undoSpecification
]

{ #category : #accessing }
LeEditTextValueSnippetCommandExamples >> initialStringValue [
	self subclassResponsibility
]

{ #category : #accessing }
LeEditTextValueSnippetCommandExamples >> instantiateBasicTextEditCommand [
	self subclassResponsibility
]

{ #category : #accessing }
LeEditTextValueSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder editTextValueSnippetCommand
		textEditCommand: self instantiateBasicTextEditCommand
]

{ #category : #accessing }
LeEditTextValueSnippetCommandExamples >> modifiedStringValue [
	self subclassResponsibility
]
