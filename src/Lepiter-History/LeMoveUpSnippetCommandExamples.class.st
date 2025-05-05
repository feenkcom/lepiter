Class {
	#name : #LeMoveUpSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeMoveUpSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeMoveUpSnippetCommandExamples
]

{ #category : #'examples - commands' }
LeMoveUpSnippetCommandExamples >> createMoveUpSnippetCommand [
	<gtExample>
	<return: #NotFound>
	| targetSnippet command |
	targetSnippet := self targetSnippet.
	command := targetSnippet commandBuilder moveUpSnippetCommand.

	self assertCommand: command forSnippet: targetSnippet.

	^ command
]

{ #category : #'examples - execution' }
LeMoveUpSnippetCommandExamples >> executeMoveUpSnippetCommand [
	<gtExample>
	<return: #NotFound>
	| command page initialTargetSnippet result |
	command := self createMoveUpSnippetCommand.
	page := self targetPage.
	initialTargetSnippet := self targetSnippet.

	result := command execute.

	self assert: page children size equals: 2.
	self assert: page editHistory eventStore size equals: 1.

	self
		assert: self targetSnippet == initialTargetSnippet
		description: 'Snippet identity should be preserved'.

	self assertStructure: self modifiedPageStructure forContent: page.

	^ page
]

{ #category : #accessing }
LeMoveUpSnippetCommandExamples >> modifiedPageStructure [
	^ self subclassResponsibility
]
