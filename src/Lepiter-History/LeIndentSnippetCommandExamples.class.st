"
Examples for the ident command.

We start from this page:

{{gtExample:name=LeIndentSnippetCommandExamples>>createTargetPage|noCode=true|previewShow=#gtLiveFor:|previewHeight=180}}

Identing the Target snippet results in:

{{gtExample:name=LeIndentSnippetCommandExamples>>executeIndentSnippetCommand|noCode=true|previewShow=#gtLiveFor:|previewHeight=180}}
"
Class {
	#name : #LeIndentSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #'examples - commands' }
LeIndentSnippetCommandExamples >> createIndentSnippetCommand [
	<gtExample>
	<return: #LePageIndentSnippetCommand>
	| targetSnippet command |
	targetSnippet := self targetPage children second.
	command := targetSnippet indentCommand.

	self assertCommand: command forSnippet: targetSnippet.

	^ command
]

{ #category : #'examples - execution' }
LeIndentSnippetCommandExamples >> executeIndentSnippetCommand [
	<gtExample>
	<return: #LePage>
	| command page initialTargetSnippet result |
	command := self createIndentSnippetCommand.
	page := self targetPage.
	initialTargetSnippet := page children second.

	result := command execute.

	self assert: page children size equals: 1.
	self assert: page editHistory eventStore size equals: 1.

	self assert: page children first children first == initialTargetSnippet.

	self assertStructure: self modifiedPageStructure forContent: page.

	^ page
]

{ #category : #accessing }
LeIndentSnippetCommandExamples >> modifiedPageStructure [
	^ { 
		#snippetA -> ('A' -> 
			 {#snippetT -> 'Target'})}
]
