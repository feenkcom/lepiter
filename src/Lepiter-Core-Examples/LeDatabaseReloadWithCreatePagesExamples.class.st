Class {
	#name : #LeDatabaseReloadWithCreatePagesExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeDatabaseReloadWithCreatePagesExamples >> addOneLinkToNewPage [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo firstSnippet |
	database := self addOnePageWithNoLinks.
	pageOne := database pageNamed: 'PageOne'.

	pageTwo := LePage named: 'PageTwo'.
	pageTwo addSnippet: (LeTextSnippet string: #snippet).
	pageTwo basicUid: (UUID fromString: '00000000-0000-0000-0000-000000000002').
	database addPage: pageTwo.

	firstSnippet := pageOne children first.
	firstSnippet updateString: 'Link to [[PageTwo]]'.

	self assert: database pageCount equals: 2.
	self assert: database explicitLinksCount equals: 1.

	^ database
]

{ #category : #examples }
LeDatabaseReloadWithCreatePagesExamples >> addOnePageWithNoLinks [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne |
	database := self databaseWithMockedStorage.
	pageOne := LePage named: 'PageOne'.
	pageOne basicUid: (UUID fromString: '00000000-0000-0000-0000-000000000001').
	database addPage: pageOne.

	pageOne snippetBuilder
		string: 'snippet';
		add.

	self assert: database pages size equals: 1.

	^ database
]

{ #category : #examples }
LeDatabaseReloadWithCreatePagesExamples >> databaseWithMockedStorage [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore |
	folderReference := FileSystem memory / 'storage'.
	folderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad new
			storage: LeMockLocalJsonV4StorageWithFilesOrder new.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference saveDelay: Duration zero
]

{ #category : #examples }
LeDatabaseReloadWithCreatePagesExamples >> reloadPageOneAndThenPageTwo [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removePageTwoRemoveLinksAndRestorePageOneWithMonitorStopped.
	database monitor startMonitoring.

	LeReloadOptimization disableDuring: [ database reload ].

	self assert: database pageCount equals: 2.
	self assert: database explicitLinksCount equals: 1.
	self assert: (database hasPageNamed: 'PageOne').
	self assert: (database hasPageNamed: 'PageTwo').

	^ database
]

{ #category : #examples }
LeDatabaseReloadWithCreatePagesExamples >> reloadPageOneAndThenPageTwo_OptimizedReload [
	<gtExample>
	<return: #LeDatabase>
	| database |
	database := self removePageTwoRemoveLinksAndRestorePageOneWithMonitorStopped.
	database monitor startMonitoring.

	LeReloadOptimization enableDuring: [ database reload ].

	self assert: database pageCount equals: 2.
	self assert: database explicitLinksCount equals: 1.
	self assert: (database hasPageNamed: 'PageOne').
	self assert: (database hasPageNamed: 'PageTwo').

	^ database
]

{ #category : #examples }
LeDatabaseReloadWithCreatePagesExamples >> removePageTwoRemoveLinksAndRestorePageOneWithMonitorStopped [
	<gtExample>
	<return: #LeDatabase>
	| database pageOne pageTwo firstSnippet |
	database := self addOneLinkToNewPage.
	database monitor stopMonitoring.

	pageOne := database pageNamed: 'PageOne'.
	pageTwo := database pageNamed: 'PageTwo'.
	pageTwo children first removeSelf.

	firstSnippet := pageOne children first.
	firstSnippet updateText: 'snippet' asRopedText.

	self assert: database pageCount equals: 1.
	self assert: database explicitLinksCount equals: 0.

	self assert: (database monitor pageFileReference: pageOne) exists.
	self assert: (database monitor pageFileReference: pageTwo) exists.

	^ database
]
