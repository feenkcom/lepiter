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

{ #category : #accessing }
LeEditPharoSnippetCommandExamples >> changedStateAttributes [
	^ #(code)
]

{ #category : #'examples - execution' }
LeEditPharoSnippetCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	| undoSpecification |
	
	undoSpecification := super executeEditSnippetCommand_undoState.
	
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
