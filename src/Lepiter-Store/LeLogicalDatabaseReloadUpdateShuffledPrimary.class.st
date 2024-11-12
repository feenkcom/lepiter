Class {
	#name : #LeLogicalDatabaseReloadUpdateShuffledPrimary,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'primaryDB'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadUpdateShuffledPrimary >> addIn: aLogicalDatabase [
	aLogicalDatabase basicRemoveDB: self primaryDB.
	aLogicalDatabase basicPrimaryDB: self primaryDB.
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPrimary >> primaryDB [
	^ primaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPrimary >> primaryDB: anObject [
	primaryDB := anObject
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledPrimary >> reloadAndStartMonitoringIn: aLogicalDatabase [
	"Existing (reused) databases should be reloaded and monitoring started"

	LeDatabaseIsReloadNecessaryChecker new
		database: self primaryDB;
		ifUpToDate: [
			self primaryDB monitor startMonitoring ] 
		ifOutOfDate: [
			self primaryDB monitor
				primitiveReloadWithErrorStrategy: self contentReloadErrorStrategy;
				startMonitoring ]
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateShuffledPrimary >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self primaryDB
]
