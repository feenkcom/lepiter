Class {
	#name : #LeLogicalDatabaseReloadUpdateExistingPlayground,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'playgroundDB',
		'isAlsoPrimaryDB'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #updating }
LeLogicalDatabaseReloadUpdateExistingPlayground >> addIn: aLogicalDatabase [
	"do nothing - playground database is not changed"

	
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPlayground >> isAlsoPrimaryDB [
	"Return true if the playground database is same as the primary database, false otherwise"

	<return: #Boolean>
	^ isAlsoPrimaryDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPlayground >> isAlsoPrimaryDB: anObject [
	isAlsoPrimaryDB := anObject
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPlayground >> playgroundDB [
	^ playgroundDB
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPlayground >> playgroundDB: anObject [
	playgroundDB := anObject
]

{ #category : #updating }
LeLogicalDatabaseReloadUpdateExistingPlayground >> reloadAndStartMonitoringIn: aLogicalDatabase [
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
LeLogicalDatabaseReloadUpdateExistingPlayground >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self playgroundDB
]
