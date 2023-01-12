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
	| command |
	
	command := super createEditSnippetCommand. 
		
	self 
		assert: command snippetState attributeNames size 
		equals: 1.
	self 
		assert: command snippetState attributeNames 
		equals: #(string).
	
	^ command
]

{ #category : #'examples - execution' }
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

{ #category : #'examples - execution' }
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
LeEditPharoSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder editTextualSnippetCommand
		text: self newStringValue asRopedText
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> newStringValue [
	^ self subclassResponsibility
]
