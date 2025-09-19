Trait {
	#name : #TEditTextValueTextSnippetCommandExample,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
TEditTextValueTextSnippetCommandExample >> executeCommand_executeUndoCommand_textIdentity [
	<gtExample>
	<return: #LeRestoreContentCommandExecutionResult>
	<return: #LeRestoreContentCommandExecutionResult>
	<return: #LeRestoreContentCommandExecutionResult>
	<return: #LeRestoreContentCommandExecutionResult>
	<return: #LeRestoreContentCommandExecutionResult>
	<return: #LeRestoreContentCommandExecutionResult>
	<return: #Error>
	| command initialText result |
	command := self createEditSnippetCommand.
	initialText := self targetSnippet text.

	command execute.
	result := self targetPage editHistory undoCurrent.

	self
		assert: initialText identityHash
		equals: self targetSnippet text identityHash.

	^ result
]

{ #category : #accessing }
TEditTextValueTextSnippetCommandExample >> executeEditSnippetCommand_textIdentity [
	<gtExample>
	<return: #LeCommandExecutionResult>
	<return: #LeCommandExecutionResult>
	<return: #LeCommandExecutionResult>
	<return: #LeCommandExecutionResult>
	<return: #LeCommandExecutionResult>
	<return: #LeCommandExecutionResult>
	<return: #Error>
	| command initialText result |
	command := self createEditSnippetCommand.
	initialText := self targetSnippet text.

	result := command execute.

	self
		assert: initialText identityHash
		equals: self targetSnippet text identityHash.

	^ result
]

{ #category : #accessing }
TEditTextValueTextSnippetCommandExample >> initialTargetSnippet [
	^ self textSnippetWithString: self initialStringValue
]
