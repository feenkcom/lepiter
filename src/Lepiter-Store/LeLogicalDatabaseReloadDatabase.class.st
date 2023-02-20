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
	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> database: anObject [
	database := anObject
]

{ #category : #enumerating }
LeLogicalDatabaseReloadDatabase >> ifExisting: anExistingBlock ifNew: aNewBlock [
	^ self isExisting
		ifTrue: [ anExistingBlock cull: self database cull: isPrimaryDB cull: isPlaygroundDB ]
		ifFalse: [ aNewBlock cull: self database ]
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isExisting [
	^ isExisting
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isExisting: anObject [
	isExisting := anObject
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPlaygroundDB [
	^ isPlaygroundDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPlaygroundDB: anObject [
	isPlaygroundDB := anObject
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPrimaryDB [
	^ isPrimaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadDatabase >> isPrimaryDB: anObject [
	isPrimaryDB := anObject
]
