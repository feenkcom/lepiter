Class {
	#name : #LeLogicalDatabaseReload,
	#superclass : #Object,
	#instVars : [
		'database',
		'existingDbs',
		'primaryDirectory',
		'playgroundDirectory',
		'registeredDirectories',
		'registeredDatabases',
		'updateCommands'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #private }
LeLogicalDatabaseReload >> addCommand: aCommand [
	updateCommands add: aCommand
]

{ #category : #accessing }
LeLogicalDatabaseReload >> database [
	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReload >> database: anObject [
	database := anObject
]

{ #category : #private }
LeLogicalDatabaseReload >> dbFor: aFileReference [
	"Answer the concrete database for the supplied file reference.
	If it is an existing DB, use that instance.  If it is a new DB, load it."

	<return: #LeLogicalDatabaseReloadDatabase>
	| newDb |
	existingDbs
		detect: [ :db | db localStoreRootDirectory resolve = aFileReference resolve ]
		ifFound: [ :db | 
			^ LeLogicalDatabaseReloadDatabase new
				database: db;
				isPrimaryDB: (database primaryDB == db);
				isPlaygroundDB: (database playgroundDB = db);
				isExisting: true ].

	newDb := LeLocalStoreLoad current loadAndMonitorFrom: aFileReference.
	^ LeLogicalDatabaseReloadDatabase new
		database: newDb;
		isPrimaryDB: false;
		isPlaygroundDB: false;
		isExisting: false
]

{ #category : #private }
LeLogicalDatabaseReload >> executeUpdateCommands [
	updateCommands do: [ :each | each removeIn: database ].
	updateCommands do: [ :each | each reloadAndStartMonitoringIn: database ].
	updateCommands do: [ :each | each addIn: database ]
]

{ #category : #accessing }
LeLogicalDatabaseReload >> properties [ 

	^ database properties
]

{ #category : #actions }
LeLogicalDatabaseReload >> reload [ 
	"Reload the receiver's database.
	This may involve adding, moving or removing concrete databases.
	Stop the monitors early to provide visual feedback to the user that something is happening.
	The reload is done in four phases:
	1. Stop monitoring all DBs
	2. Shuffle and load the databases based on the properties file.
	3. Unload the unused databases.
		This notifies the UI that any windows related to the DB should be closed.
	4. Reload and start monitoring"

	"Ensure that reloading relies on new mappings from code"
	LeJsonV4 cleanUp.
	self reloadProperties.
	existingDbs := Set new.
	updateCommands := OrderedCollection new.
	
	"1. Stop monitoring all DBs"
	database databasesDo: [ :db | 
		db stopMonitoring.
		existingDbs add: db ].

	"2. Shuffle and load databases"
	self updatePrimaryAndPlaygroundDatabases.
	self updateRegisteredDatabasesAndSpaces.

	"3. Unload unused databases"
	self unloadUnusedDatabases.
	
	"execute commands from the steps 2 and 3"
	self executeUpdateCommands.
	
	database announce: (LeLogicalDatabaseReloaded new database: self).
]

{ #category : #private }
LeLogicalDatabaseReload >> reloadProperties [
	"Reload the properties file from disk.
	If no file is specified, use the current in-memory properties.
	If the file doesn't exist, revert to the default properties."
	| propertiesFile |

	propertiesFile := database properties localFile.
	propertiesFile ifNil: [ ^ self ].

	"Ensure the default properties file is at the latest version"
	propertiesFile = LepiterCoreDefaults logicalDatabasePropertiesFileReference 
		ifTrue: [ LeJsonV4LogicalPropertiesUpdater updateDefault ].

	propertiesFile exists ifFalse: [ 
		database properties: LeLogicalDatabaseProperties defaultForGlamorousToolkit.
		^ self ].

	database properties: (LeLogicalDatabaseProperties new localFile: propertiesFile)
]

{ #category : #private }
LeLogicalDatabaseReload >> unloadUnusedDatabases [
	"Unload any unused databases"

	| toBeUsed toBeRemoved |
	toBeUsed := Set new.

	updateCommands
		do: [ :aCommand | aCommand toBeUsedDatabasesDo: [ :aDb | toBeUsed add: aDb ] ].

	toBeRemoved := existingDbs asSet difference: toBeUsed asSet.

	toBeRemoved
		do: [ :db | self addCommand: (LeLogicalDatabaseReloadUpdateRemoveDb new database: db) ]
]

{ #category : #private }
LeLogicalDatabaseReload >> updatePrimaryAndPlaygroundDatabases [
	| existingPrimaryDbDir existingPlaygroundDbDir primaryDirectoryResolved playgroundDirectoryResolved primaryCommand playgroundCommand |
	primaryDirectory := self properties primaryDatabaseDirectory.
	playgroundDirectory := self properties playgroundDatabaseDirectory.
	primaryDirectoryResolved := primaryDirectory resolve.
	playgroundDirectoryResolved := playgroundDirectory resolve.	
	
	"The primary and playground databases should be re-created if they don't exist
	(allowing the Lepiter App to be started on a new machine)."
	primaryDirectory ensureCreateDirectory.
	existingPrimaryDbDir := database primaryDB localStoreRootDirectory
			ifNotNil: [ :dir | dir resolve ].
	primaryDirectoryResolved = existingPrimaryDbDir
		ifTrue: [ (self dbFor: primaryDirectory)
				ifExisting: [ :aDb | 
					primaryCommand := LeLogicalDatabaseReloadUpdateExistingPrimary new
							primaryDB: aDb ]
				ifNew: [ :aDb | self shouldNotImplement ] ]
		ifFalse: [ (self dbFor: primaryDirectory)
				ifExisting: [ :aDb | 
					primaryCommand := LeLogicalDatabaseReloadUpdateShuffledPrimary new
							primaryDB: aDb ]
				ifNew: [ :aDb | primaryCommand := LeLogicalDatabaseReloadUpdatePrimary new primaryDB: aDb ] ].

	playgroundDirectory ensureCreateDirectory.
	existingPlaygroundDbDir := database playgroundDB localStoreRootDirectory
			ifNotNil: [ :dir | dir resolve ].
	playgroundDirectoryResolved = existingPlaygroundDbDir
		ifTrue: [ (self dbFor: playgroundDirectory)
				ifExisting: [ :aDb | 
					playgroundCommand := LeLogicalDatabaseReloadUpdateExistingPlayground new
							playgroundDB: aDb;
							isAlsoPrimaryDB: (primaryCommand primaryDB = aDb) ]
				ifNew: [ :aDb | self shouldNotImplement ] ]
		ifFalse: [ (self dbFor: playgroundDirectory)
				ifExisting: [ :aDb | 
					playgroundCommand := LeLogicalDatabaseReloadUpdateShuffledPlayground new
							playgroundDB: aDb;
							isAlsoPrimaryDB: (primaryCommand primaryDB = aDb)  ]
				ifNew: [ :aDb | 
					playgroundCommand := LeLogicalDatabaseReloadUpdatePlayground new
							playgroundDB: aDb ] ].

	self addCommand: primaryCommand.
	self addCommand: playgroundCommand
]

{ #category : #private }
LeLogicalDatabaseReload >> updateRegisteredDatabasesAndSpaces [
	"Replace the existing registered DBs with the updated collection.
	This will resort the array in to that specified by the properties file."

	registeredDirectories := self properties registeredDatabaseDirectories.
	registeredDatabases := registeredDirectories
			collect: [ :fileReference | 
				(self dbFor: fileReference)
					ifExisting: [ :aDb :isPrimaryDB :isPlaygroundDB | 
						isPrimaryDB | isPlaygroundDB
							ifTrue: [ self addCommand: (LeLogicalDatabaseReloadUpdateShuffledDb new database: aDb) ]
							ifFalse: [ self addCommand: (LeLogicalDatabaseReloadUpdateExistingDb new database: aDb) ].
						aDb ]
					ifNew: [ :aDb | 
						self addCommand: (LeLogicalDatabaseReloadUpdateAddDb new database: aDb).
						aDb ] ]
			as: Array
]
