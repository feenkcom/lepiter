Class {
	#name : #LeBasicDatabasesRegistry,
	#superclass : #LeModel,
	#instVars : [
		'defaultLogicalDatabase'
	],
	#category : #'Lepiter-Core-Registry'
}

{ #category : #'startup-shutdown' }
LeBasicDatabasesRegistry >> clearDefaultLogicalDatabase [

	self stopMonitoring.
	^ defaultLogicalDatabase := nil
]

{ #category : #accessing }
LeBasicDatabasesRegistry >> currentLoadedDefaultLogicalDatabase [

	^ defaultLogicalDatabase 
]

{ #category : #accessing }
LeBasicDatabasesRegistry >> defaultLogicalDatabase [

	^ defaultLogicalDatabase
]

{ #category : #accessing }
LeBasicDatabasesRegistry >> defaultLogicalDatabase: anObject [
	defaultLogicalDatabase := anObject
]

{ #category : #accessing }
LeBasicDatabasesRegistry >> defaultPlaygroundDatabase [

	^ self defaultLogicalDatabase playgroundDB
]

{ #category : #accessing }
LeBasicDatabasesRegistry >> defaultPrimaryDatabase [

	^ self defaultLogicalDatabase primaryDB
]

{ #category : #'gt - extensions' }
LeBasicDatabasesRegistry >> gtDatabasesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Databases';
		priority: 1;
		items: [ self defaultLogicalDatabase databases ]
]

{ #category : #testing }
LeBasicDatabasesRegistry >> hasDatabasesLoaded [
	^ defaultLogicalDatabase notNil
]

{ #category : #'startup-shutdown' }
LeBasicDatabasesRegistry >> stopMonitoring [

	defaultLogicalDatabase ifNotNil: 
		[ defaultLogicalDatabase stopMonitoring ]
]
