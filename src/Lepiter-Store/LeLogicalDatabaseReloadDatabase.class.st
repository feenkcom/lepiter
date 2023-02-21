"
I {{gtMethod: LeLogicalDatabaseReloadDatabase >> #database | label=hold}} an existing or new {{gtClass: LeDatabase | label=database}}. 
An existing database is a database that is already registered by a {{gtClass: LeLogicalDatabase}} instance.
A new database is a database that is about to be registered in a {{gtClass: LeLogicalDatabase}} instance.
I {{gtMethod: LeLogicalDatabaseReloadDatabase >> #isExisting | label=indicate }} whether is it a new or existing database.
I am used by {{gtClass: LeLogicalDatabaseReloadDatabase}}. 

"
Class {
	#name : #LeLogicalDatabaseReloadDatabase,
	#superclass : #Object,
	#instVars : [
		'database',
		'isExisting',
		'isPrimaryDB',
		'isPlaygroundDB'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> database [
	<return: #LeDatabase>
	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> database: aDatabase [
	database := aDatabase
]

{ #category : #enumerating }
LeLogicalDatabaseReloadDatabase >> ifExisting: anExistingBlock ifNew: aNewBlock [
	"Execute one or another block depending on #isExisting state.
	Notice that `isPrimaryDB` and `isPlaygroundDB` reflects 
	the existing (before reload) logical database state, not the future state."

	^ self isExisting
		ifTrue: [ anExistingBlock cull: self database cull: isPrimaryDB cull: isPlaygroundDB ]
		ifFalse: [ aNewBlock cull: self database ]
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isExisting [
	"Return true if the database is already used by a logical database, false otherwise."

	<return: #Boolean>
	^ isExisting
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isExisting: aBoolean [
	isExisting := aBoolean
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPlaygroundDB [
	"Return true if the database is an existing playground database of a logical database, false otherwise."

	<return: #Boolean>
	^ isPlaygroundDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPlaygroundDB: aBoolean [
	isPlaygroundDB := aBoolean
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPrimaryDB [
	"Return true if the database is an existing primary database of a logical database, false otherwise."

	<return: #Boolean>
	^ isPrimaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPrimaryDB: aBoolean [
	isPrimaryDB := aBoolean
]
