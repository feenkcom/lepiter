Class {
	#name : #LeEditElementSnippetCommandExamples,
	#superclass : #LeEditSnippetStateCommandExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #testing }
LeEditElementSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditElementSnippetCommandExamples
]

{ #category : #asserting }
LeEditElementSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self assert: (self targetSnippet 
		similarTo: self initialModifiedSnippet)
]

{ #category : #accessing }
LeEditElementSnippetCommandExamples >> attributesForUndo [
	^ #(createTime createEmail editTime editEmail), self changedStateAttributes
]

{ #category : #accessing }
LeEditElementSnippetCommandExamples >> changedStateAttributes [
	self subclassResponsibility
]

{ #category : #'examples - commands' }
LeEditElementSnippetCommandExamples >> createEditSnippetCommand [
	<gtExample>
	| command |
	
	command := super createEditSnippetCommand. 
		
	self 
		assert: command snippetState attributeNames sorted 
		equals: self changedStateAttributes sorted.
	
	^ command
]

{ #category : #'examples - commands' }
LeEditElementSnippetCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditSnippetCommand.
	undoSpecification := result undoSpecification.
	
	self assert: (undoSpecification snippetState hasAttributeNamed: #uid) not.
	self 
		assert: undoSpecification snippetState attributeNames sorted  
		equals: self attributesForUndo sorted.		
	
	^ undoSpecification
]

{ #category : #accessing }
LeEditElementSnippetCommandExamples >> initialModifiedSnippet [
	self subclassResponsibility
]
