Class {
	#name : #LeDatabasesRegistry,
	#superclass : #LeModel,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'defaultLogicalDatabase'
	],
	#category : #'Lepiter-Core-Model'
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
LeDatabasesRegistry >> clearDefaultLogicalDatabase [

	self stopMonitoring.
	^ defaultLogicalDatabase := nil
]

{ #category : #accessing }
LeDatabasesRegistry >> currentLoadedDefaultLogicalDatabase [

	^ defaultLogicalDatabase 
]

{ #category : #accessing }
LeDatabasesRegistry >> defaultLogicalDatabase [

	^ defaultLogicalDatabase ifNil: [ defaultLogicalDatabase := self loadDefaultLogicalDatabase ]
]

{ #category : #accessing }
LeDatabasesRegistry >> defaultLogicalDatabase: anObject [
	defaultLogicalDatabase := anObject
]

{ #category : #accessing }
LeDatabasesRegistry >> defaultPlaygroundDatabase [

	^ self defaultLogicalDatabase playgroundDB
]

{ #category : #accessing }
LeDatabasesRegistry >> defaultPrimaryDatabase [

	^ self defaultLogicalDatabase primaryDB
]

{ #category : #private }
LeDatabasesRegistry >> ensureDatabase [
	"Ensure there is a database configured. If a database already is set do nothing.
	In case there is no database configure one for GT."
	
	defaultLogicalDatabase ifNotNil: [ ^ self ].
	self setupForGlamorousToolkit
]

{ #category : #accessing }
LeDatabasesRegistry >> gtDatabasesFor: aView [
	<gtView>
	^ aView list
		title: 'Databases';
		priority: 1;
		items: [ self defaultLogicalDatabase databases ]
]

{ #category : #testing }
LeDatabasesRegistry >> hasDatabasesLoaded [
	^ defaultLogicalDatabase notNil
]

{ #category : #private }
LeDatabasesRegistry >> initializeForGlamorousToolkit [
	| databaseProperties |
	self assert: [ defaultLogicalDatabase isNil ].
	databaseProperties := LeLogicalDatabaseProperties defaultForGlamorousToolkit.
	self defaultLogicalDatabase: databaseProperties logicalDatabase
	
]

{ #category : #private }
LeDatabasesRegistry >> loadDefaultLogicalDatabase [

	^ LeLogicalDatabaseProperties default logicalDatabase
]

{ #category : #private }
LeDatabasesRegistry >> setupForGlamorousToolkit [
	self initializeForGlamorousToolkit.
	^ self currentLoadedDefaultLogicalDatabase 
]

{ #category : #'startup-shutdown' }
LeDatabasesRegistry >> stopMonitoring [

	defaultLogicalDatabase ifNotNil: 
		[ defaultLogicalDatabase stopMonitoring ]
]
