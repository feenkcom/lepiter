"
{{gtClass:LeEditTextSnippetCommandInStandalonePageExamples}} has examples for editing a text snippet from a page that is not inside a database.
"
Class {
	#name : #LeEditTextSnippetCommandInStandalonePageExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeEditTextSnippetCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyTimeMetadataSetForSnippet: aSnippet
]

{ #category : #asserting }
LeEditTextSnippetCommandInStandalonePageExamples >> assertExecutionResultFor: aCommandResult [
	self assert: aCommandResult command notNil.
	self assert: aCommandResult undoSpecification notNil.
]

{ #category : #accessing }
LeEditTextSnippetCommandInStandalonePageExamples >> createEditEmptySnippetWithTextCommand [
	<gtExample>
	| targetSnippet command |
	
	self ensurePageWithTextEmptySnippet.
	targetSnippet := self targetPage children first.
	command := targetSnippet commandBuilder editTextualSnippetCommand
		text: 'a' asRopedText.
		
	self assertValidCommandFor: command.
	self assert: command snippetState attributeNames size equals: 1.
	self 
		assert: command snippetState attributeNames 
		equals: #(string).
	
	^ command
]

{ #category : #'examples - setup  pages' }
LeEditTextSnippetCommandInStandalonePageExamples >> ensurePageWithTextEmptySnippet [
	<gtExample>
	| page |
	
	page := self targetPage.
	page addSnippet: (self textSnippetWithString: ''). 
	
	^ page
]

{ #category : #'examples - execution' }
LeEditTextSnippetCommandInStandalonePageExamples >> executeEditEmptySnippetWithTextCommand [
	<gtExample>
	| command result |
	
	command := self createEditEmptySnippetWithTextCommand.
	result := command execute.
	
	self assertExecutionResultFor: result.
	
	^ result
]

{ #category : #'examples - execution' }
LeEditTextSnippetCommandInStandalonePageExamples >> executeEditEmptySnippetWithTextCommand_pageStructure [
	<gtExample>
	
	self executeEditEmptySnippetWithTextCommand.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { #snippet -> 'a' }  
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
	self assertEditedSnippetMetadataFor: self targetSnippet.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeEditTextSnippetCommandInStandalonePageExamples >> executeEditEmptySnippetWithTextCommand_undoSpecification [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditEmptySnippetWithTextCommand.
	undoSpecification := result undoSpecification.
	
	self 
		assert: undoSpecification contentUid 
		equals: self targetSnippet uid.
	self 
		assert: undoSpecification commandTypeName 
		equals: LeEditGenericSnippetCommand name.
	
	^ undoSpecification
]

{ #category : #'examples - execution' }
LeEditTextSnippetCommandInStandalonePageExamples >> executeEditEmptySnippetWithTextCommand_undoState [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditEmptySnippetWithTextCommand.
	undoSpecification := result undoSpecification.
	
	self assert: undoSpecification snippetState attributesCount equals: 6.		
	self assert: (undoSpecification snippetState hasAttributeNamed: #uid) not.
	self 
		assert: (undoSpecification snippetState attributeNamed: 'string') attributeValue
		equals: ''.
	
	^ undoSpecification
]

{ #category : #accessing }
LeEditTextSnippetCommandInStandalonePageExamples >> targetSnippet [
	^ self targetPage children first
]
