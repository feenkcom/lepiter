Class {
	#name : #LeLogicalDatabaseReload,
	#superclass : #Object,
	#instVars : [
		'database',
		'existingDbs',
		'primaryDirectory',
		'playgroundDirectory',
		'registeredDirectories',
		'registeredDatabases'
	],
	#category : #'Lepiter-Store-Reload'
}

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

	existingDbs detect: [ :db | db localStoreRootDirectory = aFileReference ]
		ifFound: [ :db | ^ db ].

	^ LeLocalStoreLoad current loadAndMonitorFrom: aFileReference.
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

	self reloadProperties.
	existingDbs := Set new.
	"1. Stop monitoring all DBs"
	database databasesDo: [ :db | 
		db stopMonitoring.
		existingDbs add: db ].

	"2. Shuffle and load the databases"
	primaryDirectory := self properties primaryDatabaseDirectory.
	playgroundDirectory := self properties playgroundDatabaseDirectory.
	registeredDirectories := self properties registeredDatabaseDirectories.
	"The primary and playground databases should be re-created if they don't exist
	(allowing the Lepiter App to be started on a new machine."
	primaryDirectory ensureCreateDirectory.
	primaryDirectory = database primaryDB localStoreRootDirectory 
		ifFalse: [ database primaryDB: (self dbFor: primaryDirectory) ].

	playgroundDirectory ensureCreateDirectory.
	playgroundDirectory = database playgroundDB localStoreRootDirectory
		ifFalse: [ database playgroundDB: (self dbFor: playgroundDirectory) ].

	self updateRegisteredDatabases.

	"3. Unload the unused databases"
	self unloadUnusedDatabases.

	"4. Reload and start monitoring"
	database databasesDo: [ :db | 
		db monitor
			primitiveReload;
			startMonitoring ].
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
	propertiesFile = LepiterCoreDefaults logicalDatabasePropertiesFileReference ifTrue:
		[ LeJsonV4LogicalPropertiesUpdater updateDefault ].

	propertiesFile exists not ifTrue: 
		[ database properties: LeLogicalDatabaseProperties default.
		^ self ].

	database properties: (LeLogicalDatabaseProperties new localFile: propertiesFile)
]

{ #category : #private }
LeLogicalDatabaseReload >> unloadUnusedDatabases [
	"Unload any unused databases"
	| currentDatabases toBeRemoved |

	currentDatabases := Set with: database primaryDB with: database playgroundDB.
	currentDatabases addAll: registeredDatabases.

	toBeRemoved := (existingDbs asSet difference: currentDatabases) 
 		intersection: database registeredDBs asSet.
	toBeRemoved do: [ :db | database removeDB: db ].

	"Update the logical database's list of registered databases so the order is correct"
	database registeredDBs: registeredDatabases.
]

{ #category : #private }
LeLogicalDatabaseReload >> updateRegisteredDatabases [
	"Replace the existing registered DBs with the updated collection.
	This will resort the array in to that specified by the properties file."

	registeredDatabases := registeredDirectories collect: [ :fileReference |
		self dbFor: fileReference ] as: Array.

]
