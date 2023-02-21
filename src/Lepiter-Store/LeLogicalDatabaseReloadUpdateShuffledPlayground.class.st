Class {
	#name : #LeLogicalDatabaseReloadUpdateShuffledPlayground,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'playgroundDB',
		'isAlsoPrimaryDB'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> addIn: aLogicalDatabase [
	aLogicalDatabase basicRemoveDB: self playgroundDB.
	aLogicalDatabase basicPlaygroundDB: self playgroundDB.
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> isAlsoPrimaryDB [
	^ isAlsoPrimaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> isAlsoPrimaryDB: anObject [
	isAlsoPrimaryDB := anObject
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> playgroundDB [
	^ playgroundDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> playgroundDB: anObject [
	playgroundDB := anObject
]

{ #category : #updating }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> reloadAndStartMonitoringIn: aLogicalDatabase [
	"Existing (reused) databases should be reloaded and monitoring started"

	self isAlsoPrimaryDB ifTrue: [ ^ self ].

	self playgroundDB monitor
		primitiveReload;
		startMonitoring
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self playgroundDB
]
