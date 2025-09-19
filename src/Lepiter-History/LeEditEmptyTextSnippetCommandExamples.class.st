"
{{gtClass:LeEditTextSnippetCommandExamples}}  has examples for editing a text snippet from a page that is contained within a database.
"
Class {
	#name : #LeEditEmptyTextSnippetCommandExamples,
	#superclass : #LeEditTextSnippetCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeEditEmptyTextSnippetCommandExamples >> executeCommand_executeUndo_executeRedoCommand [
	<gtExample>
	<return: #LeRestoreContentCommandExecutionResult>
	| command initialSnippetState result |
	command := self createEditSnippetCommand.
	initialSnippetState := self targetSnippet extractUpdatableState.

	command execute.
	self targetPage editHistory undoCurrent.
	result := self targetPage editHistory redoCurrent.

	self assertExecutionResultFor: result.

	^ result
]

{ #category : #accessing }
LeEditEmptyTextSnippetCommandExamples >> initialStringValue [
	^ ''
]

{ #category : #accessing }
LeEditEmptyTextSnippetCommandExamples >> modifiedStringValue [
	^ 'a'
]
