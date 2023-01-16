Class {
	#name : #LeEditTextSnippetCommandExamples,
	#superclass : #LeEditSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
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
LeEditTextSnippetCommandExamples >> createEditSnippetCommand [
	<gtExample>
	| command |

	command := super createEditSnippetCommand.
		
	self assert: command snippetState attributeNames size equals: 1.
	self 
		assert: command snippetState attributeNames 
		equals: #(string).
	
	^ command
]

{ #category : #'examples - execution' }
LeEditTextSnippetCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditSnippetCommand.
	undoSpecification := result undoSpecification.
	
	self assert: undoSpecification snippetState attributesCount equals: 6.		
	self assert: (undoSpecification snippetState hasAttributeNamed: #uid) not.
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
