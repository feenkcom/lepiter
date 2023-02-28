Class {
	#name : #LeEditExampleSnippetCommandExamples,
	#superclass : #LeEditSnippetStateCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #testing }
LeEditExampleSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditExampleSnippetCommandExamples
]

{ #category : #asserting }
LeEditExampleSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self assert: (self targetSnippet similarTo: self initialModifiedSnippet)
]

{ #category : #'examples - commands' }
LeEditExampleSnippetCommandExamples >> createEditSnippetCommand [
	<gtExample>
	| command |
	
	command := super createEditSnippetCommand. 
		
	self 
		assert: command snippetState attributeNames size 
		equals: 7.
	self 
		assert: command snippetState attributeNames sorted 
		equals: #(codeExpanded exampleBehaviorName exampleSelector noCode previewExpanded previewHeight previewShowSelector).
	
	^ command
]

{ #category : #'examples - execution' }
LeEditExampleSnippetCommandExamples >> executeEditSnippetCommand_undoState [
	<gtExample>
	| command initialSnippetState result undoSpecification |
	
	command := self createEditSnippetCommand.
	initialSnippetState := self targetSnippet extractUpdatableState.
	result := command execute.
	
	undoSpecification := result undoSpecification.
			
	self assert: (undoSpecification snippetState hasAttributeNamed: #uid) not.
	self assert: undoSpecification snippetState attributesCount equals: 11.
	self assert: initialSnippetState equals: undoSpecification snippetState.
	
	^ undoSpecification
]

{ #category : #accessing }
LeEditExampleSnippetCommandExamples >> initialModifiedSnippet [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditExampleSnippetCommandExamples >> instantiateEditSnippetCommand [
	^ self targetSnippet commandBuilder  
		updateSnippetStateCommandBasedOn:  self initialModifiedSnippet.
]
