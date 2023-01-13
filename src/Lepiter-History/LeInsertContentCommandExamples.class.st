Class {
	#name : #LeInsertContentCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeInsertContentCommandExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyTimeMetadataSetForSnippet: aSnippet 
]

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
LeInsertContentCommandExamples >> assertOnlyTimeMetadataSetForSnippetsIn: aPage [
	"Check that there are snippets in the page, otherwise this assert has no effect."
	self assert: aPage children size > 0.
	
	aPage allChildrenBreadthFirstDo:  [ :aSnippet |
		self assertOnlyTimeMetadataSetForSnippet: aSnippet ].
]

{ #category : #asserting }
LeInsertContentCommandExamples >> assertStructure: aPageStructure forInsertCommandResult: result [ 
	self assertFullMetadataSetForSnippet: result insertedSnippet.
	self assertEqualCreateEditMetadataSetForSnippet: result insertedSnippet.
	self assertOneEventInPageHistory.
	self 
		assertStructure: aPageStructure 
		forContent: self targetPage.
	self assertTargePageIsSerialisable.
]

{ #category : #asserting }
LeInsertContentCommandExamples >> assertTargetPageStateAfterChange [
	self assertOneEventInPageHistory.
	self assertTargePageIsSerialisable.
	self assertOnlyTimeMetadataSetForSnippetsIn: self targetPage.
]

{ #category : #'examples - commands' }
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

{ #category : #'examples - commands' }
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

{ #category : #'examples - commands' }
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

{ #category : #'examples - commands' }
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

{ #category : #'examples - commands' }
LeInsertContentCommandExamples >> createInsertEmptySnippetBetweenSnippetsInPageCommand [
	<gtExample>
	| command |
	
	self ensureTargetPageWithTwoBasicSnippetsAndFirstTarget.
	command := self targetPage commandBuilder insertChildSnippetCommand
		snippetTypeName: LeTextSnippet name;
		insertAfter:  self targetSnippet.
	
	self assertInsertNewSnipperAfterChildUidCommandFor: command.
	
	^ command
]

{ #category : #accessing }
LeInsertContentCommandExamples >> createTargetDatabase [
	^ LeDatabase new 
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
	
	self 
		assertStructure: { 
			#snippetT -> ('Target' -> 
				{
					#snippetA -> 'ChildA'.
					#snippetNew -> ''.
					#snippetB -> 'ChildB'})} 
		forInsertCommandResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstChildSnippetInParentWithSnippetsCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyFirstChildSnippetInParentWithSnippetsCommand.
	result := command execute.
	
	self 
		assertStructure: { 
			#snippetT -> ('Target' -> 
				{
					#snippetNew -> ''.
					#snippetA -> 'ChildA'})} 
		forInsertCommandResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand.
	result := command execute.
	
	self 
		assertStructure: { 
			#snippetT -> ('Target' -> 
				{#snippetNew -> ''})} 
		forInsertCommandResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstSnippetInPageCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptyFirstSnippetInPageCommand.
	result := command execute.
	
	self 
		assertStructure:  { 
			#snippetNew -> ''}
		forInsertCommandResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptySnippetBetweenSnippetsInPageCommand [
	<gtExample>
	| command result |
	
	command := self createInsertEmptySnippetBetweenSnippetsInPageCommand.
	result := command execute.
	
	self 
		assertStructure: { 
			#snippetT -> 'Target'.
			#snippetNew -> ''.
			#snippetA -> 'A'} 
		forInsertCommandResult: result.

	^ self targetPage
]
