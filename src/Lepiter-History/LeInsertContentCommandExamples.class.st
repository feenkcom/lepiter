Class {
	#name : #LeInsertContentCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples - Commands'
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
	self 
		assert: (aCommand initialSnippetState 
			attributeNamed: #uid) attributeValue notNil
]

{ #category : #asserting }
LeInsertContentCommandExamples >> assertInsertedSnippetUidInResult: aResult [ 
	self 
		assert: aResult insertedSnippet uid
		equals: (aResult command initialSnippetState 
			attributeNamed: #uid) attributeValue.
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> assertInsertedSnippetUidInResult: result forCommand: command [ 
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

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> ensureTargetPageWithOneSnippet [
	<gtExample>
	<return: #LePage>
	| targetPage |
	targetPage := self targetPage.
	targetPage addSnippet: (self textSnippetWithString: 'Target').

	^ targetPage
]

{ #category : #'examples - setup  pages' }
LeInsertContentCommandExamples >> ensureTargetSnippetWithOneChild [
	<gtExample>
	<return: #LePage>
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
	<return: #LePage>
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
	<return: #LePage>
	| command result |
	command := self createInsertEmptyChildSnippetInParentBetweenSnippetsCommand.
	result := command execute.

	self
		assertStructure: {#snippetT
					-> ('Target'
							-> {#snippetA -> 'ChildA'.
									#snippetNew -> ''.
									#snippetB -> 'ChildB'})}
		forInsertCommandResult: result.
	self assertInsertedSnippetUidInResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstChildSnippetInParentWithSnippetsCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createInsertEmptyFirstChildSnippetInParentWithSnippetsCommand.
	result := command execute.

	self
		assertStructure: {#snippetT
					-> ('Target'
							-> {#snippetNew -> ''.
									#snippetA -> 'ChildA'})}
		forInsertCommandResult: result.
	self assertInsertedSnippetUidInResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self
			createInsertEmptyFirstChildSnippetInParentWithoutSnippetsCommand.
	result := command execute.

	self
		assertStructure: {#snippetT -> ('Target' -> {#snippetNew -> ''})}
		forInsertCommandResult: result.
	self assertInsertedSnippetUidInResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstSnippetInPageByTemplateCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createInsertEmptyFirstSnippetInPageByTemplateCommand.
	result := command execute.

	self assertStructure: {#snippetNew -> ''} forInsertCommandResult: result.
	self assertInsertedSnippetUidInResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptyFirstSnippetInPageCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createInsertEmptyFirstSnippetInPageCommand.
	result := command execute.

	self assertStructure: {#snippetNew -> ''} forInsertCommandResult: result.
	self assertInsertedSnippetUidInResult: result.

	^ self targetPage
]

{ #category : #'examples - execution' }
LeInsertContentCommandExamples >> executeInsertEmptySnippetBetweenSnippetsInPageCommand [
	<gtExample>
	<return: #LePage>
	| command result |
	command := self createInsertEmptySnippetBetweenSnippetsInPageCommand.
	result := command execute.

	self
		assertStructure: {#snippetT -> 'Target'.
				#snippetNew -> ''.
				#snippetA -> 'A'}
		forInsertCommandResult: result.
	self assertInsertedSnippetUidInResult: result.

	^ self targetPage
]
