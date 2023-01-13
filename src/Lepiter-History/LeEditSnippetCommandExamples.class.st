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
	self assertFullMetadataSetForSnippet: aSnippet.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertEditedTargetSnippetMetadata [
	self assertEditedSnippetMetadataFor: self targetSnippet.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertOnlyEditTimestampMetadataFor: aSnippet [ 
	self assert: aSnippet createTime isNil.
	self assert: aSnippet editTime notNil.
	
	self assert: aSnippet createEmail isNil.
	self assert: aSnippet editEmail isNil.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertTargetPageContentChanged [
	self assert: self targetPage children size equals: 1.
	self 
		assert: self targetPage children first children size 
		equals: 0.
	
	self assertTargetSnippetContentChanged.
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertTargetSnippetContentChanged [
	self subclassResponsibility
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

{ #category : #'setup  pages' }
LeEditSnippetCommandExamples >> createTargetDatabase [
	^ LeDatabase new 
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

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand_pageStructure [
	<gtExample>
	
	self executeEditSnippetCommand.
	
	self assertOneEventInPageHistory.
	self assertTargetPageContentChanged.
	self assertTargePageIsSerialisable.
	self assertEditedTargetSnippetMetadata.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeEditSnippetCommandExamples >> executeEditSnippetCommand_undoSpecification [
	<gtExample>
	| result undoSpecification |
	
	result := self executeEditSnippetCommand.
	undoSpecification := result undoSpecification.
	
	self 
		assert: undoSpecification contentUid 
		equals: self targetSnippet uid.
	self 
		assert: undoSpecification commandTypeName 
		equals: LeEditGenericSnippetCommand name.
	
	^ undoSpecification
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
