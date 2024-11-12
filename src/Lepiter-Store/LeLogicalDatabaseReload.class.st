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
		'updateCommands',
		'contentReloadErrorStrategy'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #private }
LeLogicalDatabaseReload >> addCommand: aCommand [
	aCommand contentReloadErrorStrategy: contentReloadErrorStrategy.
	updateCommands add: aCommand
]

{ #category : #accessing }
LeLogicalDatabaseReload >> contentReloadErrorStrategy: aContentReloadErrorStrategy [
	self assert: [ aContentReloadErrorStrategy notNil ].
	
	contentReloadErrorStrategy := aContentReloadErrorStrategy
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
LeLogicalDatabaseReload >> dbFor: dbZnUrl [
	"Answer the concrete database for the supplied file reference.
	If it is an existing DB, use that instance.  If it is a new DB, load it.
	Notice, that new DBs are instantiated with running monitor."
	<return: #LeLogicalDatabaseReloadDatabase>
	| newDb |

	existingDbs
		detect: [ :db | db storeLocation lepiterDbUrlEquals: dbZnUrl ]
		ifFound: [ :db | 
			^ LeLogicalDatabaseReloadDatabase new
				database: db;
				isPrimaryDB: (database primaryDB == db);
				isPlaygroundDB: (database playgroundDB = db);
				isExisting: true ].

	newDb := (LeDatabaseStore loaderFor: dbZnUrl) current 
		loadAndMonitorFrom: dbZnUrl.
	^ LeLogicalDatabaseReloadDatabase new
		database: newDb;
		isPrimaryDB: false;
		isPlaygroundDB: false;
		isExisting: false
]

{ #category : #initialialize }
LeLogicalDatabaseReload >> defaultContentReloadErrorStrategy [
	^ LeDatabaseContentReloadErrorStrategy forkDebuggerOnErrorStrategy
]

{ #category : #private }
LeLogicalDatabaseReload >> executeUpdateCommands [
	"Steps:
	1. remove unused databases
	2. reload and start monitoring of reused databases 
		(new databases are already reloaded with running monitors)
	3. add new databases (or shuffle reused databases)"

	updateCommands do: [ :each | each removeIn: database ].
	updateCommands do: [ :each | each reloadAndStartMonitoringIn: database ].
	updateCommands do: [ :each | each addIn: database ]
]

{ #category : #initialialize }
LeLogicalDatabaseReload >> initialize [
	self contentReloadErrorStrategy: self defaultContentReloadErrorStrategy
]

{ #category : #accessing }
LeLogicalDatabaseReload >> properties [ 

	^ database properties
]

{ #category : #actions }
LeLogicalDatabaseReload >> reload [ 
	"Reload the receiver's database.
	This may involve adding, moving or removing concrete databases.
	The reload is done in four phases:
	1. Stop monitoring all DBs:
		- to provide visual feedback to users that something is happening.
		- to make sure that users will not change anything while reloading.
	2. Reload properties
	3. Prepare commands to shuffle and load databases based on the properties file.
	4. Prepare commands to unload the unused databases.
		This notifies the UI that any windows related to the DB should be closed.
	5. Execute commands + reload and start monitoring"

	existingDbs := Set new.
	updateCommands := OrderedCollection new.
	database announce: (LeLogicalDatabaseAboutToReload new 
		database: self database).
	
	[
	"1. Stop monitoring all DBs"
	database databasesDo: [ :db |
		LeDatabaseIsReloadNecessaryChecker new
			database: db;
			ifUpToDate: [ :aReason |
				db reloadReason: aReason.
				db stopMonitoring. ] 
			ifOutOfDate: [ :aReason |
				db reloadReason: aReason.
				db announce: (LeDatabaseAboutToReload new 
					logicalDatabase: self database;
					database: db) ].
				db stopMonitoring.
				existingDbs add: db ].
		
	"2. Reload properties
	Ensure that reloading relies on new mappings from code"
	LeJsonV4 cleanUp.
	self reloadProperties.

	"3. Prepare commands to shuffle and load databases"
	self updatePrimaryAndPlaygroundDatabases.
	self updateRegisteredDatabasesAndSpaces.

	"4. Prepare commands to unload unused databases"
	self unloadUnusedDatabases.
	
	"5. Execute commands + reload and start monitoring"
	self executeUpdateCommands.
	
	] ensure: [ 
	"6. Clear cached reload reasons"
		existingDbs do: [ :db | 
			db clearReloadReason ]
	].
	
	database announce: (LeLogicalDatabaseReloaded new 
		database: self database).
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
	"The primary and playground databases should be re-created if they don't exist
	(allowing the Lepiter App to be started on a new machine)."

	| existingPrimaryUrl existingPlaygroundUrl primaryCommand playgroundCommand |
	
	"1. Read primary and playground directories from properties"
	primaryDirectory := self properties primaryDatabaseUrl asZnUrl.
	playgroundDirectory := self properties playgroundDatabaseUrl asZnUrl.
	existingPrimaryUrl := database primaryDB storeLocation.
	existingPlaygroundUrl := database playgroundDB storeLocation.

	"2. Prepare command for primary database"
	"primaryDirectory ensureCreateDirectory."
	(primaryDirectory lepiterDbUrlEquals: existingPrimaryUrl)
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
				
	"3. Prepare command for playground database"
	"playgroundDirectory ensureCreateDirectory."
	(playgroundDirectory lepiterDbUrlEquals: existingPlaygroundUrl)
		ifTrue: [ (self dbFor: playgroundDirectory)
				ifExisting: [ :aDb | 
					playgroundCommand := LeLogicalDatabaseReloadUpdateExistingPlayground new
							playgroundDB: aDb;
							isAlsoPrimaryDB: primaryCommand primaryDB = aDb ]
				ifNew: [ :aDb | self shouldNotImplement ] ]
		ifFalse: [ (self dbFor: playgroundDirectory)
				ifExisting: [ :aDb | 
					playgroundCommand := LeLogicalDatabaseReloadUpdateShuffledPlayground new
							playgroundDB: aDb;
							isAlsoPrimaryDB: primaryCommand primaryDB = aDb ]
				ifNew: [ :aDb | 
					playgroundCommand := LeLogicalDatabaseReloadUpdatePlayground new
							playgroundDB: aDb ] ].

	"4. Add commnads to a queue"
	self addCommand: primaryCommand.
	self addCommand: playgroundCommand
]

{ #category : #private }
LeLogicalDatabaseReload >> updateRegisteredDatabasesAndSpaces [
	"Replace the existing registered DBs with the updated collection.
	This will resort the array in to that specified by the properties file."

	registeredDirectories := self properties registeredDatabaseUrls.
	registeredDatabases := registeredDirectories
			collect: [ :znUrl | 
				(self dbFor: znUrl)
					ifExisting: [ :aDb :isPrimaryDB :isPlaygroundDB | 
						isPrimaryDB | isPlaygroundDB
							ifTrue: [ self addCommand: (LeLogicalDatabaseReloadUpdateShuffledDb new 
								database: aDb) ]
							ifFalse: [ self addCommand: (LeLogicalDatabaseReloadUpdateExistingDb new 
								database: aDb) ].
						aDb ]
					ifNew: [ :aDb | 
						self addCommand: (LeLogicalDatabaseReloadUpdateAddDb new 
							database: aDb).
						aDb ] ]
			as: Array
]
