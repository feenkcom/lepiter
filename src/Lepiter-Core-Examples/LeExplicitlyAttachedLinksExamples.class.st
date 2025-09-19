Class {
	#name : #LeExplicitlyAttachedLinksExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Links'
}

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> databaseBaseWithPages [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage firstPageFirstSnippet secondPage secondPageFirstSnippet |
	database := self emptyDatabase.
	firstPage := database pageBuilder
			title: 'Page 1';
			add.
	firstPageFirstSnippet := firstPage snippetBuilder
			string: 'The First Snippet in Page 1';
			add.
	firstPage snippetBuilder
		string: 'The Second Snippet in Page 1';
		add.
	firstPageFirstSnippet snippetBuilder
		string: 'Child snippet in Page 1';
		add.

	secondPage := database pageBuilder
			title: 'Page 2';
			add.
	secondPageFirstSnippet := secondPage snippetBuilder
			string: 'The First Snippet in Page 2';
			add.
	secondPage snippetBuilder
		string: 'The Second Snippet in Page 2';
		add.
	secondPageFirstSnippet snippetBuilder
		string: 'Child snippet in Page 2';
		add.

	^ database
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenChildSnippets [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage firstPageSnippet secondPage secondPagesnippet explicitLink |
	database := self databaseBaseWithPages.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.
	firstPageSnippet := firstPage children first children first.
	secondPagesnippet := secondPage children first children first.
	explicitLink := LeAttachedLink new
			originReference: (LeLinkSnippetUidReference forSnippetUid: firstPageSnippet uid);
			targetReference: (LeLinkSnippetUidReference forSnippetUid: secondPagesnippet uid).
	database addExplicitLink: explicitLink.
	self assert: explicitLink linkUuid notNil.
	self assert: (database hasExplicitLinkUID: explicitLink linkUuid).
	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenPages [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage explicitLink |
	database := self databaseBaseWithPages.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPageUid: firstPage uid);
			targetReference: (LeLinkPageUidReference forPageUid: secondPage uid).

	database addExplicitLink: explicitLink.
	self assert: explicitLink linkUuid notNil.
	self assert: (database hasExplicitLinkUID: explicitLink linkUuid).
	self
		assert: (database explicitLinkWithUuid: explicitLink linkUuid) == explicitLink.
	self assert: database explicitLinks items first == explicitLink.

	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenPages_addAnnouncementIsTriggered [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage explicitLink linksAddedAnnouncements |
	database := self databaseBaseWithPages.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPageUid: firstPage uid);
			targetReference: (LeLinkPageUidReference forPageUid: secondPage uid).

	linksAddedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinkAddedAnnouncement
		send: #add:
		to: linksAddedAnnouncements.

	database addExplicitLink: explicitLink.

	self assert: linksAddedAnnouncements size equals: 1.
	self assert: linksAddedAnnouncements first newExplicitLink equals: explicitLink.
	self assert: linksAddedAnnouncements first requiresSavingOfLinks.

	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenPages_databaseHasCorrectNumberOfLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self databaseWithExplicitLinkBetweenPages.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenPages_firstPageHasOnlyOutgoingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage explicitLink |
	database := self databaseWithExplicitLinkBetweenPages.
	firstPage := database pageNamed: 'Page 1'.
	explicitLink := database explicitLinks items first.

	self assert: firstPage outgoingExplicitLinks size equals: 1.
	self assert: firstPage outgoingExplicitLinks items first == explicitLink.
	self assert: firstPage incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenPages_originReferenceIsInitializedCorrectly [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage explicitLink targetDatabase |
	database := self databaseWithExplicitLinkBetweenPages.
	firstPage := database pageNamed: 'Page 1'.
	explicitLink := database explicitLinks items first.

	self assert: explicitLink originReference explicitLink equals: explicitLink.
	self assert: explicitLink originReference isResolved.
	self assert: explicitLink originReference content equals: firstPage.
	self assert: explicitLink originReference targetDatabaseUUID isNil.

	targetDatabase := nil.
	explicitLink originReference
		targetDatabaseDo: [ :aDatabase | targetDatabase := aDatabase ].
	self assert: explicitLink originReference targetDatabaseUUID isNil.
	self assert: targetDatabase equals: database.

	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenPages_secondPageHasOnlyIncomingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage explicitLink |
	database := self databaseWithExplicitLinkBetweenPages.
	secondPage := database pageNamed: 'Page 2'.
	explicitLink := database explicitLinks items first.

	self assert: secondPage incomingLinks size equals: 1.
	self assert: secondPage incomingLinks first = explicitLink.
	self assert: secondPage outgoingExplicitLinks size equals: 0.

	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenPages_targetReferenceIsInitializedCorrectly [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage explicitLink targetDatabase |
	database := self databaseWithExplicitLinkBetweenPages.
	secondPage := database pageNamed: 'Page 2'.
	explicitLink := database explicitLinks items first.

	self assert: explicitLink targetReference explicitLink equals: explicitLink.
	self assert: explicitLink targetReference isResolved.
	self assert: explicitLink targetReference content equals: secondPage.
	self assert: explicitLink targetReference targetDatabaseUUID isNil.

	targetDatabase := nil.
	explicitLink originReference
		targetDatabaseDo: [ :aDatabase | targetDatabase := aDatabase ].
	self assert: explicitLink originReference targetDatabaseUUID isNil.
	self assert: targetDatabase equals: database.

	^ database
]

{ #category : #'examples - snippet links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenSnippets [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage explicitLink firstSnippet secondSnippet |
	database := self databaseBaseWithPages.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.
	firstSnippet := firstPage children first.
	secondSnippet := secondPage children first.
	explicitLink := LeAttachedLink new
			originReference: (LeLinkSnippetUidReference forSnippetUid: firstSnippet uid);
			targetReference: (LeLinkSnippetUidReference forSnippetUid: secondSnippet uid).
	database addExplicitLink: explicitLink.
	self assert: explicitLink linkUuid notNil.
	self assert: (database hasExplicitLinkUID: explicitLink linkUuid).
	self
		assert: (database explicitLinkWithUuid: explicitLink linkUuid) == explicitLink.
	self assert: database explicitLinks items first == explicitLink.
	^ database
]

{ #category : #'examples - snippet links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenSnippets_databaseHasCorrectNumberOfLinks [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self databaseWithExplicitLinkBetweenSnippets.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.

	^ database
]

{ #category : #'examples - snippet links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenSnippets_firstSnippetHasOnlyOutgpingLinkss [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage explicitLink firstSnippet |
	database := self databaseWithExplicitLinkBetweenSnippets.
	firstPage := database pageNamed: 'Page 1'.
	firstSnippet := firstPage children first.
	explicitLink := database explicitLinks items first.
	self assert: firstSnippet outgoingExplicitLinks size equals: 1.
	self assert: firstSnippet outgoingExplicitLinks items first == explicitLink.
	self assert: firstSnippet incomingLinks size equals: 0.
	^ database
]

{ #category : #'examples - snippet links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenSnippets_pagesHaveNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage |
	database := self databaseWithExplicitLinkBetweenSnippets.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.

	self assert: firstPage incomingLinks size equals: 0.
	self assert: firstPage outgoingExplicitLinks size equals: 0.

	self assert: secondPage incomingLinks size equals: 0.
	self assert: secondPage outgoingExplicitLinks size equals: 0.

	^ database
]

{ #category : #'examples - snippet links' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenSnippets_secondSnippetHasOnlyIncomingLinks [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage explicitLink secondSnippet |
	database := self databaseWithExplicitLinkBetweenSnippets.
	secondPage := database pageNamed: 'Page 2'.
	secondSnippet := secondPage children first.
	explicitLink := database explicitLinks items first.
	self assert: secondSnippet incomingLinks size equals: 1.
	self assert: secondSnippet incomingLinks first == explicitLink.
	self assert: secondSnippet outgoingExplicitLinks size equals: 0.
	^ database
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkBetweenURLs [
	<gtExample>
	<return: #LeDatabase>
	| database explicitLink |
	database := self emptyDatabase.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkExternalUrlReference forUrl: 'https://feenk.com');
			targetReference: (LeLinkExternalUrlReference forUrl: 'https://gtoolkit.com').

	database addExplicitLink: explicitLink.
	self assert: explicitLink linkUuid notNil.
	self assert: (database hasExplicitLinkUID: explicitLink linkUuid).

	self assert: explicitLink originReference explicitLink equals: explicitLink.
	self assert: explicitLink targetReference explicitLink equals: explicitLink.

	^ database
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> databaseWithExplicitLinkFromSnippetToURL [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage explicitLink |
	database := self databaseBaseWithPages.
	firstPage := database pageNamed: 'Page 1'.
	explicitLink := LeAttachedLink new
			originReference: (LeLinkSnippetUidReference forSnippetUid: firstPage children first uid);
			targetReference: (LeLinkExternalUrlReference forUrl: 'https://feenk.com').
	database addExplicitLink: explicitLink.
	self assert: explicitLink linkUuid notNil.
	self assert: (database hasExplicitLinkUID: explicitLink linkUuid).
	self assert: explicitLink originReference explicitLink equals: explicitLink.
	self assert: explicitLink targetReference explicitLink equals: explicitLink.
	^ database
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> emptyDatabase [
	<gtExample>
	<return: #LeDatabase>
	| database folderReference localStore |
	folderReference := FileSystem memory / 'storage-main'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	database := localStore loadAndMonitorFrom: folderReference.
	self assert: database explicitLinks size equals: 0.
	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage secondPage explicitLink |
	logicalDatabase := self logicalDatabaseWithTwoDatabases.
	firstPage := logicalDatabase pageNamed: 'Page 1'.
	secondPage := logicalDatabase pageNamed: 'Page 2'.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPageUid: firstPage uid);
			targetReference: (LeLinkPageUidReference
					forPageUid: secondPage uid
					targetDatabaseUUID: secondPage database uuidString).

	logicalDatabase primaryDB addExplicitLink: explicitLink.
	self assert: explicitLink linkUuid notNil.

	self
		assert: (logicalDatabase primaryDB hasExplicitLinkUID: explicitLink linkUuid).
	self
		assert: (logicalDatabase primaryDB explicitLinkWithUuid: explicitLink linkUuid)
				== explicitLink.
	self
		assert: logicalDatabase primaryDB explicitLinks items first == explicitLink.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPagesInDistinctDatabase [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage secondPage explicitLink |
	logicalDatabase := self logicalDatabaseWithThreeDatabases.
	firstPage := logicalDatabase pageNamed: 'Page 1'.
	secondPage := logicalDatabase pageNamed: 'Page 2'.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference
					forPageUid: firstPage uid
					targetDatabaseUUID: logicalDatabase registeredDBs first uuidString);
			targetReference: (LeLinkPageUidReference
					forPageUid: secondPage uid
					targetDatabaseUUID: logicalDatabase registeredDBs second uuidString).

	logicalDatabase primaryDB addExplicitLink: explicitLink.
	self assert: explicitLink linkUuid notNil.

	self
		assert: (logicalDatabase primaryDB hasExplicitLinkUID: explicitLink linkUuid).
	self
		assert: (logicalDatabase primaryDB explicitLinkWithUuid: explicitLink linkUuid)
				== explicitLink.
	self
		assert: logicalDatabase primaryDB explicitLinks items first == explicitLink.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_addAnnouncementIsTriggeredInLogicalDatabase [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage secondPage explicitLink linksAddedAnnouncements |
	logicalDatabase := self logicalDatabaseWithTwoDatabases.
	firstPage := logicalDatabase pageNamed: 'Page 1'.
	secondPage := logicalDatabase pageNamed: 'Page 2'.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPageUid: firstPage uid);
			targetReference: (LeLinkPageUidReference
					forPageUid: secondPage uid
					targetDatabaseUUID: secondPage database uuidString).

	linksAddedAnnouncements := OrderedCollection new.
	logicalDatabase weak
		when: LeExplicitLinkAddedAnnouncement
		send: #add:
		to: linksAddedAnnouncements.

	logicalDatabase primaryDB addExplicitLink: explicitLink.
	self assert: linksAddedAnnouncements size equals: 1.
	self assert: linksAddedAnnouncements first newExplicitLink equals: explicitLink.
	self assert: linksAddedAnnouncements first requiresSavingOfLinks.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_addAnnouncementIsTriggeredInPrimaryDatabase [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage secondPage explicitLink linksAddedAnnouncements |
	logicalDatabase := self logicalDatabaseWithTwoDatabases.
	firstPage := logicalDatabase pageNamed: 'Page 1'.
	secondPage := logicalDatabase pageNamed: 'Page 2'.

	explicitLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPageUid: firstPage uid);
			targetReference: (LeLinkPageUidReference
					forPageUid: secondPage uid
					targetDatabaseUUID: secondPage database uuidString).

	linksAddedAnnouncements := OrderedCollection new.
	logicalDatabase primaryDB weak
		when: LeExplicitLinkAddedAnnouncement
		send: #add:
		to: linksAddedAnnouncements.

	logicalDatabase primaryDB addExplicitLink: explicitLink.
	self assert: linksAddedAnnouncements size equals: 1.
	self assert: linksAddedAnnouncements first newExplicitLink equals: explicitLink.
	self assert: linksAddedAnnouncements first requiresSavingOfLinks.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_firstPageHasOnlyOutgoingLinks [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage explicitLink |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.
	firstPage := logicalDatabase pageNamed: 'Page 1'.

	explicitLink := logicalDatabase primaryDB explicitLinks items first.

	self assert: firstPage outgoingExplicitLinks size equals: 1.
	self assert: firstPage outgoingExplicitLinks items first == explicitLink.
	self assert: firstPage incomingLinks size equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_linkIsResolvedCorrectly [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase secondPage explicitLink |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.
	secondPage := logicalDatabase pageNamed: 'Page 2'.

	explicitLink := logicalDatabase primaryDB explicitLinks items first.
	self assert: explicitLink targetReference page equals: secondPage.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_logicalDatabaseHasCorrectNumberOfLinks [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.

	self assert: logicalDatabase explicitLinksCount equals: 1.
	self assert: logicalDatabase textualSnippetsLinksCount equals: 0.
	self assert: logicalDatabase textualPageLinksCount equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_primaryDatabaseHasCorrectNumberOfLinks [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.

	self assert: logicalDatabase primaryDB explicitLinksCount equals: 1.
	self assert: logicalDatabase primaryDB textualSnippetsLinksCount equals: 0.
	self assert: logicalDatabase primaryDB textualPageLinksCount equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_scondaryDatabaseHasNoLinks [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.

	self assert: logicalDatabase registeredDBs first explicitLinksCount equals: 0.
	self
		assert: logicalDatabase registeredDBs first textualSnippetsLinksCount
		equals: 0.
	self
		assert: logicalDatabase registeredDBs first textualPageLinksCount
		equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithExplicitLinkBetweenPages_secondPageHasOnlyIncomingLinks [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase secondPage explicitLink |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.
	secondPage := logicalDatabase pageNamed: 'Page 2'.

	explicitLink := logicalDatabase primaryDB explicitLinks items first.

	self assert: secondPage incomingLinks size equals: 1.
	self assert: secondPage incomingLinks first = explicitLink.
	self assert: secondPage outgoingExplicitLinks size equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithThreeDatabases [
	<gtExample>
	<return: #LeLogicalDatabase>
	| primaryDatabase secondaryDatabase thirdDatabase logicalDatabase firstPage firstPageFirstSnippet secondPage secondPageFirstSnippet |
	primaryDatabase := self primaryDatabase.
	secondaryDatabase := self secondaryDatabase.
	thirdDatabase := self thirdDatabase.

	logicalDatabase := LeLogicalDatabase new
			primaryDB: primaryDatabase;
			addDB: secondaryDatabase;
			addDB: thirdDatabase;
			yourself.

	firstPage := secondaryDatabase pageBuilder
			title: 'Page 1';
			add.

	firstPageFirstSnippet := firstPage snippetBuilder
			string: 'The First Snippet in Page 1';
			add.
	firstPage snippetBuilder
		string: 'The Second Snippet in Page 1';
		add.
	firstPageFirstSnippet snippetBuilder
		string: 'Child snippet in Page 1';
		add.

	secondPage := thirdDatabase pageBuilder
			title: 'Page 2';
			add.
	secondPageFirstSnippet := secondPage snippetBuilder
			string: 'The First Snippet in Page 2';
			add.
	secondPage snippetBuilder
		string: 'The Second Snippet in Page 2';
		add.
	secondPageFirstSnippet snippetBuilder
		string: 'Child snippet in Page 2';
		add.

	^ logicalDatabase
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> logicalDatabaseWithTwoDatabases [
	<gtExample>
	<return: #LeLogicalDatabase>
	| primaryDatabase secondaryDatabase logicalDatabase firstPage firstPageFirstSnippet secondPage secondPageFirstSnippet |
	primaryDatabase := self primaryDatabase.
	secondaryDatabase := self secondaryDatabase.

	logicalDatabase := LeLogicalDatabase new
			primaryDB: primaryDatabase;
			addDB: secondaryDatabase;
			yourself.

	firstPage := primaryDatabase pageBuilder
			title: 'Page 1';
			add.

	firstPageFirstSnippet := firstPage snippetBuilder
			string: 'The First Snippet in Page 1';
			add.
	firstPage snippetBuilder
		string: 'The Second Snippet in Page 1';
		add.
	firstPageFirstSnippet snippetBuilder
		string: 'Child snippet in Page 1';
		add.

	secondPage := secondaryDatabase pageBuilder
			title: 'Page 2';
			add.
	secondPageFirstSnippet := secondPage snippetBuilder
			string: 'The First Snippet in Page 2';
			add.
	secondPage snippetBuilder
		string: 'The Second Snippet in Page 2';
		add.
	secondPageFirstSnippet snippetBuilder
		string: 'Child snippet in Page 2';
		add.

	^ logicalDatabase
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> primaryDatabase [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore |
	folderReference := FileSystem memory / 'storage-main'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference
]

{ #category : #'examples - addition' }
LeExplicitlyAttachedLinksExamples >> readdPageWithIncomingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage currentLink linksAddedAnnouncements |
	database := self removePageWithIncomingExplicitLinks.
	firstPage := database pageNamed: 'Page 1'.

	linksAddedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinkAddedAnnouncement
		send: #add:
		to: linksAddedAnnouncements.

	currentLink := database explicitLinks first.

	secondPage := database pageBuilder
			title: 'Page 2';
			build.
	secondPage basicUid: currentLink targetReference pageUid.
	database addPage: secondPage.

	self assert: database explicitLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.
	self assert: linksAddedAnnouncements size equals: 0.

	self assert: currentLink originReference content equals: firstPage.
	self assert: currentLink targetReference content equals: secondPage.
	self assert: currentLink targetReference pageUid equals: secondPage uid.

	self assert: firstPage outgoingExplicitLinks size equals: 1.
	self assert: firstPage incomingLinks size equals: 0.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 1.

	^ database
]

{ #category : #'examples - addition' }
LeExplicitlyAttachedLinksExamples >> readdPageWithIncomingExplicitLinksFromOtherDatabasePage [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase targetDatabase firstPage secondPage currentLink linksAddedAnnouncements |
	logicalDatabase := self
			removePageWithIncomingExplicitLinksFromOtherDatabasePage.
	firstPage := logicalDatabase pageNamed: 'Page 1'.

	linksAddedAnnouncements := OrderedCollection new.
	logicalDatabase weak
		when: LeExplicitLinkAddedAnnouncement
		send: #add:
		to: linksAddedAnnouncements.

	currentLink := logicalDatabase primaryDB explicitLinks first.

	targetDatabase := logicalDatabase registeredDBs first.
	secondPage := targetDatabase pageBuilder
			title: 'Page 2';
			build.
	secondPage basicUid: currentLink targetReference pageUid.
	targetDatabase addPage: secondPage.

	self assert: logicalDatabase explicitLinksCount equals: 1.
	self assert: logicalDatabase textualSnippetsLinksCount equals: 0.
	self assert: linksAddedAnnouncements size equals: 0.

	self assert: currentLink originReference content equals: firstPage.
	self assert: currentLink targetReference content equals: secondPage.
	self assert: currentLink targetReference pageUid equals: secondPage uid.

	self assert: firstPage outgoingExplicitLinks size equals: 1.
	self assert: firstPage incomingLinks size equals: 0.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 1.

	^ logicalDatabase
]

{ #category : #'examples - addition' }
LeExplicitlyAttachedLinksExamples >> readdPageWithIncomingExplicitLinksFromOtherDatabasePage_sameTitleButDifferentUid [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage secondPage currentLink |
	logicalDatabase := self
			removePageWithIncomingExplicitLinksFromOtherDatabasePage.
	firstPage := logicalDatabase pageNamed: 'Page 1'.

	secondPage := logicalDatabase registeredDBs first pageBuilder
			title: 'Page 2';
			add.

	currentLink := logicalDatabase primaryDB explicitLinks first.

	self assert: logicalDatabase explicitLinksCount equals: 1.
	self assert: logicalDatabase textualSnippetsLinksCount equals: 0.

	self assert: currentLink targetReference content equals: nil.
	self assert: currentLink targetReference pageUid ~= secondPage uid.

	self assert: firstPage outgoingExplicitLinks size equals: 1.
	self assert: firstPage incomingLinks size equals: 0.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> removeExplicitLinkBetweenPages [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage explicitLink |
	database := self databaseWithExplicitLinkBetweenPages.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.
	explicitLink := database explicitLinks items first.

	database removeExplicitLinks: {explicitLink}.

	self assert: (database hasExplicitLinkUID: explicitLink linkUuid) not.
	self assert: database explicitLinksCount equals: 0.

	self assert: firstPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - page links' }
LeExplicitlyAttachedLinksExamples >> removeExplicitLinkBetweenPagesFromDifferentDatabases [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage secondPage explicitLink |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.
	firstPage := logicalDatabase pageNamed: 'Page 1'.
	secondPage := logicalDatabase pageNamed: 'Page 2'.
	explicitLink := logicalDatabase primaryDB explicitLinks items first.

	logicalDatabase primaryDB removeExplicitLinks: {explicitLink}.

	self
		assert: (logicalDatabase primaryDB hasExplicitLinkUID: explicitLink linkUuid) not.
	self assert: logicalDatabase primaryDB explicitLinksCount equals: 0.

	self assert: firstPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removePageWithIncomingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage currentLink linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenPages.
	secondPage := database pageNamed: 'Page 2'.
	firstPage := database pageNamed: 'Page 1'.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	secondPage removeSelf.
	self assert: database explicitLinksCount equals: 1.
	self assert: database textualSnippetsLinksCount equals: 0.
	self assert: linksRemovedAnnouncements size equals: 0.

	self assert: currentLink targetReference content equals: nil.
	self assert: currentLink targetReference pageUid equals: secondPage uid.

	self assert: firstPage outgoingExplicitLinks size equals: 1.
	self assert: firstPage incomingLinks size equals: 0.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removePageWithIncomingExplicitLinksFromOtherDatabasePage [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase firstPage secondPage currentLink linksRemovedAnnouncements |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.
	secondPage := logicalDatabase pageNamed: 'Page 2'.
	firstPage := logicalDatabase pageNamed: 'Page 1'.
	currentLink := logicalDatabase primaryDB explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	logicalDatabase weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	secondPage removeSelf.
	self assert: logicalDatabase explicitLinksCount equals: 1.
	self assert: logicalDatabase textualSnippetsLinksCount equals: 0.
	self assert: linksRemovedAnnouncements size equals: 0.

	self assert: currentLink targetReference content equals: nil.
	self assert: currentLink targetReference pageUid equals: secondPage uid.

	self assert: firstPage outgoingExplicitLinks size equals: 1.
	self assert: firstPage incomingLinks size equals: 0.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removePageWithOutgoingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database currentLink firstPage secondPage linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenPages.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	firstPage removeSelf.
	self assert: database explicitLinksCount equals: 0.
	self assert: database textualSnippetsLinksCount equals: 0.

	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks items first
		equals: currentLink.

	self assert: firstPage outgoingExplicitLinks size equals: 0.
	self assert: firstPage incomingLinks size equals: 0.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removePageWithOutgoingExplicitLinksToOtherDatabasePage [
	<gtExample>
	<return: #LeLogicalDatabase>
	| logicalDatabase currentLink firstPage secondPage linksRemovedAnnouncements |
	logicalDatabase := self logicalDatabaseWithExplicitLinkBetweenPages.
	firstPage := logicalDatabase pageNamed: 'Page 1'.
	secondPage := logicalDatabase pageNamed: 'Page 2'.
	currentLink := logicalDatabase primaryDB explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	logicalDatabase weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	firstPage removeSelf.
	self assert: logicalDatabase primaryDB explicitLinksCount equals: 0.
	self assert: logicalDatabase registeredDBs first explicitLinksCount equals: 0.
	self assert: logicalDatabase explicitLinksCount equals: 0.

	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks items first
		equals: currentLink.

	self assert: firstPage outgoingExplicitLinks size equals: 0.
	self assert: firstPage incomingLinks size equals: 0.

	self assert: secondPage outgoingExplicitLinks size equals: 0.
	self assert: secondPage incomingLinks size equals: 0.

	^ logicalDatabase
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removePageWithSnippetWithIncomingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage firstSnippet secondSnippet currentLink linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenSnippets.
	firstPage := database pageNamed: 'Page 1'.
	firstSnippet := firstPage children first.
	secondPage := database pageNamed: 'Page 2'.
	secondSnippet := secondPage children first.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	secondPage removeSelf.
	self assert: database explicitLinks size equals: 1.
	self assert: linksRemovedAnnouncements size equals: 0.

	self assert: currentLink targetReference content equals: nil.
	self assert: currentLink targetReference snippetUid equals: secondSnippet uid.

	self assert: firstSnippet outgoingExplicitLinks size equals: 1.
	self assert: firstSnippet incomingLinks size equals: 0.

	self assert: secondSnippet outgoingExplicitLinks size equals: 0.
	self assert: secondSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removePageWithSnippetWithOutgoingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage firstSnippet secondSnippet linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenSnippets.
	firstPage := database pageNamed: 'Page 1'.
	secondPage := database pageNamed: 'Page 2'.
	firstSnippet := firstPage children first.
	secondSnippet := secondPage children first.
	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.
	firstPage removeSelf.
	self assert: database explicitLinks size equals: 0.
	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self assert: firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: firstSnippet incomingLinks size equals: 0.
	self assert: secondSnippet outgoingExplicitLinks size equals: 0.
	self assert: secondSnippet incomingLinks size equals: 0.
	^ database
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removeSnippetWithChildSnippetsWithIncomingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database secondPage firstSnippet childSnippet currentLink linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenChildSnippets.
	secondPage := database pageNamed: 'Page 2'.
	firstSnippet := secondPage children first.
	childSnippet := firstSnippet children first.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	firstSnippet removeSelf.
	self assert: database explicitLinks size equals: 1.
	self assert: linksRemovedAnnouncements size equals: 0.

	self assert: currentLink targetReference content equals: nil.
	self assert: currentLink targetReference snippetUid equals: childSnippet uid.

	^ database
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removeSnippetWithChildSnippetsWithOutgoingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage firstSnippet linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenChildSnippets.
	firstPage := database pageNamed: 'Page 1'.
	firstSnippet := firstPage children first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	firstSnippet removeSelf.
	self assert: database explicitLinks isEmpty.
	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.
	self assert: linksRemovedAnnouncements size equals: 1.

	^ database
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removeSnippetWithIncomingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage firstSnippet secondSnippet currentLink linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenSnippets.
	firstPage := database pageNamed: 'Page 1'.
	firstSnippet := firstPage children first.
	secondPage := database pageNamed: 'Page 2'.
	secondSnippet := secondPage children first.
	currentLink := database explicitLinks items first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	secondSnippet removeSelf.
	self assert: database explicitLinks size equals: 1.
	self assert: linksRemovedAnnouncements size equals: 0.

	self assert: currentLink targetReference content equals: nil.
	self assert: currentLink targetReference snippetUid equals: secondSnippet uid.

	self assert: firstSnippet outgoingExplicitLinks size equals: 1.
	self assert: firstSnippet incomingLinks size equals: 0.

	self assert: secondSnippet outgoingExplicitLinks size equals: 0.
	self assert: secondSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - explicit links' }
LeExplicitlyAttachedLinksExamples >> removeSnippetWithOutgoingExplicitLinks [
	<gtExample>
	<return: #LeDatabase>
	| database firstPage secondPage firstSnippet secondSnippet linksRemovedAnnouncements |
	database := self databaseWithExplicitLinkBetweenSnippets.
	firstPage := database pageNamed: 'Page 1'.
	firstSnippet := firstPage children first.
	secondPage := database pageNamed: 'Page 2'.
	secondSnippet := secondPage children first.

	linksRemovedAnnouncements := OrderedCollection new.
	database weak
		when: LeExplicitLinksRemovedAnnouncement
		send: #add:
		to: linksRemovedAnnouncements.

	firstSnippet removeSelf.
	self assert: database explicitLinks isEmpty.
	self assert: linksRemovedAnnouncements size equals: 1.
	self
		assert: linksRemovedAnnouncements first removedExplicitLinks size
		equals: 1.

	self assert: firstSnippet outgoingExplicitLinks size equals: 0.
	self assert: firstSnippet incomingLinks size equals: 0.

	self assert: secondSnippet outgoingExplicitLinks size equals: 0.
	self assert: secondSnippet incomingLinks size equals: 0.

	^ database
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> secondaryDatabase [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore |
	folderReference := FileSystem memory / 'storage-secondary'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference
]

{ #category : #'examples - database' }
LeExplicitlyAttachedLinksExamples >> thirdDatabase [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore |
	folderReference := FileSystem memory / 'storage-third'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference
]
