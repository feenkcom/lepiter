Class {
	#name : #LeEditTextSnippetCommandExamples,
	#superclass : #LeEditSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #testing }
LeEditTextSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditTextSnippetCommandExamples
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
LeEditTextSnippetCommandExamples >> executeEditSnippetCommand_pageStructure [
	<gtExample>
	
	self executeEditSnippetCommand.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { #snippet -> self newStringValue }  
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
	self assertEditedSnippetMetadataFor: self targetSnippet.

	^ self targetPage
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
		equals: self initialTargetSnippet string.
	
	^ undoSpecification
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> initialTargetSnippet [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder editTextualSnippetCommand
		text: self newStringValue asRopedText
]

{ #category : #accessing }
LeEditTextSnippetCommandExamples >> newStringValue [
	^ self subclassResponsibility
]
