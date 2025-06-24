"
Examples for the unident command.

We start from this page:

{{gtExample:name=LeUnindentSnippetCommandExamples>>createTargetPage|noCode=true|previewShow=#gtLiveFor:|previewHeight=180}}

Unidenting the Target snippet results in:

{{gtExample:name=LeUnindentSnippetCommandExamples>>executeUnindentSnippetCommand|noCode=true|previewShow=#gtLiveFor:|previewHeight=180}}
"
Class {
	#name : #LeUnindentSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #'examples - commands' }
LeUnindentSnippetCommandExamples >> createUnindentSnippetCommand [
	<gtExample>
	<return: #LePageUnindentSnippetCommand>
	| targetSnippet command |
	targetSnippet := self targetPage children first children first.
	command := targetSnippet commandBuilder unindentSnippetCommand.

	self assertCommand: command forSnippet: targetSnippet.

	^ command
]

{ #category : #'examples - execution' }
LeUnindentSnippetCommandExamples >> executeUnindentSnippetCommand [
	<gtExample>
	<return: #LePage>
	| command page initialTargetSnippet result |
	command := self createUnindentSnippetCommand.
	page := self targetPage.
	initialTargetSnippet := page children first children first.

	result := command execute.

	self assert: page children size equals: 2.
	self assert: page editHistory eventStore size equals: 1.

	self assert: page children second == initialTargetSnippet.

	self assertStructure: self modifiedPageStructure forContent: page.

	^ page
]

{ #category : #accessing }
LeUnindentSnippetCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> 'A'.
		#snippetT -> 'Target'}
]
