Class {
	#name : #LeLogicalDatabaseReloadUpdateExistingPrimary,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'primaryDB'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadUpdateExistingPrimary >> addIn: aLogicalDatabase [
	"do nothing - the playground database is not changed"

	
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPrimary >> primaryDB [
	^ primaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPrimary >> primaryDB: anObject [
	primaryDB := anObject
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPrimary >> reloadAndStartMonitoringIn: aLogicalDatabase [
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
LeLogicalDatabaseReloadUpdateExistingPrimary >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self primaryDB
]
