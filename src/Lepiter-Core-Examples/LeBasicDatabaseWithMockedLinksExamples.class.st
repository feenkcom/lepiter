Class {
	#name : #LeBasicDatabaseWithMockedLinksExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #examples }
LeBasicDatabaseWithMockedLinksExamples >> basicDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #examples }
LeBasicDatabaseWithMockedLinksExamples >> databaseWithChildSnippets [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo secondSnippet |
	database := self basicDatabase.
	database addPage: (pageOne := LePage named: 'Page1').
	pageOne addSnippet: (LeMockedSnippet string: 'One').

	database addPage: (pageTwo := LePage named: 'Page2').
	pageTwo addSnippet: (LeMockedSnippet string: 'First Snippet').
	pageTwo addSnippet: (secondSnippet := LeMockedSnippet string: 'Second Snippet').
	secondSnippet
		addSnippet: (LeMockedSnippet new
				string: 'Link to [[Page1]]';
				textualLinkToPageNamed: 'Page1').
	pageTwo addSnippet: (LeMockedSnippet string: 'Third Snippet').

	self assert: pageTwo childrenCount equals: 3.
	self assert: (database scanForLinksTo: pageOne) size equals: 1.
	self assert: pageOne incomingLinks size equals: 1.
	self assert: database explicitLinksCount equals: 1.
	self assert: database explicitLinks items first isTextualPageLink.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithMockedLinksExamples >> linksAreAddedToDatabaseWhenSnippetIsAdded [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self basicDatabase.

	pageOne := LePage named: 'Page1'.
	database addPage: pageOne.
	pageOne addSnippet: (LeMockedSnippet string: 'One').

	pageTwo := LePage named: 'Page2'.
	database addPage: pageTwo.

	self assert: (database scanForLinksTo: pageOne) size equals: 0.
	self assert: (database scanForLinksTo: pageTwo) size equals: 0.

	targetSnippet := LeMockedSnippet string: 'Link to [[Page1]]'.
	targetSnippet textualLinkToPageNamed: 'Page1'.
	pageTwo addSnippet: targetSnippet.

	self assert: pageOne childrenCount equals: 1.
	self assert: targetSnippet outgoingExplicitLinks size equals: 1.
	self assert: targetSnippet outgoingTextualLinks size equals: 1.
	self assert: (database scanForLinksTo: pageOne) size equals: 1.
	self assert: pageOne incomingLinks size equals: 1.
	self assert: database explicitLinksCount equals: 1.
	self assert: database explicitLinks items first isTextualPageLink.
	self
		assert: targetSnippet outgoingExplicitLinks first
		equals: (database scanForLinksTo: pageOne) first.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithMockedLinksExamples >> linksAreAddedToTheDatabaseWhenPageAdded [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self basicDatabase.

	pageOne := LePage named: 'Page1'.
	database addPage: pageOne.
	pageOne addSnippet: (LeMockedSnippet string: 'One').

	targetSnippet := LeMockedSnippet string: 'Link to [[Page1]]'.
	targetSnippet textualLinkToPageNamed: 'Page1'.

	pageTwo := LePage named: 'Page2'.
	pageTwo addSnippet: targetSnippet.

	database addPage: pageTwo.

	self assert: pageOne childrenCount equals: 1.
	self assert: targetSnippet outgoingExplicitLinks size equals: 1.
	self assert: targetSnippet outgoingTextualLinks size equals: 1.
	self assert: (database scanForLinksTo: pageOne) size equals: 1.
	self assert: pageOne incomingLinks size equals: 1.
	self assert: database explicitLinksCount equals: 1.
	self assert: database explicitLinks items first isTextualPageLink.
	self
		assert: targetSnippet outgoingExplicitLinks first
		equals: (database scanForLinksTo: pageOne) first.
	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithMockedLinksExamples >> linksAreRemovedFromDatabaseWhenPageIsRemoved [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self linksAreAddedToTheDatabaseWhenPageAdded.
	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.
	targetSnippet := pageTwo children first.

	pageTwo removeSelf.

	self assert: targetSnippet outgoingExplicitLinks size equals: 0.
	self assert: targetSnippet outgoingTextualLinks size equals: 0.
	self assert: (database scanForLinksTo: pageOne) size equals: 0.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: database explicitLinksCount equals: 0.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithMockedLinksExamples >> linksAreRemovedFromDatabaseWhenParentSnippetIsRemoved [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo parentSnippet targetSnippet |
	database := self databaseWithChildSnippets.
	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.
	parentSnippet := pageTwo children second.
	targetSnippet := parentSnippet children first.

	parentSnippet removeSelf.

	self assert: targetSnippet outgoingExplicitLinks size equals: 0.
	self assert: targetSnippet outgoingTextualLinks size equals: 0.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: (database scanForLinksTo: pageOne) size equals: 0.
	self assert: database explicitLinksCount equals: 0.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithMockedLinksExamples >> linksAreRemovedFromDatabaseWhenSnippetIsRemoved [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self linksAreAddedToTheDatabaseWhenPageAdded.
	pageOne := database pageNamed: 'Page1'.
	pageTwo := database pageNamed: 'Page2'.
	targetSnippet := pageTwo children first.

	targetSnippet removeSelf.

	self assert: targetSnippet outgoingExplicitLinks size equals: 0.
	self assert: targetSnippet outgoingTextualLinks size equals: 0.
	self assert: (database scanForLinksTo: pageOne) size equals: 0.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: database explicitLinksCount equals: 0.

	^ database
]
