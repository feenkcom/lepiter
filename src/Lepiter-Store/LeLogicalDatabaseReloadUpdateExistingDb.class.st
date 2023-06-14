Class {
	#name : #LeLogicalDatabaseReloadUpdateExistingDb,
	#superclass : #LeLogicalDatabaseReloadCommand,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingDb >> addIn: aLogicalDatabase [
	"do nothing"

	
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingDb >> database [
	^ database
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingDb >> database: anObject [
	database := anObject
]

{ #category : #updating }
LeLogicalDatabaseReloadUpdateExistingDb >> reloadAndStartMonitoringIn: aLogicalDatabase [
	"Existing (reused) databases should be reloaded and monitoring started"

	self database monitor
		primitiveReload;
		startMonitoring
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateExistingDb >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self database
]
