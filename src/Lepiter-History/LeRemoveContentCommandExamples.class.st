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
	<return: #LeContentRemoveChildSnippetCommand>
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
	<return: #LeContentRemoveChildSnippetCommand>
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
	<return: #LeContentRemoveChildSnippetCommand>
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
	<return: #LePage>
	| targetSnippet targetPage childASnippet |
	targetSnippet := self textSnippetWithString: 'Target'.

	targetPage := self targetPage.
	targetPage addSnippet: (self textSnippetWithString: 'A').
	targetPage addSnippet: targetSnippet.
	targetSnippet
		addSnippet: (childASnippet := self textSnippetWithString: 'ChildA').
	targetSnippet addSnippet: (self textSnippetWithString: 'ChildB').

	childASnippet
		addSnippet: (self textSnippetWithString: 'ChildA-A');
		addSnippet: (self textSnippetWithString: 'ChildA-B').

	^ targetPage
]

{ #category : #'examples - setup  pages' }
LeRemoveContentCommandExamples >> ensureTargetSnippetInParentSnippetWithSiblingSnipet [
	<gtExample>
	<return: #LePage>
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
	<return: #LePage>
	| command result |
	command := self createDeleteSnippetWithChildrenInPageCommand.
	result := command execute.

	self assertOneEventInPageHistory.
	self assertStructure: {#snippetA -> 'A'} forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeRemoveContentCommandExamples >> executeDeleteSnippetWithNoChildrenInPageCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createDeleteSnippetWithNoChildrenInPageCommand.
	result := command execute.

	self assertOneEventInPageHistory.
	self assertStructure: {#snippetA -> 'A'} forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeRemoveContentCommandExamples >> executeDeleteSnippetWithNoChildrenInParentSnippetCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createDeleteSnippetWithNoChildrenInParentSnippetCommand.
	result := command execute.

	self assertOneEventInPageHistory.
	self
		assertStructure: {#snippetA -> ('A' -> {#snippetB -> 'ChildB'})}
		forContent: self targetPage.

	^ self targetPage
]
