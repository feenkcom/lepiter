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
		assertStructure: { #snippet -> self modifiedStringValue }  
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
		equals: self initialStringValue.
	
	^ undoSpecification
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> initialStringValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> initialTargetSnippet [
	^ self pharoCodeSnippetWithString: self initialStringValue
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder editTextualSnippetCommand
		text: self modifiedStringValue asRopedText
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> modifiedStringValue [
	^ self subclassResponsibility
]
