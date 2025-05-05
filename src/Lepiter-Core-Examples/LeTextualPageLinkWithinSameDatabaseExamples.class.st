Class {
	#name : #LeTextualPageLinkWithinSameDatabaseExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'theDatabase',
		'theFirstPage',
		'theFirstSnippet',
		'theSecondPage',
		'theSecondSnippet'
	],
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #'examples - change' }
LeTextualPageLinkWithinSameDatabaseExamples >> changeSnippetContentToRemoveLinks [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	self firstSnippet updateText: 'new content with no link' asRopedText.

	self assert: database explicitLinksCount equals: 0.
	self assert: database textualSnippetsLinksCount equals: 0.
	self assert: database textualPageLinksCount equals: 0.

	self assert: currentLink targetReference content equals: self secondPage.
	self
		assert: currentLink targetReference pageTitle
		equals: self secondPage title.

	^ database
]

{ #category : #'examples - change' }
LeTextualPageLinkWithinSameDatabaseExamples >> changeSnippetContentToRemoveLinks_firstSnippetHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changeSnippetContentToRemoveLinks.

	self assert: self firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: self firstSnippet outgoingTextualLinks size equals: 0.
	self assert: self firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - change' }
LeTextualPageLinkWithinSameDatabaseExamples >> changeSnippetContentToRemoveLinks_removeAnnouncementIsTriggered [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink linksRemovedAnnouncements |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	self firstSnippet updateText: 'new content with no link' asRopedText.

	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks first
		equals: currentLink.

	^ database
]

{ #category : #'examples - change' }
LeTextualPageLinkWithinSameDatabaseExamples >> changeSnippetContentToRemoveLinks_secondPageHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self changeSnippetContentToRemoveLinks.

	self assert: self secondPage outgoingExplicitLinks size equals: 0.
	self assert: self secondPage incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithGtPageLink [
	<gtExample>
	<return: #LeDatabase>
	theDatabase := self emptyDatabase.

	theFirstPage := theDatabase pageBuilder
			title: 'Page 1';
			add.
	theSecondPage := theDatabase pageBuilder
			title: 'Page 2';
			add.

	theFirstSnippet := theFirstPage snippetBuilder
			string: 'First Snippet  with link to {{gtPage:Page 2|db=' , theDatabase uuid asString36
					, '}}';
			add.
	theSecondSnippet := theSecondPage snippetBuilder
			string: 'Another Snippet';
			add.

	self assert: theDatabase explicitLinksCount equals: 1.
	self assert: theDatabase textualSnippetsLinksCount equals: 0.
	self assert: theDatabase textualPageLinksCount equals: 1.

	^ theDatabase
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithRenamedGtPageLink [
	<gtExample>
	<return: #LeDatabase>
	theDatabase := self createDatabaseWithGtPageLink.
	theSecondPage := theDatabase pageNamed: 'Page 2'.
	theSecondPage renameTo: 'Renamed page'.

	self assert: theDatabase explicitLinksCount equals: 1.
	self assert: theDatabase textualSnippetsLinksCount equals: 0.
	self assert: theDatabase textualPageLinksCount equals: 1.

	^ theDatabase
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLink [
	<gtExample>
	<return: #LeDatabase>
	theDatabase := self emptyDatabase.

	theFirstPage := theDatabase pageBuilder
			title: 'Page 1';
			add.
	theSecondPage := theDatabase pageBuilder
			title: 'Page 2';
			add.

	theFirstSnippet := theFirstPage snippetBuilder
			string: 'First Snippet  with link to [[Page 2]]';
			add.
	theSecondSnippet := theSecondPage snippetBuilder
			string: 'Another Snippet';
			add.

	self assert: theDatabase explicitLinksCount equals: 1.
	self assert: theDatabase textualSnippetsLinksCount equals: 0.
	self assert: theDatabase textualPageLinksCount equals: 1.

	^ theDatabase
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage [
	<gtExample>
	<after: #stopDatabaseMonitoring>
	<return: #LeDatabase>
	theDatabase := self emptyDatabase.

	theFirstPage := theDatabase pageBuilder
			title: 'Page 1';
			add.

	theFirstSnippet := theFirstPage snippetBuilder
			string: 'First Snippet  with link to [[Page 2]]';
			add.

	self assert: theDatabase pageCount equals: 1.
	self assert: theDatabase explicitLinksCount equals: 1.
	self assert: theDatabase textualSnippetsLinksCount equals: 0.
	self assert: theDatabase textualPageLinksCount equals: 1.

	^ theDatabase
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_createSecondPage [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self createDatabaseWithTextualLinkToNotYetCreatedPage.
	currentLink := database explicitLinks first.

	theSecondPage := database pageBuilder
			title: 'Page 2';
			add.

	theSecondSnippet := theSecondPage snippetBuilder
			string: 'Another Snippet';
			add.

	self assert: currentLink targetReference isResolved.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_createSecondPage_secondPageHasIncomingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage |
	database := self
			createDatabaseWithTextualLinkToNotYetCreatedPage_createSecondPage.

	secondPage := self secondPage.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 1.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_createSecondPage_textualLinkHasCorrectIdentity [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet secondPage currentLink |
	database := self
			createDatabaseWithTextualLinkToNotYetCreatedPage_createSecondPage.

	firstSnippet := self firstSnippet.
	secondPage := self secondPage.
	currentLink := database explicitLinks items first.

	self assert: firstSnippet outgoingExplicitLinks items first == currentLink.
	self assert: secondPage incomingLinks first == currentLink.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_createSecondPage_textualLinkHasCorrectProperties [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet secondPage currentLink |
	database := self
			createDatabaseWithTextualLinkToNotYetCreatedPage_createSecondPage.

	firstSnippet := self firstSnippet.
	secondPage := self secondPage.
	currentLink := database explicitLinks items first.

	self assert: currentLink isTextualPageLink.
	self assert: currentLink targetPageTitle equals: secondPage title.
	self assert: currentLink targetUID equals: secondPage title.
	self assert: currentLink target equals: secondPage.
	self assert: currentLink origin equals: firstSnippet.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_firstSnippetHasOutgoingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet |
	database := self createDatabaseWithTextualLinkToNotYetCreatedPage.

	firstSnippet := self firstSnippet.

	self assert: firstSnippet outgoingExplicitLinks size equals: 1.
	self assert: firstSnippet outgoingTextualLinks size equals: 1.
	self assert: firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_linkIsInitiallyUnresolved [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self createDatabaseWithTextualLinkToNotYetCreatedPage.

	currentLink := database explicitLinks first.

	self assert: currentLink originReference isResolved.
	self assert: currentLink targetReference isResolved not.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_textualLinkHasCorrectProperties [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet currentLink |
	database := self createDatabaseWithTextualLinkToNotYetCreatedPage.

	firstSnippet := self firstSnippet.
	currentLink := database explicitLinks items first.

	self assert: currentLink isTextualPageLink.
	self assert: currentLink targetPageTitle equals: 'Page 2'.
	self assert: currentLink targetUID equals: 'Page 2'.
	self assert: currentLink target isNil.
	self assert: currentLink origin equals: firstSnippet.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLinkToNotYetCreatedPage_textualLinkReferencesHaveCorrectProperties [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet currentLink |
	database := self createDatabaseWithTextualLinkToNotYetCreatedPage.

	firstSnippet := self firstSnippet.
	currentLink := database explicitLinks items first.

	self assert: currentLink targetReference isPageReference.
	self assert: currentLink originReference isSnippetReference.

	self assert: currentLink originReference isResolved.
	self assert: currentLink originReference snippetUid equals: firstSnippet uid.

	self assert: currentLink targetReference isResolved not.
	self assert: currentLink targetReference pageTitle equals: 'Page 2'.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLink_addAnnouncementIsTriggered [
	<gtExample>
	<after: #stopDatabaseMonitoring>
	<return: #LeDatabase>
	| pageOne firstSnippet linksAddedAnnouncements |
	theDatabase := self emptyDatabase.

	pageOne := theDatabase pageBuilder
			title: 'Page 1';
			add.
	theDatabase pageBuilder
		title: 'Page 2';
		add.

	linksAddedAnnouncements := OrderedCollection new.
	theDatabase weak
		when: LeExplicitLinkAddedAnnouncement
		send: #add:
		to: linksAddedAnnouncements.

	firstSnippet := pageOne snippetBuilder
			string: 'First Snippet  with link to [[Page 2]]';
			add.

	self assert: linksAddedAnnouncements size equals: 1.
	self assert: linksAddedAnnouncements first requiresSavingOfLinks not.
	self
		assert: linksAddedAnnouncements first newExplicitLink
		equals: firstSnippet outgoingExplicitLinks items first.

	^ theDatabase
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLink_firstSnippetHasOutgoingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.

	self assert: firstSnippet outgoingExplicitLinks size equals: 1.
	self assert: firstSnippet outgoingTextualLinks size equals: 1.
	self assert: firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLink_secondPageHasIncomingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage |
	database := self createDatabaseWithTextualLink.

	secondPage := self secondPage.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 1.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLink_textualLinkHasCorrectIdentity [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet secondPage currentLink |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.
	secondPage := self secondPage.
	currentLink := database explicitLinks items first.

	self assert: firstSnippet outgoingExplicitLinks items first == currentLink.
	self assert: secondPage incomingLinks first == currentLink.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLink_textualLinkHasCorrectProperties [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet secondPage currentLink |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.
	secondPage := self secondPage.
	currentLink := database explicitLinks items first.

	self assert: currentLink isTextualPageLink.
	self assert: currentLink targetPageTitle equals: secondPage title.
	self assert: currentLink targetUID equals: secondPage title.
	self assert: currentLink target equals: secondPage.
	self assert: currentLink origin equals: firstSnippet.
	self assert: currentLink targetReference isResolved.
	self assert: currentLink originReference isResolved.

	^ database
]

{ #category : #'examples - creation' }
LeTextualPageLinkWithinSameDatabaseExamples >> createDatabaseWithTextualLink_textualLinkReferencesHaveCorrectProperties [
	<gtExample>
	<return: #LeDatabase>
	| database firstSnippet secondPage currentLink |
	database := self createDatabaseWithTextualLink.

	firstSnippet := self firstSnippet.
	secondPage := self secondPage.
	currentLink := database explicitLinks items first.

	self assert: currentLink targetReference isPageReference.
	self assert: currentLink originReference isSnippetReference.

	self assert: currentLink originReference isResolved.
	self assert: currentLink originReference snippetUid equals: firstSnippet uid.

	self assert: currentLink targetReference isResolved.
	self assert: currentLink targetReference pageTitle equals: secondPage title.

	^ database
]

{ #category : #examples }
LeTextualPageLinkWithinSameDatabaseExamples >> emptyDatabase [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore database |
	folderReference := FileSystem memory / 'storage'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	database := localStore loadAndMonitorFrom: folderReference.

	self assert: database explicitLinks size equals: 0.

	^ database
]

{ #category : #accessing }
LeTextualPageLinkWithinSameDatabaseExamples >> firstPage [
	^ theFirstPage
]

{ #category : #accessing }
LeTextualPageLinkWithinSameDatabaseExamples >> firstSnippet [ 
	^ theFirstSnippet
]

{ #category : #'examples - addition' }
LeTextualPageLinkWithinSameDatabaseExamples >> readdPageWithIncomingTextualLink [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage newLink |
	database := self removePageWithIncomingTextualLink.

	secondPage := database pageBuilder
			title: 'Page 2';
			add.

	secondPage snippetBuilder
		string: 'Another Snippet';
		add.

	newLink := database explicitLinks first.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualPageLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: secondPage incomingLinks size equals: 1.
	self assert: self firstPage outgoingExplicitLinks size equals: 0.
	self assert: self firstPage allChildOutgoingLinks size equals: 1.

	self assert: newLink target equals: secondPage.
	self assert: secondPage incomingLinks first equals: newLink.

	^ database
]

{ #category : #'examples - addition' }
LeTextualPageLinkWithinSameDatabaseExamples >> readdPageWithIncomingTextualLinkByRenamingExistingPage [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage newLink |
	database := self removePageWithIncomingTextualLink.

	firstPage := self firstPage.
	newLink := database explicitLinks first.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualPageLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: firstPage outgoingExplicitLinks size equals: 0.
	self assert: firstPage allChildOutgoingLinks size equals: 1.

	self assert: newLink target isNil.

	firstPage updateTitle: 'Page 2'.
	self assert: database explicitLinksCount equals: 1.
	self assert: database textualPageLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: firstPage incomingLinks size equals: 1.
	self assert: firstPage outgoingExplicitLinks size equals: 0.
	self assert: firstPage allChildOutgoingLinks size equals: 1.

	self assert: newLink origin parent equals: firstPage.
	self assert: newLink target equals: firstPage.
	self assert: firstPage incomingLinks first equals: newLink.

	^ database
]

{ #category : #'examples - addition' }
LeTextualPageLinkWithinSameDatabaseExamples >> readdPageWithIncomingTextualLinkByRenamingNewPage [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage newLink |
	database := self removePageWithIncomingTextualLink.

	secondPage := database pageBuilder
			title: 'Page-2';
			add.
	secondPage snippetBuilder
		string: 'Another Snippet';
		add.

	newLink := database explicitLinks first.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualPageLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: secondPage incomingLinks size equals: 0.
	self assert: self firstPage outgoingExplicitLinks size equals: 0.
	self assert: self firstPage allChildOutgoingLinks size equals: 1.

	self assert: newLink target isNil.

	secondPage updateTitle: 'Page 2'.
	self assert: database explicitLinksCount equals: 1.
	self assert: database textualPageLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: secondPage incomingLinks size equals: 1.
	self assert: self firstPage outgoingExplicitLinks size equals: 0.
	self assert: self firstPage allChildOutgoingLinks size equals: 1.


	self assert: newLink target equals: secondPage.
	self assert: secondPage incomingLinks first equals: newLink.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removePageWithIncomingTextualLink [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self createDatabaseWithTextualLink.

	self secondPage removeSelf.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualPageLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removePageWithIncomingTextualLink_firstSnippetHasOutgoingLink [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removePageWithIncomingTextualLink.

	self assert: self firstSnippet outgoingExplicitLinks size equals: 1.
	self assert: self firstSnippet outgoingTextualLinks size equals: 1.
	self assert: self firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removePageWithIncomingTextualLink_linkHasUpdatedContent [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self removePageWithIncomingTextualLink.

	currentLink := database explicitLinks items first.

	self assert: currentLink targetReference content equals: nil.
	self
		assert: currentLink targetReference pageTitle
		equals: self secondPage title.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removePageWithIncomingTextualLink_secondPageHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removePageWithIncomingTextualLink.

	self assert: self secondPage outgoingExplicitLinks size equals: 0.
	self assert: self secondPage incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removePageWithSnippetWithOutgoingTextualLink [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self createDatabaseWithTextualLink.

	self firstPage removeSelf.

	self assert: database explicitLinksCount equals: 0.
	self assert: database textualSnippetsLinksCount equals: 0.
	self assert: database textualPageLinksCount equals: 0.

	self assert: self firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: self secondPage incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removeSnippetWithOutgoingTextualLink [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	self firstSnippet removeSelf.

	self assert: database explicitLinksCount equals: 0.
	self assert: database textualSnippetsLinksCount equals: 0.
	self assert: database textualPageLinksCount equals: 0.

	self assert: currentLink targetReference content equals: self secondPage.
	self
		assert: currentLink targetReference pageTitle
		equals: self secondPage title.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removeSnippetWithOutgoingTextualLink_firstSnippetHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removeSnippetWithOutgoingTextualLink.

	self assert: self firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: self firstSnippet outgoingTextualLinks size equals: 0.
	self assert: self firstSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removeSnippetWithOutgoingTextualLink_removeAnnouncementIsTriggered [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink linksRemovedAnnouncements |
	database := self createDatabaseWithTextualLink.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	self firstSnippet removeSelf.

	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks items first
		equals: currentLink.

	^ database
]

{ #category : #'examples - removal' }
LeTextualPageLinkWithinSameDatabaseExamples >> removeSnippetWithOutgoingTextualLink_secondPageHasNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removeSnippetWithOutgoingTextualLink.

	self assert: self secondPage outgoingExplicitLinks size equals: 0.
	self assert: self secondPage incomingLinks size equals: 0.

	^ database
]

{ #category : #accessing }
LeTextualPageLinkWithinSameDatabaseExamples >> secondPage [
	^ theSecondPage
]

{ #category : #after }
LeTextualPageLinkWithinSameDatabaseExamples >> stopDatabaseMonitoring [
	theDatabase ifNotNil: [ :aDatabase |
		aDatabase stopMonitoring ]
]
