Class {
	#name : #LeDatabasesRegistry,
	#superclass : #LeBasicDatabasesRegistry,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Core-Registry'
}

{ #category : #accessing }
LeDatabasesRegistry class >> defaultLogicalDatabase [

	^ self uniqueInstance defaultLogicalDatabase
]

{ #category : #accessing }
LeDatabasesRegistry class >> defaultPlaygroundDatabase [

	^ self uniqueInstance defaultPlaygroundDatabase
]

{ #category : #accessing }
LeDatabasesRegistry class >> defaultPrimaryDatabase [

	^ self uniqueInstance defaultPrimaryDatabase
]

{ #category : #'private - hooks' }
LeDatabasesRegistry class >> onRemoveUniqueInstance: anInstance [
	"Stop any open databases before removing the instance"

	uniqueInstance stopMonitoring
]

{ #category : #accessing }
LeDatabasesRegistry >> defaultLogicalDatabase [

	^ defaultLogicalDatabase ifNil: [ defaultLogicalDatabase := self loadDefaultLogicalDatabase ]
]

{ #category : #private }
LeDatabasesRegistry >> ensureDatabase [
	"Ensure there is a database configured. If a database already is set do nothing.
	In case there is no database configure one for GT."
	
	defaultLogicalDatabase ifNotNil: [ ^ defaultLogicalDatabase ].
	^ self setupForGlamorousToolkit
]

{ #category : #private }
LeDatabasesRegistry >> initializeForGlamorousToolkit [
	| databaseProperties |
	self assert: [ defaultLogicalDatabase isNil ].
	
	databaseProperties := LeLogicalDatabaseProperties defaultForGlamorousToolkit.
	self defaultLogicalDatabase: databaseProperties logicalDatabase
	
]

{ #category : #private }
LeDatabasesRegistry >> setupForGlamorousToolkit [
	self initializeForGlamorousToolkit.
	^ self currentLoadedDefaultLogicalDatabase 
]
