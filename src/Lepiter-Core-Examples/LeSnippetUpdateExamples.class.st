"
{{gtClass:LeSnippetUpdateExamples}} provides the logic for testing that existing snippets are correctly loaded from storage, when snippets exists both in storage (for example on disk) and in memory, and their content differs between the two. 

This case happens when a snippet is modified, the contend is written to disk, and the image is closed without saving. When the image is opened again, the content of the snippet should be loaded from storage.

{{gtClass:LeSnippetUpdateExamples}} tests this by changing the content on disk while the monitor is stopped and doing a reload. By this is tests the reload at the leve of the knowledge base.
"
Class {
	#name : #LeSnippetUpdateExamples,
	#superclass : #Object,
	#instVars : [
		'memoryStorageFolder'
	],
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #testing }
LeSnippetUpdateExamples class >> isAbstract [
	^ self = LeSnippetUpdateExamples
]

{ #category : #actions }
LeSnippetUpdateExamples >> addSnippetsInPage: targetPage [
	self subclassResponsibility
]

{ #category : #asserting }
LeSnippetUpdateExamples >> assertSnippetsModifiedInPage: aTargetPage [ 
	self subclassResponsibility
]

{ #category : #'examples - database' }
LeSnippetUpdateExamples >> databaseWithMockedStorage [
	<gtExample>
	<return: #LeDatabase>
	| folderReference localStore |
	folderReference := memoryStorageFolder
			ifNil: [ memoryStorageFolder := FileSystem memory / 'storage'.
				memoryStorageFolder ensureCreateDirectory ].

	localStore := LeLocalStoreLoad new
			storage: LeMockLocalJsonV4StorageWithFilesOrder new.
	localStore localRoot: folderReference.
	^ localStore loadAndMonitorFrom: folderReference saveDelay: Duration zero
]

{ #category : #actions }
LeSnippetUpdateExamples >> modifySnippetsInPage: aPage [.
	self subclassResponsibility
]

{ #category : #'examples - snippets' }
LeSnippetUpdateExamples >> pageWithSnippets [
	<gtExample>
	<return: #SubclassResponsibility>
	| database targetPage |
	database := self databaseWithMockedStorage.
	targetPage := LePage named: 'PageOne'.
	targetPage basicUid: (UUID fromString: '00000000-0000-0000-0000-000000000001').
	database addPage: targetPage.

	self addSnippetsInPage: targetPage.

	self assert: database pages size equals: 1.
	self assert: database pages first children size equals: 1.

	^ database
]

{ #category : #'examples - snippets' }
LeSnippetUpdateExamples >> pageWithSnippetsChangedWhileMonitorStopped [
	<gtExample>
	<return: #SubclassResponsibility>
	| mainDatabase secondDatabase targetPageSecondDatabase |
	mainDatabase := self pageWithSnippets.
	mainDatabase monitor stopMonitoring.	"We create another database on the same storag and use it to change the snippet,
	while the monitor of the initial database is stopped."
	secondDatabase := self secondDatabaseWithMockedStorage.

	targetPageSecondDatabase := secondDatabase pageNamed: 'PageOne'.
	self modifySnippetsInPage: targetPageSecondDatabase.
	self assert: secondDatabase pages size equals: 1.

	secondDatabase stopMonitoring.

	^ mainDatabase
]

{ #category : #'examples - snippets' }
LeSnippetUpdateExamples >> reloadPageWithChangedSnippetsInStorage [
	<gtExample>
	<return: #SubclassResponsibility>
	| database targetPageInFirstDatabase |
	database := self pageWithSnippetsChangedWhileMonitorStopped.
	database monitor startMonitoring.

	database reload.

	targetPageInFirstDatabase := database pageNamed: 'PageOne'.	"Custom assert to check that the snippet was updated correctly."
	self assertSnippetsModifiedInPage: targetPageInFirstDatabase.

	self assert: database pages size equals: 1.
	self assert: database pages first children size equals: 1.

	^ database
]

{ #category : #'examples - database' }
LeSnippetUpdateExamples >> secondDatabaseWithMockedStorage [
	<gtExample>
	<return: #LeDatabase>
	| localStore folderReference |
	folderReference := memoryStorageFolder
			ifNil: [ memoryStorageFolder := FileSystem memory / 'storage'.
				memoryStorageFolder ensureCreateDirectory ].

	localStore := LeLocalStoreLoad new
			storage: LeMockLocalJsonV4StorageWithFilesOrder new.
	localStore localRoot: folderReference.

	^ localStore loadAndMonitorFrom: folderReference saveDelay: Duration zero
]
