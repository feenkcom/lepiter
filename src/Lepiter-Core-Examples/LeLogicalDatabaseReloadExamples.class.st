Class {
	#name : #LeLogicalDatabaseReloadExamples,
	#superclass : #LeBasicDatabaseReloadExamples,
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReload [
	"This tests the basic scenario of reloading the primary, playground and registered databases are reloaded."
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB announcements |

	"Store all the received announcements"
	announcements := OrderedCollection new.
	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	logicalDB := LeLogicalDatabase new.
	logicalDB when: LeDatabaseAnnouncement do: [ :announcement | announcements add: announcement ].
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
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

	"Confirm that each DB has been reloaded correctly"
	{ primaryDB. playgroundDB. registeredDB. } do: [ :db |
		"Confirm that each DB has the updated page"
		self assert: (db pageNamed: #Page1) children first string equals: db databaseName.
		"Confirm that each DB has the logical DB as its parent"
		self assert: db parent equals: logicalDB. ].

	self assert: announcements size equals: 3.
	self assert: (announcements collect: #database as: Array) equals:
		{ primaryDB. playgroundDB. registeredDB. }.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadAddRegistered [
	"Reload the logical database, adding a registered database."
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB announcements |

	"Store all the received announcements"
	announcements := OrderedCollection new.
	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	registeredDB stopMonitoring.
	logicalDB := LeLogicalDatabase new.
	logicalDB when: LeDatabaseAnnouncement do: [ :announcement | announcements add: announcement ].
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
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
	self assert: announcements size equals: 2.

	"Reload the logical database"
	logicalDB primaryDB reload.

	"Confirm that the registered DB has appeared"
	self assert: logicalDB registeredDBs size equals: 1.
	self assert: logicalDB registeredDBs first databaseName equals: #registered.
	self assert: announcements size equals: 3.
	self assert: (announcements collect: [ :each | each database databaseName ] as: Array) equals:
		{ #primary. #playground. #registered. }.
	self assert: logicalDB registeredDBs first parent equals: logicalDB.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadShuffle [
	"Reload a logical DB swapping the primary and registered DBs"
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB announcements |

	"Store all the received announcements"
	announcements := OrderedCollection new.
	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	logicalDB := LeLogicalDatabase new.
	logicalDB when: LeDatabaseAnnouncement do: [ :announcement | announcements add: announcement ].
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	logicalDB properties: (LeLogicalDatabaseProperties new 
		localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
		primaryDatabaseDirectory: registeredDB localStoreRootDirectory;
		playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
		addRegisteredDirectory: primaryDB localStoreRootDirectory).

	"Confirm that each DB is in the expected state"
	logicalDB databasesDo: [ :db |
		self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: announcements size equals: 3.

	"Reload the logical database"
	logicalDB primaryDB reload.

	"Confirm that the databases have been swapped, and the instance identity maintained"
	self assert: logicalDB primaryDB identicalTo: registeredDB.
	self assert: logicalDB playgroundDB identicalTo: playgroundDB.
	self assert: logicalDB registeredDBs first identicalTo: primaryDB.
	self assert: announcements size equals: 3.
	self assert: (announcements collect: #database as: Array) equals:
		{ primaryDB. playgroundDB. registeredDB. }.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadUnloadRegistered [
	"Reload the logical database, minus the previously registered directory"
	<gtExample>
	<after: #deleteTemporaryDirectory>
	| logicalDB primaryDB playgroundDB registeredDB unloadAnnouncements announcements |

	"Store all the received announcements from the logicalDB"
	announcements := OrderedCollection new.
	primaryDB := self createDatabaseOnDisk.
	primaryDB databaseName: #primary.
	playgroundDB := self newDb: 'playground' root: temporaryDirectory.
	playgroundDB databaseName: #playground.
	self populate: playgroundDB.
	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.
	logicalDB := LeLogicalDatabase new.
	logicalDB when: LeDatabaseAnnouncement do: [ :announcement | announcements add: announcement ].
	logicalDB when: LeDatabaseUnloadAnnouncement do: [ :announcement | announcements add: announcement ].
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
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
	self assert: announcements size equals: 3.

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
	self assert: (announcements collect: #database as: Array) equals:
		{ primaryDB. playgroundDB. registeredDB. registeredDB. }.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalPrimaryDatabaseReset [
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
	"To prevent new pages created by the user during the reload from being deleted, the reload currently doesn't delete pages.  This should be 0, but accept 2 for now."
	self assert: logicalDB primaryDB pageCount equals: 2.
	^ logicalDB
]
