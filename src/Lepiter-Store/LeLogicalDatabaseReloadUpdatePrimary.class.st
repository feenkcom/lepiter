Class {
	#name : #LeLogicalDatabaseReloadUpdatePrimary,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'primaryDB'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadUpdatePrimary >> addIn: aLogicalDatabase [
	aLogicalDatabase primaryDB: self primaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdatePrimary >> primaryDB [
	^ primaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdatePrimary >> primaryDB: anObject [
	primaryDB := anObject
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdatePrimary >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self primaryDB
]
