Class {
	#name : #LeInsertContentCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeInsertContentCommandExamples >> createInsertEmptyFirstSnippetInPageCommand [
	<gtExample>
	| command |
	
	command := self targetPage commandBuilder insertChildSnippetCommand
		snippetTypeName: LeTextSnippet name.
	
	self assert: command uid notNil.
	self 
		assert: command initialSnippetState attributeNames
		equals: #(uid).
	self 
		assert: command insertPath isAtLastChildPosition.
	
	^ command
]

{ #category : #accessing }
LeInsertContentCommandExamples >> executeInsertEmptyFirstSnippetInPageCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyFirstSnippetInPageCommand.
	result := command execute.
	
	self assert: self targetPage children size equals: 1.
	self assert: self targetPage editHistory eventStore size equals: 1.
	self assert: self targetPage children first string equals: ''.

	^ result
]
