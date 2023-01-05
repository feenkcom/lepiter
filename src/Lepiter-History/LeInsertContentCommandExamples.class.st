Class {
	#name : #LeInsertContentCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeInsertContentCommandExamples >> assertInsertAtFirstChildPositionFor: aCommand [ 
	self 
		assert: aCommand insertPath isAtFirstChildPosition.
]

{ #category : #asserting }
LeInsertContentCommandExamples >> assertInsertNewSnipperAfterChildUidCommandFor: aCommand [ 
	self assertValidCommandFor: aCommand.
	self assertInsertStateOnlyHasUidFor: aCommand. 
	self assert: aCommand insertPath isAfterChildUidPosition.
]

{ #category : #asserting }
LeInsertContentCommandExamples >> assertInsertNewSnipperAfterFirstCommandFor: aCommand [ 
	self assertValidCommandFor: aCommand.
	self assertInsertStateOnlyHasUidFor: aCommand. 
	self assertInsertAtFirstChildPositionFor: aCommand.
]

{ #category : #asserting }
LeInsertContentCommandExamples >> assertInsertStateOnlyHasUidFor: aCommand [
	self 
		assert: aCommand initialSnippetState attributeNames
		equals: #(uid). 
]

{ #category : #asserting }
LeInsertContentCommandExamples >> assertOneEventInPageHistory [
	self assert: self targetPage editHistory eventStore size equals: 1.
]

{ #category : #'examples - setup' }
LeInsertContentCommandExamples >> createInsertEmptyChildSnippetInParentBetweenSnippetsCommand [
	<gtExample>
	| command |
	
	self ensureTargetSnippetWithTwoChildSnippets.
	command := self targetSnippet commandBuilder insertChildSnippetCommand
		snippetTypeName: LeTextSnippet name;
		insertAfter: self targetSnippet children first.
		
	self assertInsertNewSnipperAfterChildUidCommandFor: command.
	
	^ command
]

{ #category : #'examples - setup' }
LeInsertContentCommandExamples >> createInsertEmptyFirstChildSnippetInParentWithSnippetsCommand [
	<gtExample>
	| command |
	
	self ensureTargetSnippetWithOneChild.
	command := self targetSnippet commandBuilder insertChildSnippetCommand
		snippetTypeName: LeTextSnippet name;
		insertFirst.
	
	self assertInsertNewSnipperAfterFirstCommandFor: command.
	
	^ command
]

{ #category : #'examples - setup' }
LeInsertContentCommandExamples >> createInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand [
	<gtExample>
	| command |
	
	self ensureTargetPageWithOneSnippet.
	command := self targetSnippet commandBuilder insertChildSnippetCommand
		snippetTypeName: LeTextSnippet name;
		insertFirst.
	
	self assertInsertNewSnipperAfterFirstCommandFor: command.
	
	^ command
]

{ #category : #'examples - setup' }
LeInsertContentCommandExamples >> createInsertEmptyFirstSnippetInPageCommand [
	<gtExample>
	| command |
	
	command := self targetPage commandBuilder insertChildSnippetCommand
		snippetTypeName: LeTextSnippet name.
	
	self assertValidCommandFor: command.
	self assertInsertStateOnlyHasUidFor: command. 
	self assert: command insertPath isAtLastChildPosition.
	
	^ command
]

{ #category : #'examples - setup' }
LeInsertContentCommandExamples >> createInsertEmptySnippetBetweenSnippetsInPageCommand [
	<gtExample>
	| command |
	
	self ensureTargetPageWithTwoSnippets.
	command := self targetPage commandBuilder insertChildSnippetCommand
		snippetTypeName: LeTextSnippet name;
		insertAfter:  self targetSnippet.
	
	self assertInsertNewSnipperAfterChildUidCommandFor: command.
	
	^ command
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> ensureTargetPageWithOneSnippet [
	<gtExample>
	| targetPage |
	
	targetPage := self targetPage.
	targetPage addSnippet: (self textSnippetWithString: 'Target').
	
	^ targetPage
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> ensureTargetPageWithTwoSnippets [
	<gtExample>
	| targetPage |
	
	targetPage := self targetPage.
	targetPage addSnippet: (self textSnippetWithString: 'Target').
	targetPage addSnippet: (self textSnippetWithString: 'A').
	
	^ targetPage
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> ensureTargetSnippetWithOneChild [
	<gtExample>
	| targetSnippet targetPage |
	
	targetSnippet := self textSnippetWithString: 'Target'.
	
	targetPage := self targetPage.
	targetPage addSnippet: targetSnippet.
	targetSnippet addSnippet: (self textSnippetWithString: 'ChildA').

	^ targetPage
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> ensureTargetSnippetWithTwoChildSnippets [
	<gtExample>
	| targetSnippet targetPage |
	
	targetSnippet := self textSnippetWithString: 'Target'.
	
	targetPage := self targetPage.
	targetPage addSnippet: targetSnippet.
	targetSnippet addSnippet: (self textSnippetWithString: 'ChildA').
	targetSnippet addSnippet: (self textSnippetWithString: 'ChildB').

	^ targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyChildSnippetInParentBetweenSnippetsCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyChildSnippetInParentBetweenSnippetsCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetT -> ('Target' -> 
				{
					#snippetA -> 'ChildA'.
					#snippetNew -> ''.
					#snippetB -> 'ChildB'})} 
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstChildSnippetInParentWithSnippetsCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyFirstChildSnippetInParentWithSnippetsCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetT -> ('Target' -> 
				{
					#snippetNew -> ''.
					#snippetA -> 'ChildA'})} 
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetT -> ('Target' -> 
				{#snippetNew -> ''})} 
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstSnippetInPageCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyFirstSnippetInPageCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetNew -> ''} 
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptySnippetBetweenSnippetsInPageCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptySnippetBetweenSnippetsInPageCommand.
	result := command execute.
	
	self assertOneEventInPageHistory.
	self 
		assertStructure: { 
			#snippetT -> 'Target'.
			#snippetNew -> ''.
			#snippetA -> 'A'} 
		forContent: self targetPage.

	^ self targetPage
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> targetSnippet [
	self targetPage allChildrenBreadthFirstDo: [ :aSnippet |
		aSnippet string = 'Target' ifTrue: [ ^ aSnippet ] ].
	
	NotFound signal.
]

{ #category : #utils }
LeInsertContentCommandExamples >> textSnippetWithString: aString [ 
	^ (LeTextSnippet string: aString)
		uid: LeUID new;
		yourself
]
