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
	"do nothing"
]

{ #category : #accessing }
LeLogicalDatabaseReloadUpdateExistingPlayground >> isAlsoPrimaryDB [
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

	self playgroundDB monitor
		primitiveReload;
		startMonitoring
]

{ #category : #evaluating }
LeLogicalDatabaseReloadUpdateExistingPlayground >> toBeUsedDatabasesDo: aBlock [
	"Execute the command on all used databases"

	aBlock value: self playgroundDB
]
