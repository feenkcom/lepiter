Class {
	#name : #LeLogicalDatabaseReloadUpdateAddDb,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateAddDb >> addIn: aLogicalDatabase [
	aLogicalDatabase addDB: self database
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateAddDb >> database [
	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateAddDb >> database: anObject [
	database := anObject
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateAddDb >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self database
]
