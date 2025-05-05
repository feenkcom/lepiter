Class {
	#name : #LeDatabaseReloadInEmptyDatabaseExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadContentFromStorage [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self databaseWithMonitorStoppedAndNoPagesInMemory.
	database monitor startMonitoring.

	database monitor reload.

	self assert: database pages size equals: 2.
	self assert: (database hasPageNamed: 'PageOne').
	self assert: (database hasPageNamed: 'PageTwo').

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadContentFromStorageWithRemovedLinksInStorage [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo externalLink1 externalLink2 linksFile jsonContent |
	database := self databaseWithPagesAndExternallyAttachedLinks.
	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	externalLink1 := LeAttachedLink new
			originReference: (LeLinkSnippetUidReference forSnippetUid: pageOne children first uid);
			targetReference: (LeLinkSnippetUidReference forSnippetUid: pageTwo children first uid).
	database addExplicitLink: externalLink1.
	externalLink2 := LeAttachedLink new
			originReference: (LeLinkSnippetUidReference forSnippetUid: pageOne children first uid);
			targetReference: (LeLinkPageUidReference forPageUid: pageTwo uid).
	database addExplicitLink: externalLink2.

	linksFile := database monitor explicitLinksFileReference.
	jsonContent := STONJSON fromString: linksFile contents.
	jsonContent at: #items put: {(jsonContent at: #items) last}.

	linksFile
		writeStreamDo: [ :aStream | STONJSON put: jsonContent onStream: aStream ].

	self assert: database explicitLinksCount equals: 3.
	database monitor reload.
	self assert: database explicitLinksCount equals: 1.
	self assert: database explicitLinks first == externalLink2.

	self assert: database pages size equals: 2.
	self assert: (database hasPageNamed: 'PageOne').
	self assert: (database hasPageNamed: 'PageTwo').

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadExplicitLinksAndPagesFromStorageInEmptyDatabase [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo explicitLink |
	database := self databaseWithMonitorStoppedAndExplicitLinkAndPagesRemoved.
	database monitor startMonitoring.

	database monitor reload.

	explicitLink := database explicitLinks first.
	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	self assert: database pageCount equals: 2.
	self assert: database explicitLinksCount equals: 1.
	self assert: pageOne outgoingExplicitLinks size equals: 1.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: pageTwo incomingLinks size equals: 1.
	self assert: pageTwo outgoingExplicitLinks size equals: 0.

	self assert: explicitLink originReference isResolved.
	self assert: explicitLink targetReference isResolved.
	self assert: explicitLink originReference content equals: pageOne.
	self assert: explicitLink targetReference content equals: pageTwo.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadExplicitLinksFromStorageInDatabaseWithNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo explicitLink |
	database := self databaseWithMonitorStoppedAndExplicitLinkRemoved.
	database monitor startMonitoring.

	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	database monitor reload.

	explicitLink := database explicitLinks first.

	self assert: database explicitLinks size equals: 1.
	self assert: pageOne outgoingExplicitLinks size equals: 1.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: pageTwo incomingLinks size equals: 1.
	self assert: pageTwo outgoingExplicitLinks size equals: 0.

	self assert: explicitLink originReference isResolved.
	self assert: explicitLink targetReference isResolved.
	self assert: explicitLink originReference content equals: pageOne.
	self assert: explicitLink targetReference content equals: pageTwo.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadExplicitLinksFromStorageInDatabaseWithSameLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo explicitLink |
	database := self databaseWithPagesAndExternallyAttachedLinks.
	database monitor startMonitoring.

	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	database monitor reload.

	explicitLink := database explicitLinks first.

	self assert: database explicitLinks size equals: 1.
	self assert: pageOne outgoingExplicitLinks size equals: 1.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: pageTwo incomingLinks size equals: 1.
	self assert: pageTwo outgoingExplicitLinks size equals: 0.

	self assert: explicitLink originReference isResolved.
	self assert: explicitLink targetReference isResolved.
	self assert: explicitLink originReference content equals: pageOne.
	self assert: explicitLink targetReference content equals: pageTwo.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadExplicitLinksUidFromStorage [
	<gtExample>
	<return: #LeDatabase>
	| database currentUuid |
	database := self databaseWithMonitorStoppedAndExplicitLinkRemoved.
	currentUuid := database explicitLinks uid.
	database explicitLinks clearUid.
	self assert: database explicitLinks uid isNil.

	database monitor reload.

	self assert: database explicitLinks uid notNil.
	self assert: database explicitLinks uid equals: currentUuid.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadPagesAndTexualAndAttachedLinksFromStorageInEmptyDatabase [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo |
	database := self databaseWithPagesAndTexualAndAttachedLinks.

	database monitor stopMonitoring.
	database removePage: (database pageNamed: 'PageOne').
	database removePage: (database pageNamed: 'PageTwo').
	database removeExplicitLinks: database explicitLinks.
	self assert: database pageCount equals: 0.
	self assert: database explicitLinksCount equals: 0.

	database monitor startMonitoring.
	database monitor reload.

	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	self assert: database explicitLinksCount equals: 3.
	self assert: pageOne outgoingExplicitLinks size equals: 1.
	self assert: pageOne allChildOutgoingLinks size equals: 2.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: pageTwo incomingLinks size equals: 2.
	self assert: pageTwo outgoingExplicitLinks size equals: 0.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseReloadPagesAndTexualAndAttachedLinksFromStorageInUnchangedDatabase [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo |
	database := self databaseWithPagesAndTexualAndAttachedLinks.
	database monitor startMonitoring.

	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	database monitor reload.

	self assert: database explicitLinks size equals: 3.
	self assert: pageOne outgoingExplicitLinks size equals: 1.
	self assert: pageOne allChildOutgoingLinks size equals: 2.
	self assert: pageOne incomingLinks size equals: 0.
	self assert: pageTwo incomingLinks size equals: 2.
	self assert: pageTwo outgoingExplicitLinks size equals: 0.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseWithMonitor [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore |
	folderReference := FileSystem memory / 'storage'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference saveDelay: Duration zero
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseWithMonitorStoppedAndExplicitLinkAndPagesRemoved [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo explicitLink |
	database := self databaseWithPagesAndExternallyAttachedLinks.
	database monitor stopMonitoring.
	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	explicitLink := database explicitLinks first.
	database removeExplicitLinks: {explicitLink}.

	pageOne removeSelf.
	pageTwo removeSelf.

	self assert: database explicitLinksCount equals: 0.
	self assert: database pageCount equals: 0.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseWithMonitorStoppedAndExplicitLinkRemoved [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo explicitLink |
	database := self databaseWithPagesAndExternallyAttachedLinks.
	database monitor stopMonitoring.
	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	explicitLink := database explicitLinks first.
	database removeExplicitLinks: {explicitLink}.

	self assert: database explicitLinks size equals: 0.
	self assert: pageOne outgoingExplicitLinks size equals: 0.
	self assert: pageTwo incomingLinks size equals: 0.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseWithMonitorStoppedAndNoPagesInMemory [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo |
	database := self databaseWithPagesWithLinks.
	database monitor stopMonitoring.

	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.

	pageOne removeSelf.
	pageTwo removeSelf.

	self assert: database pages size equals: 0.
	self assert: (database monitor pageFileReference: pageOne) exists.
	self assert: (database monitor pageFileReference: pageTwo) exists.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseWithPagesAndExternallyAttachedLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo externalLink |
	database := self databaseWithMonitor.
	pageOne := database pageBuilder
			title: 'PageOne';
			add.
	pageTwo := database pageBuilder
			title: 'PageTwo';
			add.

	pageOne snippetBuilder
		string: 'Page One Content';
		add.
	pageTwo snippetBuilder
		string: 'Page Two Content';
		add.

	externalLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPageUid: pageOne uid);
			targetReference: (LeLinkPageUidReference forPageUid: pageTwo uid).
	database addExplicitLink: externalLink.

	self assert: database pages size equals: 2.
	self assert: database explicitLinks size equals: 1.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseWithPagesAndTexualAndAttachedLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo externalLink |
	database := self databaseWithMonitor.
	pageOne := database pageBuilder
			title: 'PageOne';
			add.
	pageTwo := database pageBuilder
			title: 'PageTwo';
			add.

	pageOne snippetBuilder
		string: 'Page One Conten with link [[PageTwo]]';
		add.
	pageOne snippetBuilder
		string: 'Page Two Content to [[PageThree]]';
		add.
	pageTwo snippetBuilder
		string: 'content';
		add.

	externalLink := LeAttachedLink new
			originReference: (LeLinkPageUidReference forPageUid: pageOne uid);
			targetReference: (LeLinkPageUidReference forPageUid: pageTwo uid).
	database addExplicitLink: externalLink.

	self assert: database pages size equals: 2.
	self assert: database explicitLinks size equals: 3.

	^ database
]

{ #category : #examples }
LeDatabaseReloadInEmptyDatabaseExamples >> databaseWithPagesWithLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo |
	database := self databaseWithMonitor.
	pageOne := database pageBuilder
			title: 'PageOne';
			add.
	pageTwo := database pageBuilder
			title: 'PageTwo';
			add.

	pageOne snippetBuilder
		string: 'Link to [[PageTwo]]';
		add.
	pageTwo snippetBuilder
		string: 'Link to [[PageOne]]';
		add.

	self assert: database pages size equals: 2.

	^ database
]
