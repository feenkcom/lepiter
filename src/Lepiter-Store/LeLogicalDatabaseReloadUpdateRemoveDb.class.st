Class {
	#name : #LeLogicalDatabaseReloadUpdateRemoveDb,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadUpdateRemoveDb >> addIn: aLogicalDatabase [
	"do nothing"
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateRemoveDb >> database [
	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateRemoveDb >> database: anObject [
	database := anObject
]

{ #category : #updating }
LeLogicalDatabaseReloadUpdateRemoveDb >> removeIn: aLogicalDatabase [
	aLogicalDatabase removeDB: self database
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateRemoveDb >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self database
]
