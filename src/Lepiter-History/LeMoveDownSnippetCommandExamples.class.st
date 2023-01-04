Class {
	#name : #LeMoveDownSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #testing }
LeMoveDownSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeMoveDownSnippetCommandExamples
]

{ #category : #'examples - commands' }
LeMoveDownSnippetCommandExamples >> createMoveDownSnippetCommand [
	<gtExample>
	| targetSnippet command |
	
	targetSnippet := self targetSnippet.
	command := targetSnippet commandBuilder moveDownSnippetCommand.
	
	self assertCommand: command forSnippet: targetSnippet.
	
	^ command
]

{ #category : #'examples - execution' }
LeMoveDownSnippetCommandExamples >> executeMoveDownSnippetCommand [
	<gtExample>
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
	
	self 
		assertStructure: self modifiedPageStructure
		forContent: page.

	^ page
]

{ #category : #accessing }
LeMoveDownSnippetCommandExamples >> modifiedPageStructure [
	self subclassResponsibility
]

{ #category : #'examples - setup' }
LeMoveDownSnippetCommandExamples >> targetSnippet [
	<gtExample>
	self targetPage allChildrenBreadthFirstDo: [ :aSnippet |
		aSnippet string = 'Target' ifTrue: [ ^ aSnippet ] ].
	
	NotFound signal.
]
