Class {
	#name : #LeEditPharoSnippetCommandExamples,
	#superclass : #LeEditSnippetStateCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditPharoSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditPharoSnippetCommandExamples
]

{ #category : #asserting }
LeEditPharoSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self 
		assertStructure: { #snippet -> self modifiedStringValue }  
		forContent: self targetPage.
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
		equals: #(code).
	
	^ command
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
		code: self modifiedStringValue
]

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> modifiedStringValue [
	^ self subclassResponsibility
]
