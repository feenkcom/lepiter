Class {
	#name : #LeEditPharoSnippetCommandExamples,
	#superclass : #LeEditSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #testing }
LeEditPharoSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditPharoSnippetCommandExamples
]

{ #category : #'examples - commands' }
LeEditPharoSnippetCommandExamples >> createEditSnippetCommand [
	<gtExample>
	| targetSnippet command |
	
	self ensurePageWithTargetSnippet.
	targetSnippet := self targetPage children first.
	command := targetSnippet commandBuilder editTextualSnippetCommand
		text: self newStringValue asRopedText. 
		
	self assertValidCommandFor: command.
	self 
		assert: command snippetState attributeNames size 
		equals: 1.
	self 
		assert: command snippetState attributeNames 
		equals: #(string).
	
	^ command
]

{ #category : #'examples - setup  pages' }
LeEditPharoSnippetCommandExamples >> ensurePageWithTargetSnippet [
	<gtExample>
	| page |
	
	page := self targetPage.
	page addSnippet: self initialTargetSnippet. 
	
	^ page
]

{ #category : #'examples - execution' }
LeEditPharoSnippetCommandExamples >> executeEditSnippetCommand [
	<gtExample>
	| command result |
	
	command := self createEditSnippetCommand.
	result := command execute.
	
	self assertExecutionResultFor: result.
	
	^ result
]

{ #category : #'examples - commands' }
LeEditPharoSnippetCommandExamples >> executeEditSnippetCommand_pageStructure [
	<gtExample>
	
	self executeEditSnippetCommand.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { #snippet -> self newStringValue }  
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
	"self assertEditedSnippetMetadataFor: self targetSnippet."

	^ self targetPage
]

{ #category : #'examples - commands' }
LeEditPharoSnippetCommandExamples >> executeEditSnippetCommand_undoSpecification [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditSnippetCommand.
	undoSpecification := result undoSpecification.
	
	self 
		assert: undoSpecification contentUid 
		equals: self targetSnippet uid.
	self 
		assert: undoSpecification commandTypeName 
		equals: LeEditGenericSnippetCommand name.
	
	^ undoSpecification
]

{ #category : #'examples - commands' }
LeEditPharoSnippetCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditSnippetCommand.
	undoSpecification := result undoSpecification.
	
	self assert: undoSpecification snippetState attributesCount equals: 5.		
	self assert: (undoSpecification snippetState hasAttributeNamed: #uid) not.
	self 
		assert: (undoSpecification snippetState attributeNamed: 'code') attributeValue
		equals: self initialTargetSnippet string.
	
	^ undoSpecification
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> initialTargetSnippet [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> newStringValue [
	^ self subclassResponsibility
]
