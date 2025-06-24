Class {
	#name : #LeBasicDatabaseWithTextLinksExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #asserting }
LeBasicDatabaseWithTextLinksExamples >> assertIdentityFor: aTargetSnippet with: expectedLinks inDatabase: aDatabase [
	| pageOne pageLink |
	pageOne := aDatabase pageNamed: 'Page1'.

	self assert: aTargetSnippet outgoingExplicitLinks size equals: 1.
	self assert: aTargetSnippet outgoingTextualLinks size equals: 1.
	self assert: (aDatabase scanForLinksTo: pageOne) size equals: 1.
	self assert: pageOne incomingLinks size equals: 1.
	self assert: aDatabase explicitLinksCount equals: 1.
	self assert: aDatabase explicitLinks items first isTextualPageLink.
	
	pageLink := (aDatabase scanForLinksTo: pageOne) first. 
	
	self assert: pageOne incomingLinks first == pageLink.
	self assert: aTargetSnippet outgoingExplicitLinks first == expectedLinks first.
	self assert: pageLink == expectedLinks first.
	self assert: pageLink origin equals: aTargetSnippet.
	self assert: pageLink target equals:  pageOne
]

{ #category : #examples }
LeBasicDatabaseWithTextLinksExamples >> basicDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := LeDatabase new.
	aDatabase monitor: LeVolatileMonitor new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #examples }
LeBasicDatabaseWithTextLinksExamples >> databaseWithChildSnippets [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo secondSnippet secondSnippetChild |
	database := self basicDatabase.
	pageOne := database pageBuilder
			title: 'Page1';
			add.
	pageOne snippetBuilder
		string: 'One';
		add.

	pageTwo := database pageBuilder
			title: 'Page2';
			add.
	pageTwo snippetBuilder
		string: 'First Snippet';
		add.
	secondSnippet := pageTwo snippetBuilder
			string: 'Second Snippet';
			add.
	secondSnippetChild := secondSnippet snippetBuilder
			string: 'Link to [[Page1]]';
			add.
	pageTwo snippetBuilder
		string: 'Third Snippet';
		add.

	self assert: pageTwo childrenCount equals: 3.
	self assert: secondSnippetChild outgoingExplicitLinks size equals: 1.
	self assert: (database scanForLinksTo: pageOne) size equals: 1.
	self assert: pageOne incomingLinks size equals: 1.
	self assert: database explicitLinksCount equals: 1.
	self assert: database explicitLinks items first isTextualPageLink.
	self
		assert: secondSnippetChild outgoingExplicitLinks first
		equals: (database scanForLinksTo: pageOne) first.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> linksAreAddedToDatabaseWhenSnippetIsAdded [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self basicDatabase.
	pageOne := database pageBuilder
			title: 'Page1';
			add.
	pageOne snippetBuilder
		string: 'One';
		add.

	pageTwo := database pageBuilder
			title: 'Page2';
			add.
	self assert: (database scanForLinksTo: pageOne) size equals: 0.

	targetSnippet := pageTwo snippetBuilder
			string: 'Link to [[Page1]]';
			add.

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
LeBasicDatabaseWithTextLinksExamples >> linksAreAddedToTheDatabaseWhenPageAdded [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self basicDatabase.
	pageOne := database pageBuilder
			title: 'Page1';
			add.
	pageOne snippetBuilder
		string: 'One';
		add.
	pageTwo := LePage named: 'Page2'.
	targetSnippet := LeTextSnippet string: 'Link to [[Page1]]'.
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
LeBasicDatabaseWithTextLinksExamples >> linksAreRemovedFromDatabaseWhenPageIsRemoved [
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
LeBasicDatabaseWithTextLinksExamples >> linksAreRemovedFromDatabaseWhenParentSnippetIsRemoved [
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
LeBasicDatabaseWithTextLinksExamples >> linksAreRemovedFromDatabaseWhenSnippetIsRemoved [
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

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> linksIdentityIsPreservedWhenIndentingSnippet [
	<gtExample>
	<return: #LeDatabase>
	| database pageTwo targetSnippet currentLinks |
	database := self linksIdentityIsPreservedWhenUnindentingSnippet.
	pageTwo := database pageNamed: 'Page2'.
	targetSnippet := pageTwo children third.

	currentLinks := targetSnippet outgoingExplicitLinks.
	targetSnippet indent.

	self
		assertIdentityFor: targetSnippet
		with: currentLinks
		inDatabase: database.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> linksIdentityIsPreservedWhenMovingDownParentSnippet [
	<gtExample>
	<return: #LeDatabase>
	| database pageTwo parentSnippet targetSnippet currentLinks |
	database := self databaseWithChildSnippets.
	pageTwo := database pageNamed: 'Page2'.
	parentSnippet := pageTwo children second.
	targetSnippet := parentSnippet children first.

	currentLinks := targetSnippet outgoingExplicitLinks.
	parentSnippet moveDown.

	self
		assertIdentityFor: targetSnippet
		with: currentLinks
		inDatabase: database.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> linksIdentityIsPreservedWhenMovingSnippetDownToAnotherParent [
	<gtExample>
	<return: #LeDatabase>
	| database pageTwo currentLinks targetSnippet |
	database := self databaseWithChildSnippets.
	pageTwo := database pageNamed: 'Page2'.
	targetSnippet := pageTwo children second children first.
	currentLinks := targetSnippet outgoingExplicitLinks.

	targetSnippet moveDown.

	self
		assertIdentityFor: targetSnippet
		with: currentLinks
		inDatabase: database.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> linksIdentityIsPreservedWhenMovingSnippetUpToAnotherParent [
	<gtExample>
	<return: #LeDatabase>
	| database pageTwo currentLinks targetSnippet |
	database := self databaseWithChildSnippets.
	pageTwo := database pageNamed: 'Page2'.
	targetSnippet := pageTwo children second children first.
	currentLinks := targetSnippet outgoingExplicitLinks.

	targetSnippet moveUp.

	self
		assertIdentityFor: targetSnippet
		with: currentLinks
		inDatabase: database.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> linksIdentityIsPreservedWhenMovingUpParentSnippet [
	<gtExample>
	<return: #LeDatabase>
	| database pageTwo parentSnippet targetSnippet currentLinks |
	database := self databaseWithChildSnippets.
	pageTwo := database pageNamed: 'Page2'.
	parentSnippet := pageTwo children second.
	targetSnippet := parentSnippet children first.

	currentLinks := targetSnippet outgoingExplicitLinks.
	parentSnippet moveUp.

	self
		assertIdentityFor: targetSnippet
		with: currentLinks
		inDatabase: database.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> linksIdentityIsPreservedWhenUnindentingSnippet [
	<gtExample>
	<return: #LeDatabase>
	| database pageTwo targetSnippet currentLinks |
	database := self databaseWithChildSnippets.
	pageTwo := database pageNamed: 'Page2'.
	targetSnippet := pageTwo children second children first.

	currentLinks := targetSnippet outgoingExplicitLinks.
	targetSnippet unindent.

	self
		assertIdentityFor: targetSnippet
		with: currentLinks
		inDatabase: database.

	^ database
]

{ #category : #'examples - snippets' }
LeBasicDatabaseWithTextLinksExamples >> snippetsAreAddedToTheDatabaseWhenPageCreateUsingBuilder [
	<gtExample>
	<return: #LeDatabase>
	| database page snippetOne snippetTwo snippetOneChildren |
	database := self basicDatabase.
	page := database pageBuilder
			title: 'Page';
			add.
	snippetOne := page snippetBuilder
			string: 'One';
			add.
	snippetOneChildren := snippetOne snippetBuilder
			string: 'One.One';
			add.
	snippetTwo := page snippetBuilder
			string: 'Two';
			add.
	self assert: page childrenCount equals: 2.
	self assert: snippetOne childrenCount equals: 1.

	self assert: (database hasBlockUID: snippetOne uid).
	self assert: (database hasBlockUID: snippetTwo uid).
	self assert: (database hasBlockUID: snippetOneChildren uid).
	self assert: database snippetsCount equals: 3.

	^ database
]

{ #category : #'examples - snippets' }
LeBasicDatabaseWithTextLinksExamples >> snippetsAreAddedToTheDatabaseWhenPageManuallyCreated [
	<gtExample>
	<return: #LeDatabase>
	| database page snippetOne snippetTwo snippetOneChildren |
	database := self basicDatabase.
	page := LePage named: 'Page'.
	snippetOne := LeTextSnippet string: 'One'.
	snippetOneChildren := LeTextSnippet string: 'One.One'.
	snippetOne addSnippet: snippetOneChildren.
	snippetTwo := LeTextSnippet string: 'Two'.
	page addSnippet: snippetOne.
	page addSnippet: snippetTwo.
	database addPage: page.
	self assert: page childrenCount equals: 2.
	self assert: snippetOne childrenCount equals: 1.
	self assert: (database hasBlockUID: snippetOne uid).
	self assert: (database hasBlockUID: snippetTwo uid).
	self assert: (database hasBlockUID: snippetOneChildren uid).
	self assert: database snippetsCount equals: 3.
	^ database
]

{ #category : #'examples - snippets' }
LeBasicDatabaseWithTextLinksExamples >> snippetsAreRemovedFromTheDatabaseWhenRemovingPage [
	<gtExample>
	<return: #LeDatabase>
	| database page snippetOne snippetTwo snippetOneChildren |
	database := self snippetsAreAddedToTheDatabaseWhenPageCreateUsingBuilder.
	page := database pageNamed: 'Page'.
	snippetOne := page children first.
	snippetOneChildren := snippetOne children first.
	snippetTwo := page children second.

	page removeSelf.

	self assert: (database hasBlockUID: snippetOne uid) not.
	self assert: (database hasBlockUID: snippetTwo uid) not.
	self assert: (database hasBlockUID: snippetOneChildren uid) not.
	self assert: database snippetsCount equals: 0.

	^ database
]

{ #category : #'examples - snippets' }
LeBasicDatabaseWithTextLinksExamples >> snippetsAreRemovedFromTheDatabaseWhenRemovingParentSnippet [
	<gtExample>
	<return: #LeDatabase>
	| database page snippetOne snippetTwo snippetOneChildren |
	database := self snippetsAreAddedToTheDatabaseWhenPageCreateUsingBuilder.
	page := database pageNamed: 'Page'.
	snippetOne := page children first.
	snippetOneChildren := snippetOne children first.
	snippetTwo := page children second.

	snippetOne removeSelf.

	self assert: (database hasBlockUID: snippetOne uid) not.
	self assert: (database hasBlockUID: snippetTwo uid).
	self assert: (database hasBlockUID: snippetOneChildren uid) not.
	self assert: database snippetsCount equals: 1.

	^ database
]

{ #category : #'examples - page links' }
LeBasicDatabaseWithTextLinksExamples >> uidLinksAreAddedToDatabaseWhenSnippetIsAdded [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self basicDatabase.
	pageOne := LePage unnamedPage.
	pageOne snippetBuilder
		string: 'One';
		add.
	database addPage: pageOne.

	pageTwo := database pageBuilder
			title: 'Page2';
			add.
	self assert: (database scanForLinksTo: pageOne) size equals: 0.

	targetSnippet := pageTwo snippetBuilder
			string: 'Link to ' , pageOne asRemoteLink;
			add.

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
LeBasicDatabaseWithTextLinksExamples >> uidLinksAreAddedToTheDatabaseWhenPageAdded [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo targetSnippet |
	database := self basicDatabase.
	pageOne := LePage unnamedPage.
	database addPage: pageOne.
	pageOne snippetBuilder
		string: 'One';
		add.
	pageTwo := LePage named: 'Page2'.
	targetSnippet := LeTextSnippet string: 'Link to ' , pageOne asRemoteLink.
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
