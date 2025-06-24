Class {
	#name : #LeEditTextSnippetCommandExamples,
	#superclass : #LeEditSnippetStateCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditTextSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditTextSnippetCommandExamples
]

{ #category : #asserting }
LeEditTextSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self 
		assertStructure: { #snippet -> self modifiedStringValue }  
		forContent: self targetPage.
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> changedStateAttributes [
	^ #(string)
]

{ #category : #'examples - execution' }
LeEditTextSnippetCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	<return: #SubclassResponsibility>
	| undoSpecification |
	undoSpecification := super executeEditSnippetCommand_undoState.

	self
		assert: (undoSpecification snippetState attributeNamed: 'string') attributeValue
		equals: self initialStringValue.

	^ undoSpecification
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> initialStringValue [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> initialTargetSnippet [
	^ self textSnippetWithString: self initialStringValue
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder editTextualSnippetCommand
		string: self modifiedStringValue
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> modifiedStringValue [
	^ self subclassResponsibility
]
