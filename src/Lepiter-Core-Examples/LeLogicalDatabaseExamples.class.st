Class {
	#name : #LeLogicalDatabaseExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #'examples - modifications' }
LeLogicalDatabaseExamples >> addDatabaseOnePage [
	<gtExample>
	| aDatabase aPage aCollection |
	aDatabase := self logicalDatabaseWithPrimaryWorkspaceAndAdditionalDBS.

	aCollection := OrderedCollection new.
	aDatabase when: LeDatabasePageAdded send: #add: to: aCollection.
	aPage := aDatabase registeredDBs first pageBuilder uniqueTitle; add.
	
	self assert: aCollection size equals: 1.
	self assert: aCollection first database equals: aDatabase registeredDBs first.
	self assert: aCollection first page equals: aPage.
	
	^ aCollection first
]

{ #category : #'examples - support' }
LeLogicalDatabaseExamples >> addPagesToDatabase: aDatabase prefix: aPrefix [
	<gtEample>
	| aPage |
	aPage := aDatabase pageBuilder
		title: aPrefix asString , 'Page1';
		add.
	aPage
		addSnippet: (LeTextSnippet string: aPrefix asString , 'Page1 Snippet1').
	aPage := aDatabase pageBuilder
		title: aPrefix asString , 'Page2';
		add.
	aPage
		addSnippet: (LeTextSnippet string: aPrefix asString , 'Page2 Snippet1').
	aPage := aDatabase pageBuilder
		title: aPrefix asString , 'Page3';
		add.
	aPage
		addSnippet: (LeTextSnippet string: aPrefix asString , 'Page3 Snippet1').
	aPage := aDatabase pageBuilder
		title: aPrefix asString , 'Page4';
		add.
	aPage
		addSnippet: (LeTextSnippet string: aPrefix asString , 'Page4 Snippet1').
	^ aDatabase
]

{ #category : #'examples - support' }
LeLogicalDatabaseExamples >> addPagesToWorkspaceDatabase: aDatabase [
	<gtEample>
	| aPage |
	aPage := LePage unnamedPage.
	aPage addSnippet: (LeTextSnippet string: '4+3').
	aDatabase addPage: aPage.
	
	aPage := LePage pharoClassName: #SmallInteger.
	aPage addSnippet: (LeTextSnippet string: 'self asString').
	self assert: aPage type isPharoClassPageType.
	aDatabase addPage: aPage.
	
	^ aDatabase
]

{ #category : #'examples - modifications' }
LeLogicalDatabaseExamples >> addPrimaryDatabasePage [
	<gtExample>
	| aDatabase aPage aCollection |
	aDatabase := self logicalDatabaseWithPrimaryAndWorkspaceDBS.

	aCollection := OrderedCollection new.
	aDatabase when: LeDatabasePageAdded send: #add: to: aCollection.
	aPage := aDatabase primaryDB pageBuilder uniqueTitle; add.
	
	self assert: aCollection size equals: 1.
	self assert: aCollection first database equals: aDatabase primaryDB.
	self assert: aCollection first page equals: aPage.
	
	^ aCollection first
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> additionalOneDatabase [
	<gtExample>
	| aDirectory aDatabase |
	aDirectory := self additionalOneDatabaseDirectory.
	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aDirectory.
	^ aDatabase
]

{ #category : #'examples - directories' }
LeLogicalDatabaseExamples >> additionalOneDatabaseDirectory [
	<gtExample>
	^ self databaseDirectoryNamed: 'additional one'
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> additionalOneDatabaseWithPages [
	<gtExample>
	| aDatabase |
	aDatabase := self additionalOneDatabase.

	self addPagesToDatabase: aDatabase prefix: 'Additional One '.
	
	^ aDatabase
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> additionalTwoDatabase [
	<gtExample>
	| aDirectory aDatabase |
	aDirectory := self additionalTwoDatabaseDirectory.
	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aDirectory.
	^ aDatabase
]

{ #category : #'examples - directories' }
LeLogicalDatabaseExamples >> additionalTwoDatabaseDirectory [
	<gtExample>
	^ self databaseDirectoryNamed: 'additional two'
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> additionalTwoDatabaseWithPages [
	<gtExample>
	| aDatabase |
	aDatabase := self additionalTwoDatabase.
	
	self addPagesToDatabase: aDatabase prefix: 'Additional Two '.
	
	^ aDatabase
]

{ #category : #'examples - accessing' }
LeLogicalDatabaseExamples >> anyOne [
	<gtExample>
	| database |

	database := self primaryAndWorkspaceDB.

	self assert: database anyOne
		equals: database primaryDB children first.

	^ database
]

{ #category : #'examples - accessing' }
LeLogicalDatabaseExamples >> atforPageType [
	"Demonstrate LeLogicalDatabase>>at:forPageType:"
	<gtExample>
	| database page |

	database := self primaryAndWorkspaceDB.
	page := database at: #Page1 forPageType: LeNamedPageType.
	self assert: page title equals: #Page1.

	page := database pageNamed: #Page2.
	self assert: page title equals: #Page2.

	^ database
]

{ #category : #'examples - accessing' }
LeLogicalDatabaseExamples >> children [
	"Demonstrate LeLogicalDatabase>>children"
	<gtExample>
	| database |

	database := self primaryAndWorkspaceDB.

	self assert: database children size equals: 6.

	^ database
]

{ #category : #'examples - cross database' }
LeLogicalDatabaseExamples >> crossDatabaseLinkLoadPlayground [
	"Check that a link to an external database is correctly resolved when the target database is loaded"
	<gtExample>
	| logicalDB linkText primaryDB playgroundDB targetPage sourcePage |

	primaryDB := self primaryDatabase.
	playgroundDB := self workspaceDatabase.

	targetPage := LePage named: #TargetPage.
	targetPage addSnippet: (LeTextSnippet string: 'target page').
	playgroundDB addPage: targetPage.

	linkText := String streamContents: [ :stream |
		stream
			<< '{{gtPage:';
			<< targetPage title;
			<< '|db=';
			<< playgroundDB uuid asString36;
			<< '}}' ].

	sourcePage := LePage named: #SourcePage.
	sourcePage addSnippet: (LeTextSnippet string: linkText).
	primaryDB addPage: sourcePage.

	logicalDB := LeLogicalDatabase primaryDB: primaryDB.

	"At this point the link hasn't been resolved"
	self assert: sourcePage children first outgoingTextualLinks first targetReference content isNil.

	logicalDB playgroundDB: playgroundDB.

	"Now the link has been resolved"
	self assert: sourcePage children first outgoingTextualLinks first targetReference content isNotNil.

]

{ #category : #'examples - cross database' }
LeLogicalDatabaseExamples >> crossDatabaseLinkLoadRegistered [
	"Check that a link to an external database is correctly resolved when the target database is loaded"
	<gtExample>
	| logicalDB linkText primaryDB registeredDB targetPage sourcePage |

	primaryDB := self primaryDatabase.
	registeredDB := self additionalOneDatabase.

	targetPage := LePage named: #TargetPage.
	targetPage addSnippet: (LeTextSnippet string: 'target page').
	registeredDB addPage: targetPage.

	linkText := String streamContents: [ :stream |
		stream
			<< '{{gtPage:';
			<< targetPage title;
			<< '|db=';
			<< registeredDB uuid asString36;
			<< '}}' ].

	sourcePage := LePage named: #SourcePage.
	sourcePage addSnippet: (LeTextSnippet string: linkText).
	primaryDB addPage: sourcePage.

	logicalDB := LeLogicalDatabase 
		primaryDB: primaryDB
		playgroundDB: self workspaceDatabase.

	"At this point the link hasn't been resolved"
	self assert: sourcePage children first outgoingTextualLinks first targetReference content isNil.

	logicalDB addDB: registeredDB.

	"Now the link has been resolved"
	self assert: sourcePage children first outgoingTextualLinks first targetReference content isNotNil.

]

{ #category : #'examples - directories' }
LeLogicalDatabaseExamples >> databaseDirectoryNamed: aName [
	<gtExample>
	| aStore aFile |
	aStore := FileSystem memory.
	aFile := aStore workingDirectory / 'lepiterdbs' / aName asString.
	aFile ensureCreateDirectory.
	^ aFile.
]

{ #category : #'examples - accessing' }
LeLogicalDatabaseExamples >> databasesDoWithPrimaryAndWorkspaceDB [
	<gtExample>
	| database collection |

	database := self primaryAndWorkspaceDB.

	collection := OrderedCollection new.
	database databasesDo: [ :eachDatabase | 
		collection add: eachDatabase ].

	self assert: collection size equals: 2.
	self assert: collection first equals: database primaryDB.
	self assert: collection second equals: database playgroundDB.
	
	^ database
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> logicalDatabaseWithPrimaryAndWorkspaceDBS [
	<gtExample>
	"Answer a logical database with primary and workspace DBs, and:
	- Four pages in the primary DB.
	- An unnamed page in the workspace DB.
	- An pharo class snippet in the workspace DB."
	^ LeLogicalDatabase 
		primaryDB: self primaryDatabaseWithPages
		playgroundDB: self workspaceDatabaseWithPages.
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> logicalDatabaseWithPrimaryWorkspaceAndAdditionalDBS [
	<gtExample>
	"Answer a logical database with primary and workspace DBs, and:
	- Four pages in the primary DB.
	- An unnamed page in the workspace DB.
	- An pharo class snippet in the workspace DB."
	^ LeLogicalDatabase new
		primaryDB: self primaryDatabaseWithPages;
		playgroundDB: self workspaceDatabaseWithPages;
		addDB: self additionalOneDatabaseWithPages;
		addDB: self additionalTwoDatabaseWithPages;
		yourself.
]

{ #category : #'examples - accessing' }
LeLogicalDatabaseExamples >> pagesByDate [
	"Demonstrate LeLogicalDatabase>>pagesByDate"
	<gtExample>
	<noTest>
	| database pagesByDate |

	database := self primaryAndWorkspaceDB.
	pagesByDate := database pagesByDate.

	self assert: pagesByDate first type class equals: LePharoClassPageType.
	self assert: pagesByDate first children first string equals: 'self asString'.
	
	self assert: pagesByDate last type class equals: LeNamedPageType.
	self assert: pagesByDate last title equals: #Page1.

	^ database
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> primaryAndWorkspaceDB [
	<gtExample>
	"Answer a logical database with primary and workspace DBs, and:
	- Four pages in the primary DB.
	- An unnamed page in the workspace DB.
	- An pharo class snippet in the workspace DB."
	| database primaryDB workspaceDB |

	primaryDB := LeDatabase new.
	workspaceDB := LeDatabase new.
	database := (LeLogicalDatabase primaryDB: primaryDB)
		playgroundDB: workspaceDB;
		yourself.

	self assert: database isDatabase.
	self assert: database primaryDB equals: primaryDB.
	self assert: database playgroundDB equals: workspaceDB.

	self addPagesToDatabase: primaryDB prefix: ''.
	self addPagesToWorkspaceDatabase: workspaceDB.

	self assert: database pageCount equals: 6.
	self assert: database size equals: 6.

	^ database
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> primaryDatabase [
	<gtExample>
	| aDirectory aDatabase |
	aDirectory := self primaryDatabaseDirectory.
	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aDirectory.
	^ aDatabase
]

{ #category : #'examples - directories' }
LeLogicalDatabaseExamples >> primaryDatabaseDirectory [
	<gtExample>
	^ self databaseDirectoryNamed: 'primary'
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> primaryDatabaseWithPages [
	<gtExample>
	| aDatabase |
	aDatabase := self primaryDatabase.
	
	self addPagesToDatabase: aDatabase prefix: 'Primary '.
	
	^ aDatabase
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> workspaceDatabase [
	<gtExample>
	| aDirectory aDatabase |
	aDirectory := self workspaceDatabaseDirectory.
	aDatabase := LeLocalStoreLoad current loadAndMonitorFrom: aDirectory.
	^ aDatabase
]

{ #category : #'examples - directories' }
LeLogicalDatabaseExamples >> workspaceDatabaseDirectory [
	<gtExample>
	^ self databaseDirectoryNamed: 'workspace'
]

{ #category : #'examples - database' }
LeLogicalDatabaseExamples >> workspaceDatabaseWithPages [
	<gtExample>
	| aDatabase |
	aDatabase := self workspaceDatabase.
	
	self addPagesToWorkspaceDatabase: aDatabase.
	
	^ aDatabase
]
