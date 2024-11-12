Class {
	#name : #LeLogicalDatabaseReloadUpdateShuffledDb,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadUpdateShuffledDb >> addIn: aLogicalDatabase [
	"Primary or Playground DBs are already replaced by another command. Just add it as a registered DB."

	aLogicalDatabase basicAddDB: self database
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledDb >> database [
	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateShuffledDb >> database: anObject [
	database := anObject
]

{ #category : #updating }
LeLogicalDatabaseReloadUpdateShuffledDb >> reloadAndStartMonitoringIn: aLogicalDatabase [
	"Existing (reused) databases should be reloaded and monitoring started"

	LeDatabaseIsReloadNecessaryChecker new
		database: self database;
		ifUpToDate: [
			self database monitor startMonitoring ] 
		ifOutOfDate: [
			self database monitor
				primitiveReloadWithErrorStrategy: self contentReloadErrorStrategy;
				startMonitoring ]
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateShuffledDb >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self database
]
