Class {
	#name : #LeLogicalDatabaseReloadUpdatePlayground,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'playgroundDB'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #accessing }
LeLogicalDatabaseReloadUpdatePlayground >> addIn: aLogicalDatabase [
	"Newly created databases are already reloaded and with running monitor.
	We (just) register the new playground database."

	aLogicalDatabase playgroundDB: self playgroundDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdatePlayground >> playgroundDB [
	^ playgroundDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdatePlayground >> playgroundDB: anObject [
	playgroundDB := anObject
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdatePlayground >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self playgroundDB
]
