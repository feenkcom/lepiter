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
	"The new playground database is already registered in the logical database.
	We therefore only move it from registered to playground place.
	In case the new playground database was previously primary, the effect is same: 
		The #basicRemoveDB: method will not remove anything, 
		and #basicPlaygroundDB: assigns the new playground database."

	aLogicalDatabase basicRemoveDB: self playgroundDB.
	aLogicalDatabase basicPlaygroundDB: self playgroundDB.
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> isAlsoPrimaryDB [
	"Return true if the playground database is same as the primary database, false otherwise"

	<return: #Boolean>
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

	LeDatabaseIsReloadNecessaryChecker new
		database: self playgroundDB;
		ifUpToDate: [
			self playgroundDB monitor startMonitoring ] 
		ifOutOfDate: [
			self playgroundDB monitor
				primitiveReloadWithErrorStrategy: self contentReloadErrorStrategy;
				startMonitoring ]
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateShuffledPlayground >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self playgroundDB
]
