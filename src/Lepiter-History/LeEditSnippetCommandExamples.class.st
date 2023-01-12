Class {
	#name : #LeEditSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #testing }
LeEditSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditSnippetCommandExamples
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyTimeMetadataSetForSnippet: aSnippet
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertOnlyEditTimestampMetadataFor: aSnippet [ 
	self assert: aSnippet createTime isNil.
	self assert: aSnippet editTime notNil.
	
	self assert: aSnippet createEmail isNil.
	self assert: aSnippet editEmail isNil.
]

{ #category : #'examples - commands' }
LeEditSnippetCommandExamples >> createEditSnippetCommand [
	<gtExample>
	| command |
	
	self ensurePageWithTargetSnippet.
	command := self instantiateEditSnippetCommand.
		
	self assertValidCommandFor: command.
	
	^ command
]

{ #category : #'examples - setup  pages' }
LeEditSnippetCommandExamples >> ensurePageWithTargetSnippet [
	<gtExample>
	| page |
	
	page := self targetPage.
	page addSnippet: self initialTargetSnippet. 
	
	^ page
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand [
	<gtExample>
	| command result |
	
	command := self createEditSnippetCommand.
	result := command execute.
	
	self assertExecutionResultFor: result.
	
	^ result
]

{ #category : #accessing }
LeEditSnippetCommandExamples >> initialTargetSnippet [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeEditSnippetCommandExamples >> instantiateEditSnippetCommand [
	self subclassResponsibility
]

{ #category : #accessing }
LeEditSnippetCommandExamples >> targetSnippet [
	^ self targetPage children first
]
