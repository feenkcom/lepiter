Class {
	#name : #LeRemoveContentCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #asserting }
LeRemoveContentCommandExamples >> assertValidRemoveContentCommandFor: aCommand [ 
	self assertValidCommandFor:  aCommand.
	self assert: aCommand childSnippet notNil.
	self assert: aCommand targetContent notNil.
]

{ #category : #'examples - commands' }
LeRemoveContentCommandExamples >> createDeleteSnippetWithChildrenInPageCommand [
	<gtExample>
	| command |
	
	self ensureTargetSnippetInPageWithSiblingsAndChildrenStructure.
	command := self targetPage commandBuilder 
		removeChildSnippetCommandFor: self targetSnippet.
	
	self assertValidRemoveContentCommandFor: command.
	
	^ command
]

{ #category : #'examples - commands' }
LeRemoveContentCommandExamples >> createDeleteSnippetWithNoChildrenInPageCommand [
	<gtExample>
	| command |
	
	self ensureTargetPageWithTwoBasicSnippetsAndFirstTarget.
	command := self targetPage commandBuilder 
		removeChildSnippetCommandFor: self targetSnippet.
	
	self assertValidRemoveContentCommandFor: command.
	
	^ command
]

{ #category : #'examples - commands' }
LeRemoveContentCommandExamples >> createDeleteSnippetWithNoChildrenInParentSnippetCommand [
	<gtExample>
	| command |
	
	self ensureTargetSnippetInParentSnippetWithSiblingSnipet.
	command := self targetSnippet parent commandBuilder 
		removeChildSnippetCommandFor: self targetSnippet.
	
	self assertValidRemoveContentCommandFor: command.
	
	^ command
]

{ #category : #'examples - setup  pages' }
LeRemoveContentCommandExamples >> ensureTargetSnippetInPageWithSiblingsAndChildrenStructure [
	<gtExample>
	| targetSnippet targetPage childASnippet |
	
	targetSnippet := self textSnippetWithString: 'Target'.
	
	targetPage := self targetPage.
	targetPage addSnippet: (self textSnippetWithString: 'A').
	targetPage addSnippet: targetSnippet.
	targetSnippet addSnippet: (childASnippet := self textSnippetWithString: 'ChildA').
	targetSnippet addSnippet: (self textSnippetWithString: 'ChildB').
	
	childASnippet
		addSnippet: (self textSnippetWithString: 'ChildA-A');
		addSnippet: (self textSnippetWithString: 'ChildA-B').

	^ targetPage
]

{ #category : #'examples - setup  pages' }
LeRemoveContentCommandExamples >> ensureTargetSnippetInParentSnippetWithSiblingSnipet [
	<gtExample>
	| parentSnippet targetPage |
	
	parentSnippet := self textSnippetWithString: 'A'.
	
	targetPage := self targetPage.
	targetPage addSnippet: parentSnippet.
	parentSnippet addSnippet: (self textSnippetWithString: 'Target').
	parentSnippet addSnippet: (self textSnippetWithString: 'ChildB').

	^ targetPage
]

{ #category : #'examples - execution' }
LeRemoveContentCommandExamples >> executeDeleteSnippetWithChildrenInPageCommand [
	<gtExample>
	| command result |
	
	command := self createDeleteSnippetWithChildrenInPageCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetA -> 'A'} 
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeRemoveContentCommandExamples >> executeDeleteSnippetWithNoChildrenInPageCommand [
	<gtExample>
	| command result |
	
	command := self createDeleteSnippetWithNoChildrenInPageCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetA -> 'A'} 
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeRemoveContentCommandExamples >> executeDeleteSnippetWithNoChildrenInParentSnippetCommand [
	<gtExample>
	| command result |
	
	command := self createDeleteSnippetWithNoChildrenInParentSnippetCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetA -> ('A' -> {
				#snippetB -> 'ChildB'})} 
		forContent: self targetPage.

	^ self targetPage
]
