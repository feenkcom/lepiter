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
	<return: #LeLogicalDatabase>
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
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
				playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
				addRegisteredDirectory: registeredDB localStoreRootDirectory).	"Confirm that each DB is in the expected state"
	{primaryDB.
		playgroundDB.
		registeredDB}
		do: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].	"Using a separate DB instance, update the page"
	{primaryDB.
		playgroundDB.
		registeredDB}
		do: [ :db | 
			| dbDuplicate |
			dbDuplicate := LeLocalStoreLoad current
					loadAndMonitorFrom: db localStoreRootDirectory
					saveDelay: 0 seconds.
			(dbDuplicate pageNamed: #Page1) children first
				updateText: db databaseName asRopedText.
			dbDuplicate stopMonitoring ].	"Reload the logical database"
	logicalDB primaryDB reload.	"Confirm that each DB has been reloaded correctly"
	{primaryDB.
		playgroundDB.
		registeredDB}
		do: [ :db "Confirm that each DB has the updated page" | 
			self
				assert: (db pageNamed: #Page1) children first string
				equals: db databaseName.	"Confirm that each DB has the logical DB as its parent"
			self assert: db parent equals: logicalDB ].

	self assert: announcements size equals: 14.
	self
		assert: ((announcements first: 3)
				allSatisfy: [ :anAnnouncement | anAnnouncement class = LeDatabasesAddedAnnouncement ]).
	self
		assert: ((announcements first: 3) collect: #database as: Array)
		equals: {primaryDB.
				playgroundDB.
				registeredDB}.
	self assert: (announcements at: 4) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 5) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 6) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 7) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 8) class equals: LeSnippetTextChanged.
	self assert: (announcements at: 8) snippet string equals: 'primary'.
	self assert: (announcements at: 9) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 10) class equals: LeSnippetTextChanged.
	self assert: (announcements at: 10) snippet string equals: 'playground'.
	self assert: (announcements at: 11) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 12) class equals: LeSnippetTextChanged.
	self assert: (announcements at: 12) snippet string equals: 'registered'.
	self assert: (announcements at: 13) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 14) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 14) database equals: logicalDB.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadAddRegistered [
	"Reload the logical database, adding a registered database."

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
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
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
				playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
				addRegisteredDirectory: registeredDB localStoreRootDirectory).
	registeredDB := nil.	"Confirm that each DB is in the expected state"
	logicalDB
		databasesDo: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: logicalDB registeredDBs isEmpty.
	self assert: announcements size equals: 2.
	self
		assert: ((announcements first: 2)
				collect: [ :each | each database databaseName ]
				as: Array)
		equals: {#primary.
				#playground}.	"Reload the logical database"
	LeReloadOptimization disableDuring: [ logicalDB primaryDB reload ].	"Confirm that the registered DB has appeared"
	self assert: logicalDB registeredDBs size equals: 1.
	self assert: logicalDB registeredDBs first databaseName equals: #registered.
	self assert: announcements size equals: 9.
	self assert: (announcements at: 3) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 4) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 4) database equals: primaryDB.
	self assert: (announcements at: 5) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 5) database equals: playgroundDB.
	self assert: (announcements at: 6) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 6) database equals: primaryDB.
	self assert: (announcements at: 7) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 7) database equals: playgroundDB.
	self assert: (announcements at: 8) class equals: LeDatabasesAddedAnnouncement.
	self assert: (announcements at: 8) database databaseName equals: #registered.
	self assert: (announcements at: 9) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 9) database equals: logicalDB.

	self assert: logicalDB registeredDBs first parent equals: logicalDB.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadAddRegistered_OptimizedReload [
	"Reload the logical database, adding a registered database."

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
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
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
				playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
				addRegisteredDirectory: registeredDB localStoreRootDirectory).
	registeredDB := nil.	"Confirm that each DB is in the expected state"
	logicalDB
		databasesDo: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: logicalDB registeredDBs isEmpty.
	self assert: announcements size equals: 2.
	self
		assert: ((announcements first: 2)
				collect: [ :each | each database databaseName ]
				as: Array)
		equals: {#primary.
				#playground}.	"Reload the logical database"
	LeReloadOptimization disableDuring: [ logicalDB primaryDB reload ].	"Confirm that the registered DB has appeared"
	self assert: logicalDB registeredDBs size equals: 1.
	self assert: logicalDB registeredDBs first databaseName equals: #registered.
	self assert: announcements size equals: 9.
	self assert: (announcements at: 3) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 4) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 4) database equals: primaryDB.
	self assert: (announcements at: 5) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 5) database equals: playgroundDB.
	self assert: (announcements at: 6) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 6) database equals: primaryDB.
	self assert: (announcements at: 7) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 7) database equals: playgroundDB.
	self assert: (announcements at: 8) class equals: LeDatabasesAddedAnnouncement.
	self assert: (announcements at: 8) database databaseName equals: #registered.
	self assert: (announcements at: 9) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 9) database equals: logicalDB.

	self assert: logicalDB registeredDBs first parent equals: logicalDB.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadShuffle [
	"Reload a logical DB swapping the primary and registered DBs"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
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
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: registeredDB localStoreRootDirectory;
				playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
				addRegisteredDirectory: primaryDB localStoreRootDirectory).	"Confirm that each DB is in the expected state"
	logicalDB
		databasesDo: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: announcements size equals: 3.	"Reload the logical database"
	LeReloadOptimization disableDuring: [ logicalDB primaryDB reload ].	"Confirm that the databases have been swapped, and the instance identity maintained"
	self assert: logicalDB primaryDB identicalTo: registeredDB.
	self assert: logicalDB playgroundDB identicalTo: playgroundDB.
	self assert: logicalDB registeredDBs first identicalTo: primaryDB.
	self assert: announcements size equals: 11.
	self
		assert: ((announcements first: 3) collect: #database as: Array)
		equals: {primaryDB.
				playgroundDB.
				registeredDB}.
	self assert: (announcements at: 4) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 5) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 6) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 7) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 8) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 9) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 10) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 11) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 11) database equals: logicalDB.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadShuffle_OptimizedReload [
	"Reload a logical DB swapping the primary and registered DBs"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
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
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: registeredDB localStoreRootDirectory;
				playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory;
				addRegisteredDirectory: primaryDB localStoreRootDirectory).	"Confirm that each DB is in the expected state"
	logicalDB
		databasesDo: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: announcements size equals: 3.	"Reload the logical database"
	LeReloadOptimization enableDuring: [ logicalDB primaryDB reload ].	"Confirm that the databases have been swapped, and the instance identity maintained"
	self assert: logicalDB primaryDB identicalTo: registeredDB.
	self assert: logicalDB playgroundDB identicalTo: playgroundDB.
	self assert: logicalDB registeredDBs first identicalTo: primaryDB.	"Databases are not reloaded, therefore only logical database reload events
	are emitted."
	self assert: announcements size equals: 5.
	self
		assert: ((announcements first: 3) collect: #database as: Array)
		equals: {primaryDB.
				playgroundDB.
				registeredDB}.
	self assert: (announcements at: 4) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 5) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 5) database equals: logicalDB.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadUnloadRegistered [
	"Reload the logical database, minus the previously registered directory"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
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
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	unloadAnnouncements := OrderedCollection new.
	{primaryDB.
		playgroundDB.
		registeredDB}
		do: [ :db | 
			db weak
				when: LeUnloadAnnouncement
				send: #add:
				to: unloadAnnouncements ].
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
				playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory).	"Confirm that each DB is in the expected state"
	{primaryDB.
		playgroundDB.
		registeredDB}
		do: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: announcements size equals: 3.
	self
		assert: (announcements collect: #class as: Set) asArray
		equals: {LeDatabasesAddedAnnouncement}.	"Using a separate DB instance, update the page"
	{primaryDB.
		playgroundDB}
		do: [ :db | 
			| dbDuplicate |
			dbDuplicate := LeLocalStoreLoad current
					loadAndMonitorFrom: db localStoreRootDirectory
					saveDelay: 0 seconds.
			(dbDuplicate pageNamed: #Page1) children first
				updateText: db databaseName asRopedText.
			dbDuplicate stopMonitoring ].

	self assert: announcements size equals: 3.	"Reload the logical database"
	LeReloadOptimization disableDuring: [ logicalDB primaryDB reload ].	"Confirm that each DB has the updated page"
	{primaryDB.
		playgroundDB}
		do: [ :db | 
			self
				assert: (db pageNamed: #Page1) children first string
				equals: db databaseName ].	"Confirm that the registered DB unload has been announced"
	self assert: unloadAnnouncements size equals: 6.
	self assert: unloadAnnouncements last content equals: registeredDB.
	self
		assert: unloadAnnouncements first content
		equals: (registeredDB pageNamed: #Page1) children first.

	self assert: announcements size equals: 13.
	self assert: (announcements at: 4) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 5) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 5) database equals: primaryDB.
	self assert: (announcements at: 6) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 6) database equals: playgroundDB.
	self assert: (announcements at: 7) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 7) database equals: registeredDB.
	self assert: (announcements at: 8) class equals: LeDatabaseUnloadAnnouncement.
	self assert: (announcements at: 8) database equals: registeredDB.
	self assert: (announcements at: 9) class equals: LeSnippetTextChanged.
	self assert: (announcements at: 9) snippet string equals: 'primary'.
	self assert: (announcements at: 10) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 10) database equals: primaryDB.
	self assert: (announcements at: 11) class equals: LeSnippetTextChanged.
	self assert: (announcements at: 11) snippet string equals: 'playground'.
	self assert: (announcements at: 12) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 12) database equals: playgroundDB.
	self assert: (announcements at: 13) class equals: LeLogicalDatabaseReloaded.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseReloadUnloadRegistered_OptimizedReload [
	"Reload the logical database, minus the previously registered directory"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
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
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB
		primaryDB: primaryDB;
		playgroundDB: playgroundDB.
	logicalDB addDB: registeredDB.
	unloadAnnouncements := OrderedCollection new.
	{primaryDB.
		playgroundDB.
		registeredDB}
		do: [ :db | 
			db weak
				when: LeUnloadAnnouncement
				send: #add:
				to: unloadAnnouncements ].
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
				playgroundDatabaseDirectory: playgroundDB localStoreRootDirectory).	"Confirm that each DB is in the expected state"
	{primaryDB.
		playgroundDB.
		registeredDB}
		do: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].
	self assert: announcements size equals: 3.
	self
		assert: (announcements collect: #class as: Set) asArray
		equals: {LeDatabasesAddedAnnouncement}.	"Using a separate DB instance, update the page"
	{primaryDB.
		playgroundDB}
		do: [ :db | 
			| dbDuplicate |
			dbDuplicate := LeLocalStoreLoad current
					loadAndMonitorFrom: db localStoreRootDirectory
					saveDelay: 0 seconds.
			(dbDuplicate pageNamed: #Page1) children first
				updateText: db databaseName asRopedText.
			dbDuplicate stopMonitoring ].

	self assert: announcements size equals: 3.	"Reload the logical database"
	LeReloadOptimization enableDuring: [ logicalDB primaryDB reload ].	"Confirm that each DB has the updated page"
	{primaryDB.
		playgroundDB}
		do: [ :db | 
			self
				assert: (db pageNamed: #Page1) children first string
				equals: db databaseName ].	"Confirm that the registered DB unload has been announced"
	self assert: unloadAnnouncements size equals: 6.
	self assert: unloadAnnouncements last content equals: registeredDB.
	self
		assert: unloadAnnouncements first content
		equals: (registeredDB pageNamed: #Page1) children first.

	self assert: announcements size equals: 12.
	self assert: (announcements at: 4) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 5) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 5) database equals: primaryDB.
	self assert: (announcements at: 6) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 6) database equals: playgroundDB.
	self assert: (announcements at: 7) class equals: LeDatabaseUnloadAnnouncement.
	self assert: (announcements at: 7) database equals: registeredDB.
	self assert: (announcements at: 8) class equals: LeSnippetTextChanged.
	self assert: (announcements at: 8) snippet string equals: 'primary'.
	self assert: (announcements at: 9) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 9) database equals: primaryDB.
	self assert: (announcements at: 10) class equals: LeSnippetTextChanged.
	self assert: (announcements at: 10) snippet string equals: 'playground'.
	self assert: (announcements at: 11) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 11) database equals: playgroundDB.
	self assert: (announcements at: 12) class equals: LeLogicalDatabaseReloaded.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseWithFileLocatorRootReload [
	"This tests the basic scenario of reloading the primary database and a registered databases when the individual databases use a file locator. This should not create a new instance for any of the existing databases on reload. This example exists as we had bug where were using both file references and file locators to the same folder that were causing databases to be recreated instead of being updated."

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
	| logicalDB primaryDB registeredDB announcements |
	"Store all the received announcements"
	announcements := OrderedCollection new.

	primaryDB := self createDatabaseOnDiskWithFileLocatorRoot.
	primaryDB databaseName: #primary.

	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.

	logicalDB := LeLogicalDatabase new.
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB primaryDB: primaryDB.
	logicalDB addDB: registeredDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
				addRegisteredDirectory: registeredDB localStoreRootDirectory).	"Confirm that each DB is in the expected state"
	{primaryDB.
		registeredDB}
		do: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].	"Reload the logical database in place without any changes"
	LeReloadOptimization disableDuring: [ logicalDB primaryDB reload ].	"Confirm that each DB has been reloaded correctly"
	{primaryDB.
		registeredDB}
		do: [  "Confirm that each DB has the same page":db | 
			self assert: (db pageNamed: #Page1) children first string equals: #Snippet1.	"Confirm that each DB has the logical DB as its parent"
			self assert: db parent equals: logicalDB ].

	self assert: announcements size equals: 8.
	self
		assert: ((announcements first: 2) collect: #class as: Set) asArray
		equals: {LeDatabasesAddedAnnouncement}.
	self
		assert: ((announcements first: 2) collect: #database as: Array)
		equals: {primaryDB.
				registeredDB}.
	self assert: (announcements at: 3) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 4) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 4) database equals: primaryDB.
	self assert: (announcements at: 5) class equals: LeDatabaseAboutToReload.
	self assert: (announcements at: 5) database equals: registeredDB.
	self assert: (announcements at: 6) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 6) database equals: primaryDB.
	self assert: (announcements at: 7) class equals: LeDatabaseReloaded.
	self assert: (announcements at: 7) database equals: registeredDB.
	self assert: (announcements at: 8) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 8) database equals: logicalDB.	"Ensure that after reload the identity of individual databases did not changed.
	The update should just reload them."
	self
		assert: logicalDB primaryDB == primaryDB
		description: 'The logical database should preserve identity'.
	self
		assert: logicalDB registeredDBs first == registeredDB
		description: 'The registered database should preserve identity'.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalDatabaseWithFileLocatorRootReload_OptimizedReload [
	"This tests the basic scenario of reloading the primary database and a registered databases when the individual databases use a file locator. This should not create a new instance for any of the existing databases on reload. This example exists as we had bug where were using both file references and file locators to the same folder that were causing databases to be recreated instead of being updated."

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
	| logicalDB primaryDB registeredDB announcements |
	"Store all the received announcements"
	announcements := OrderedCollection new.

	primaryDB := self createDatabaseOnDiskWithFileLocatorRoot.
	primaryDB databaseName: #primary.

	registeredDB := self newDb: 'registered' root: temporaryDirectory.
	registeredDB databaseName: #registered.
	self populate: registeredDB.

	logicalDB := LeLogicalDatabase new.
	logicalDB weak
		when: Announcement
		send: #add:
		to: announcements.
	logicalDB primaryDB: primaryDB.
	logicalDB addDB: registeredDB.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: temporaryDirectory / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: primaryDB localStoreRootDirectory;
				addRegisteredDirectory: registeredDB localStoreRootDirectory).	"Confirm that each DB is in the expected state"
	{primaryDB.
		registeredDB}
		do: [ :db | self assert: (db pageNamed: #Page1) children first string equals: #Snippet1 ].	"Reload the logical database in place without any changes"
	LeReloadOptimization enableDuring: [ logicalDB primaryDB reload ].	"Confirm that each DB has been reloaded correctly"
	{primaryDB.
		registeredDB}
		do: [  "Confirm that each DB has the same page":db | 
			self assert: (db pageNamed: #Page1) children first string equals: #Snippet1.	"Confirm that each DB has the logical DB as its parent"
			self assert: db parent equals: logicalDB ].

	self assert: announcements size equals: 4.
	self
		assert: ((announcements first: 2) collect: #class as: Set) asArray
		equals: {LeDatabasesAddedAnnouncement}.
	self
		assert: ((announcements first: 2) collect: #database as: Array)
		equals: {primaryDB.
				registeredDB}.
	self assert: (announcements at: 3) class equals: LeLogicalDatabaseAboutToReload.
	self assert: (announcements at: 4) class equals: LeLogicalDatabaseReloaded.
	self assert: (announcements at: 4) database equals: logicalDB.	"Ensure that after reload the identity of individual databases did not changed.
	The update should just reload them."
	self
		assert: logicalDB primaryDB == primaryDB
		description: 'The logical database should preserve identity'.
	self
		assert: logicalDB registeredDBs first == registeredDB
		description: 'The registered database should preserve identity'.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalPrimaryDatabaseReset [
	"This simulates the scenario where the lepiter app is distributed with a primary DB assumed, but is run for the first time on a new machine"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
	| logicalDB rootDir propertiesBasename announcements |
	logicalDB := LeLogicalDatabase primaryDB: self createDatabaseOnDisk.
	rootDir := logicalDB primaryDB localStoreRootDirectory.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: rootDir parent / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: rootDir).
	propertiesBasename := logicalDB primaryDB monitor propertiesBasename.

	self assert: (rootDir / propertiesBasename) exists.
	self assert: (rootDir childrenMatching: '*.lepiter') size equals: 2.

	rootDir ensureDeleteAll.

	self deny: rootDir exists.

	announcements := OrderedCollection new.
	logicalDB weak
		when: LeAnnouncement
		send: #add:
		to: announcements.
	LeReloadOptimization disableDuring: [ logicalDB primaryDB reload ].

	self assert: (rootDir / propertiesBasename) exists.	"To prevent new pages created by the user during the reload from being deleted, the reload currently doesn't delete pages.  This should be 0, but accept 2 for now."
	self assert: logicalDB primaryDB pageCount equals: 2.

	self assert: announcements isEmpty.

	^ logicalDB
]

{ #category : #'examples - Logical DB' }
LeLogicalDatabaseReloadExamples >> logicalPrimaryDatabaseReset_OptimizedReload [
	"This simulates the scenario where the lepiter app is distributed with a primary DB assumed, but is run for the first time on a new machine"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #LeLogicalDatabase>
	| logicalDB rootDir propertiesBasename announcements |
	logicalDB := LeLogicalDatabase primaryDB: self createDatabaseOnDisk.
	rootDir := logicalDB primaryDB localStoreRootDirectory.
	logicalDB
		properties: (LeLogicalDatabaseProperties new
				localFile: rootDir parent / LepiterCoreDefaults logicalDatabasePropertiesBasename;
				primaryDatabaseDirectory: rootDir).
	propertiesBasename := logicalDB primaryDB monitor propertiesBasename.

	self assert: (rootDir / propertiesBasename) exists.
	self assert: (rootDir childrenMatching: '*.lepiter') size equals: 2.

	rootDir ensureDeleteAll.

	self deny: rootDir exists.

	announcements := OrderedCollection new.
	logicalDB weak
		when: LeAnnouncement
		send: #add:
		to: announcements.
	LeReloadOptimization enableDuring: [ logicalDB primaryDB reload ].

	self assert: (rootDir / propertiesBasename) exists.	"To prevent new pages created by the user during the reload from being deleted, the reload currently doesn't delete pages.  This should be 0, but accept 2 for now."
	self assert: logicalDB primaryDB pageCount equals: 2.

	self assert: announcements isEmpty.

	^ logicalDB
]
