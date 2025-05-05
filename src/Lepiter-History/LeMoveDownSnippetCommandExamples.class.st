Class {
	#name : #LeMoveDownSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeMoveDownSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeMoveDownSnippetCommandExamples
]

{ #category : #'examples - commands' }
LeMoveDownSnippetCommandExamples >> createMoveDownSnippetCommand [
	<gtExample>
	<return: #NotFound>
	| targetSnippet command |
	targetSnippet := self targetSnippet.
	command := targetSnippet commandBuilder moveDownSnippetCommand.

	self assertCommand: command forSnippet: targetSnippet.

	^ command
]

{ #category : #'examples - execution' }
LeMoveDownSnippetCommandExamples >> executeMoveDownSnippetCommand [
	<gtExample>
	<return: #NotFound>
	| command page initialTargetSnippet result |
	command := self createMoveDownSnippetCommand.
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
LeMoveDownSnippetCommandExamples >> modifiedPageStructure [
	self subclassResponsibility
]
