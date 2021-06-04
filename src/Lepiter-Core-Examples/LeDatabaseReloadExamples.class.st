"
LeDatabaseReloadExamples demonstrates the scenario where a database is opened, the underlying files are changed and the database reloaded.  The database doesn't monitor the file system.  This scenario arises when an image is saved with the database open, the database is then modified without saving the image and the image is opened again.


"
Class {
	#name : #LeDatabaseReloadExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'temporaryDirectory'
	],
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeDatabaseReloadExamples >> addAttachedLink [
	"Demonstrate adding a link and reloading the database.
	Load the database a second time, add a link, reload the first database instance and confirm it contains the new link"

	<gtExample>
	| db1 db2 |
	db1 := self createDatabase.
	self populateAttachedLinksIn: db1.
	db2 := LeLocalStoreLoad current
		loadAndMonitorFrom: db1 monitor localRoot
		saveDelay: 0 seconds.
	
	db2 addExplicitLink: (LeAttachedLink new 
		originReference: (LeLinkPageUidReference forPageUid: (db2 pageNamed: #Page2) uid);
		targetReference: (LeLinkPageUidReference forPageUid: (db2 pageNamed: #Page1) uid)).
	db2 stopMonitoring.
	
	self deny: db1 explicitLinks size equals: 2.
	self assert: (db1 pageNamed: #Page1) incomingLinks isEmpty.
	
	db1 reload.
	self assert: db1 explicitLinks size equals: 2.
	self assert: (db1 pageNamed: #Page1) incomingLinks size equals: 1.
	
	^ { db1. db2 }
]

{ #category : #examples }
LeDatabaseReloadExamples >> addPage [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	| page db1 db2 |
	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current
		loadAndMonitorFrom: db1 monitor localRoot
		saveDelay: 0 seconds.
	page := LePage named: #Page3.
	page addSnippet: (LeTextSnippet string: #Page3Snippet1).
	db2 addPage: page.
	db2 stopMonitoring.
	self deny: (db1 hasPageNamed: #Page3).
	db1 reload.
	self assert: (db1 hasPageNamed: #Page3).
	self
		assert: (db1 pageNamed: #Page3) children first string
		equals: #Page3Snippet1
]

{ #category : #examples }
LeDatabaseReloadExamples >> addSnippets [
	"Demonstrate adding snippets at first and last positions and reloading the database"

	<gtExample>
	| page db1 db2 |
	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current
		loadAndMonitorFrom: db1 monitor localRoot
		saveDelay: 0 seconds.
	page := db2 pageNamed: #Page2.
	page addSnippet: (LeTextSnippet string: #AddedSnippet).
	page
		addSnippet: (LeTextSnippet string: #'111')
		before: page children first.
	db2 stopMonitoring.
	page := db1 pageNamed: #Page2.
	self assert: page childrenCount equals: 2.
	db1 reload.
	self assert: page childrenCount equals: 4.
	self assert: (page children at: 4) string equals: #AddedSnippet.
	self assert: page children first string equals: #'111'
]

{ #category : #private }
LeDatabaseReloadExamples >> createDatabase [
	| fileSystem db |

	fileSystem := FileSystem memory.
	db := self newDb: 'db1' root: fileSystem root.
	self populate: db.
	^ db

]

{ #category : #private }
LeDatabaseReloadExamples >> createDatabaseOnDisk [
	| db |

	temporaryDirectory := FileReference newTempFilePrefix: self class name, '-' suffix: '-testDbs'.
	db := self newDb: 'db1' root: temporaryDirectory.
	self populate: db.
	^ db

]

{ #category : #private }
LeDatabaseReloadExamples >> deleteTemporaryDirectory [

	temporaryDirectory ifNotNil: 	
		[ temporaryDirectory ensureDeleteAll ]
]

{ #category : #examples }
LeDatabaseReloadExamples >> loadDatabaseFromDiskMaintainsLinksUid [
	"Verify that loading a databae from disk maintains the uid for the explicit links container."

	<gtExample>
	| db1 db2 |
	db1 := self createDatabase.
	self populateAttachedLinksIn: db1.
	self assert: db1 explicitLinks uid notNil.
	
	db2 := LeLocalStoreLoad current
		loadAndMonitorFrom: db1 monitor localRoot
		saveDelay: 0 seconds.
		
	self assert: db2 explicitLinks uid notNil.
	self assert: db2 explicitLinks uid equals: db1 explicitLinks uid.
	self assert: db1 explicitLinks size equals: 1.
	self assert: db2 explicitLinks size equals: 1.
	
	^ { db1 . db2 }
]

{ #category : #examples }
LeDatabaseReloadExamples >> loadDatabaseFromDiskWithNoLinks [
	"Verify that loading a database from disk with no links does not update the container uid."

	<gtExample>
	| db1 db2 |
	db1 := self createDatabase.
	
	db2 := LeLocalStoreLoad current
		loadAndMonitorFrom: db1 monitor localRoot
		saveDelay: 0 seconds.
		
	self assert: db1 explicitLinks uid isNil.
	self assert: db2 explicitLinks uid isNil.
	self assert: db1 explicitLinks isEmpty.
	self assert: db2 explicitLinks isEmpty.
	
	^ { db1 . db2 }
]

{ #category : #'examples - Logical DB' }
LeDatabaseReloadExamples >> logicalDatabaseReload [
	"This tests the basic scenario of reloading the primary, playground and registered databases are reloaded."
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB |

	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	logicalDB := LeLogicalDatabase primaryDB: primaryDB playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	logicalDB properties: (LeLogicalDatabaseProperties new 
		localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
		primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
		playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
		addRegisteredDirectory: registeredDB localStoreRootDirectory).

	"Confirm that each DB is in the expected state"
	{ primaryDB. playgroundDB. registeredDB. } do: [ :db |
		self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].

	"Using a separate DB instance, update the page"
	{ primaryDB. playgroundDB. registeredDB. } do: [ :db | | dbDuplicate |
		dbDuplicate := LeLocalStoreLoad current 
			loadAndMonitorFrom: db localStoreRootDirectory
			saveDelay: 0 seconds.
		(dbDuplicate pageNamed: #Page1) children first updateText: db databaseName asRopedText.
		dbDuplicate stopMonitoring ].

	"Reload the logical database"
	logicalDB primaryDB reload.

	"Confirm that each DB has the updated page"
	{ primaryDB. playgroundDB. registeredDB. } do: [ :db |
		self assert: (db pageNamed: #Page1) children first string equals: db databaseName ].

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeDatabaseReloadExamples >> logicalDatabaseReloadAddRegistered [
	"Reload the logical database, adding a registered database."
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB |

	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	registeredDB stopMonitoring.
	logicalDB := LeLogicalDatabase primaryDB: primaryDB playgroundDB: playgroundDB.
	logicalDB properties: (LeLogicalDatabaseProperties new 
		localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
		primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
		playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
		addRegisteredDirectory: registeredDB localStoreRootDirectory).
	registeredDB := nil.

	"Confirm that each DB is in the expected state"
	logicalDB databasesDo: [ :db |
		self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: logicalDB registeredDBs isEmpty.

	"Reload the logical database"
	logicalDB primaryDB reload.

	"Confirm that the registered DB has appeared"
	self assert: logicalDB registeredDBs size equals: 1.
	self assert: logicalDB registeredDBs first databaseName equals: #registered.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeDatabaseReloadExamples >> logicalDatabaseReloadShuffle [
	"Reload a logical DB swapping the primary and registered DBs"
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB |

	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	logicalDB := LeLogicalDatabase primaryDB: primaryDB playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	logicalDB properties: (LeLogicalDatabaseProperties new 
		localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
		primaryDatabaseDirectory: registeredDB localStoreRootDirectory;
		playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
		addRegisteredDirectory: primaryDB localStoreRootDirectory).

	"Confirm that each DB is in the expected state"
	logicalDB databasesDo: [ :db |
		self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].

	"Reload the logical database"
	logicalDB primaryDB reload.

	"Confirm that the databases have been swapped, and the instance identity maintained"
	self assert: logicalDB primaryDB identicalTo: registeredDB.
	self assert: logicalDB playgroundDB identicalTo: playgroundDB.
	self assert: logicalDB registeredDBs first identicalTo: primaryDB.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeDatabaseReloadExamples >> logicalDatabaseReloadUnloadRegistered [
	"Reload the logical database, minus the previously registered directory"
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB unloadAnnouncements |

	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	logicalDB := LeLogicalDatabase primaryDB: primaryDB playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	unloadAnnouncements := OrderedCollection new.
	{ primaryDB. playgroundDB. registeredDB. } do: [ :db |
		db when: LeUnloadAnnouncement do: [ :announcement |
			unloadAnnouncements add: announcement ] ].
	logicalDB properties: (LeLogicalDatabaseProperties new 
		localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
		primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
		playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory).

	"Confirm that each DB is in the expected state"
	{ primaryDB. playgroundDB. registeredDB. } do: [ :db |
		self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].

	"Using a separate DB instance, update the page"
	{ primaryDB. playgroundDB. } do: [ :db | | dbDuplicate |
		dbDuplicate := LeLocalStoreLoad current 
			loadAndMonitorFrom: db localStoreRootDirectory
			saveDelay: 0 seconds.
		(dbDuplicate pageNamed: #Page1) children first updateText: db databaseName asRopedText.
		dbDuplicate stopMonitoring ].

	"Reload the logical database"
	logicalDB primaryDB reload.

	"Confirm that each DB has the updated page"
	{ primaryDB. playgroundDB. } do: [ :db |
		self assert: (db pageNamed: #Page1) children first string equals: db databaseName ].

	"Confirm that the registered DB unload has been announced"
	self assert: unloadAnnouncements size equals: 6.
	self assert: unloadAnnouncements last content equals: registeredDB.
	self assert: unloadAnnouncements first content equals: 
		(registeredDB pageNamed: #Page1) children first.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeDatabaseReloadExamples >> logicalPrimaryDatabaseReset [
	"This simulates the scenario where the lepiter app is distributed with a primary DB assumed, but is run for the first time on a new machine"
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB rootDir propertiesBasename |

	logicalDB := LeLogicalDatabase primaryDB: self createDatabaseOnDisk.
	rootDir := logicalDB primaryDB localStoreRootDirectory.
	logicalDB properties: (LeLogicalDatabaseProperties new 
		localFile: (rootDir parent / LepiterCoreDefaults logicalDatabasePropertiesBasename);
		primaryDatabaseDirectory: rootDir).
	propertiesBasename := logicalDB primaryDB monitor propertiesBasename.

	self assert: (rootDir / propertiesBasename) exists.
	self assert: (rootDir childrenMatching: '*.lepiter') size equals: 2.

	rootDir ensureDeleteAll.

	self deny: rootDir exists.

	logicalDB primaryDB reload.

	self assert: (rootDir / propertiesBasename) exists.
	self assert: logicalDB primaryDB pageCount equals: 0.
	^ logicalDB
]

{ #category : #examples }
LeDatabaseReloadExamples >> modifySnippet [
	"Demonstrate modifying text snippets and reloading the database"
	<gtExample>
	| page db1 db2 |

	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current loadAndMonitorFrom: db1 monitor localRoot saveDelay: 0 seconds.
	(db2 pageNamed: #Page2) children first updateString: #ModifiedSnippet2.
	((db2 pageNamed: #Page2) children at: 2) updateString: #'4+3+2'.
	db2 stopMonitoring.

	page := db1 pageNamed: #Page2.
	self assert: page children first string equals: #Snippet2.
	self assert: (page children at: 2) string equals: #'4+3'.
	db1 reload.
	self assert: page children first string equals: #ModifiedSnippet2.
	self assert: (page children at: 2) string equals: #'4+3+2'.

]

{ #category : #private }
LeDatabaseReloadExamples >> newDb: dbName root: aFileReference [
	| dbDir database |

	dbDir := aFileReference / dbName.
	dbDir ensureCreateDirectory.
	database := LeLocalStoreLoad current loadAndMonitorFrom: dbDir saveDelay: 0 seconds.
	database userEmail: dbName,'@example.com'.
	^ database
]

{ #category : #private }
LeDatabaseReloadExamples >> populate: aLeDatabase [
	| page |
	page := LePage named: #Page1.
	page addSnippet: (LeTextSnippet string: #Snippet1).
	aLeDatabase addPage: page.
	page := LePage named: #Page2.
	page addSnippet: (LeTextSnippet string: #Snippet2).
	page addSnippet: (LeTextSnippet string: #'4+3').
	aLeDatabase addPage: page.
	^ aLeDatabase
]

{ #category : #private }
LeDatabaseReloadExamples >> populateAttachedLinksIn: aLeDatabase [
	| pageOne pageTwo |
	pageOne := aLeDatabase pageNamed: #Page1.
	pageTwo := aLeDatabase pageNamed: #Page2.
	
	pageOne addExplicitLinkTo: (LeLinkPageUidReference forPageUid: pageTwo uid).
	^ aLeDatabase
]

{ #category : #examples }
LeDatabaseReloadExamples >> reloadUpdatesUserEmail [
	"Confirm that reloading a database updates the userEmail from the lepiter.properties"
	<gtExample>
	| db1 properties |

	db1 := self createDatabase.

	"Modify the properties so that it doesn't affect db1's instances"
	properties := db1 monitor dbProperties copy.
	properties at: #userEmail put: 'db1-2@example.com'.
	db1 monitor savePropertiesDictionary: properties.

	"db1 userEmail should be unchanged"
	self assert: db1 userEmail email equals: 'db1@example.com'.

	db1 reload.
	self assert: db1 userEmail email equals: 'db1-2@example.com'.

]

{ #category : #examples }
LeDatabaseReloadExamples >> removePage [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"
	<gtExample>
	| db1 db2 |

	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current loadAndMonitorFrom: db1 monitor localRoot saveDelay: 0 seconds.
	db2 removePage: (db2 pageNamed: #Page1).
	db2 stopMonitoring.

	self assert: (db1 hasPageNamed: #Page1).
	self assert: (db1 pageNamed: #Page1) children first string equals: #Snippet1.
	db1 reload.
	self deny: (db1 hasPageNamed: #Page1).

]

{ #category : #examples }
LeDatabaseReloadExamples >> removeSnippet [
	"Demonstrate modifying text & pharo snippets and reloading the database"
	<gtExample>
	| page db1 db2 |

	db1 := self createDatabase.
	db2 := LeLocalStoreLoad current loadAndMonitorFrom: db1 monitor localRoot saveDelay: 0 seconds.
	page := db2 pageNamed: #Page2.
	page removeSnippet: page children first.
	db2 stopMonitoring.

	page := db1 pageNamed: #Page2.
	self assert: page childrenCount equals: 2.
	self assert: page children first string equals: #Snippet2.
	self assert: (page children at: 2) string equals: #'4+3'.
	db1 reload.
	self assert: page childrenCount equals: 1.
	self assert: page children first string equals: #'4+3'.

]

{ #category : #examples }
LeDatabaseReloadExamples >> setPageUpdatesPageProperties [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	| page db1 |
	db1 := self createDatabase.
	page := LePage named: #Page3.
	page addSnippet: (LeTextSnippet string: #Page3Snippet1).
	db1 setPage: page.
	self assert: page uid isNotNil.
	self assert: page createTime isNotNil.
	self assert: page editTime isNotNil.
	self assert: page createEmail equals: db1 userEmail.
	self assert: page editEmail equals: db1 userEmail
]

{ #category : #examples }
LeDatabaseReloadExamples >> setPageUpdatesSnippetProperties [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	| page snippet db1 |
	db1 := self createDatabase.
	page := LePage named: #Page3.
	snippet := page addSnippet: (LeTextSnippet string: #Page3Snippet1).
	db1 setPage: page.
	self assert: snippet uid isNotNil.
	self assert: snippet createTime isNotNil.
	self assert: snippet editTime isNotNil.
	self assert: snippet createEmail equals: db1 userEmail.
	self assert: snippet editEmail equals: db1 userEmail
]

{ #category : #examples }
LeDatabaseReloadExamples >> setSnippetUpdatesSnippetProperties [
	"Demonstrate adding a page and reloading the database.
	Load the database a second time, add a page, reload the first database instance and confirm it contains the new page"

	<gtExample>
	| page newSnippet db1 |
	db1 := self createDatabase.
	page := LePage named: #Page3.
	page addSnippet: (LeTextSnippet string: #Page3Snippet1).
	db1 addPage: page.
	newSnippet := LeTextSnippet string: #Page3Snippet2.
	page addSnippet: newSnippet.
	self assert: newSnippet uid isNotNil.
	self assert: newSnippet createTime isNotNil.
	self assert: newSnippet editTime isNotNil.
	self assert: newSnippet createEmail equals: db1 userEmail.
	self assert: newSnippet editEmail equals: db1 userEmail
]
