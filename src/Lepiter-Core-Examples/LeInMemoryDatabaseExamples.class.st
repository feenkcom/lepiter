Class {
	#name : #LeInMemoryDatabaseExamples,
	#superclass : #Object,
	#instVars : [
		'storeRootDirectory',
		'registeredDatabases'
	],
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #'examples - database' }
LeInMemoryDatabaseExamples >> addEmptyPageNamed: aPageTitle into: aDatabase [
	<gtExample>
	| aPage aPageCount aLinkCount |
	aPageCount := aDatabase pages size.
	aLinkCount := aDatabase explicitLinks size.

	aPage := aDatabase pageBuilder
			title: aPageTitle;
			add.

	self assert: aDatabase pages size equals: 1 + aPageCount.
	self assert: aDatabase explicitLinks size equals: aLinkCount.

	self assert: (aDatabase pageNamed: aPageTitle) == aPage.

	^ aPage
]

{ #category : #after }
LeInMemoryDatabaseExamples >> cleanUp [
	self registeredDatabases do: [ :aDatabase | self cleanUpDatabase: aDatabase ].

	storeRootDirectory ifNotNil: [ :aDir | self cleanUpDirectory: aDir ]
]

{ #category : #after }
LeInMemoryDatabaseExamples >> cleanUpDatabase: aDatabase [
	aDatabase stopMonitoring
]

{ #category : #after }
LeInMemoryDatabaseExamples >> cleanUpDirectory: aDir [
	"do nothing since we store it in memory"

	
]

{ #category : #constants }
LeInMemoryDatabaseExamples >> databaseOneName [
	^ 'Database One'
]

{ #category : #constants }
LeInMemoryDatabaseExamples >> databaseTwoName [
	^ 'Database Two'
]

{ #category : #'examples - database' }
LeInMemoryDatabaseExamples >> emptyDatabaseNamed: aDatabaseName [
	<gtExample>
	<after: #cleanUp>
	| aDatabase aFolderReference localStore aDirectoryName |
	aDirectoryName := GtFileUtility
			secureFileName: self registeredDatabases size asString , ' ' , aDatabaseName
			extension: ''.
	aFolderReference := self storeRootDirectory / aDirectoryName.
	aFolderReference ensureCreateDirectory.

	localStore := LeLocalStoreLoad current.
	localStore localRoot: aFolderReference.
	aDatabase := localStore
			loadAndMonitorFrom: aFolderReference
			saveDelay: 0 seconds.
	aDatabase databaseName: aDatabaseName.
	self registerDatabase: aDatabase.

	self assert: aDatabase databaseName equals: aDatabaseName.
	self assert: aDatabase pages size equals: 0.
	self assert: aDatabase explicitLinks size equals: 0.

	^ aDatabase
]

{ #category : #'examples - database' }
LeInMemoryDatabaseExamples >> logicalDatabaseWithPageLinks_AddDbOneThenDbTwo [
	<gtExample>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aLogicalDatabase |
	aResult := self twoDatabasesWithPageLinks.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseOne.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	aLogicalDatabase addDB: aDatabaseTwo.

	self assert: aDatabaseOne explicitLinks size equals: 0.
	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #'examples - database' }
LeInMemoryDatabaseExamples >> logicalDatabaseWithPageLinks_AddDbTwoThenDbOne [
	<gtExample>
	<return: #LeTwoDatabasesExampleResult>
	| aResult aDatabaseOne aDatabaseTwo aLogicalDatabase |
	aResult := self twoDatabasesWithPageLinks.
	aDatabaseOne := aResult databaseOne.
	aDatabaseTwo := aResult databaseTwo.

	aLogicalDatabase := LeLogicalDatabase primaryDB: aDatabaseTwo.

	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	aLogicalDatabase addDB: aDatabaseOne.

	self assert: aDatabaseOne explicitLinks size equals: 0.
	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved.

	^ LeTwoDatabasesExampleResult new
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aResult pageOne;
		pageTwo: aResult pageTwo;
		pageTwoSnippet: aResult pageTwoSnippet;
		logicalDatabase: aLogicalDatabase
]

{ #category : #constants }
LeInMemoryDatabaseExamples >> pageOneName [
	^ 'Page One'
]

{ #category : #constants }
LeInMemoryDatabaseExamples >> pageTwoName [
	^ 'Page Two'
]

{ #category : #'examples - database' }
LeInMemoryDatabaseExamples >> registerDatabase: aDatabase [
	<gtExample>
	<after: #cleanUp>
	registeredDatabases := self registeredDatabases copyWith: aDatabase
]

{ #category : #'examples - database' }
LeInMemoryDatabaseExamples >> registeredDatabases [
	^ registeredDatabases ifNil: [ #() ]
]

{ #category : #'examples - storage' }
LeInMemoryDatabaseExamples >> storeRootDirectory [
	<gtExample>
	<after: #cleanUp>
	<return: #FileReference>
	^ storeRootDirectory ifNil: [ storeRootDirectory := FileSystem memory root ]
]

{ #category : #'examples - database' }
LeInMemoryDatabaseExamples >> twoDatabasesWithPageLinks [
	<gtExample>
	<return: #LeTwoDatabasesExampleResult>
	| aDatabaseOne aDatabaseTwo aPageOne aPageTwo aPageOneRemoteLink aPageTwoSnippet |
	aDatabaseOne := self emptyDatabaseNamed: self databaseOneName.
	aDatabaseTwo := self emptyDatabaseNamed: self databaseTwoName.

	aPageOne := self addEmptyPageNamed: self pageOneName into: aDatabaseOne.
	aPageTwo := self addEmptyPageNamed: self pageTwoName into: aDatabaseTwo.

	aPageOneRemoteLink := aPageOne asRemoteLink.
	aPageTwoSnippet := aPageTwo snippetBuilder
			string: aPageOneRemoteLink , '  ';
			add.

	self assert: aDatabaseOne explicitLinks size equals: 0.
	self assert: aDatabaseTwo explicitLinks size equals: 1.
	self assert: aDatabaseTwo explicitLinks first targetReference isResolved not.

	^ LeTwoDatabasesExampleResult new
		databaseOne: aDatabaseOne;
		databaseTwo: aDatabaseTwo;
		pageOne: aPageOne;
		pageTwo: aPageTwo;
		pageTwoSnippet: aPageTwoSnippet
]
