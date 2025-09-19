Class {
	#name : #LeEditCodeSnippetCommandExamples,
	#superclass : #LeEditSnippetStateCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditCodeSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditCodeSnippetCommandExamples
]

{ #category : #asserting }
LeEditCodeSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self 
		assertStructure: { #snippet -> self modifiedStringValue }  
		forContent: self targetPage.
]

{ #category : #accessing }
LeEditCodeSnippetCommandExamples >> changedStateAttributes [
	^ #(code)
]

{ #category : #'examples - execution' }
LeEditCodeSnippetCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	<return: #SubclassResponsibility>
	| undoSpecification |
	undoSpecification := super executeEditSnippetCommand_undoState.

	self
		assert: (undoSpecification snippetState attributeNamed: 'code') attributeValue
		equals: self initialStringValue.

	^ undoSpecification
]

{ #category : #accessing }
LeEditCodeSnippetCommandExamples >> initialStringValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditCodeSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder editTextualSnippetCommand
		code: self modifiedStringValue
]

{ #category : #accessing }
LeEditCodeSnippetCommandExamples >> modifiedStringValue [
	^ self subclassResponsibility
]
