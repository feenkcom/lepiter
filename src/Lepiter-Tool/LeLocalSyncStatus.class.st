Class {
	#name : #LeLocalSyncStatus,
	#superclass : #Object,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Tool-Monitoring'
}

{ #category : #'instance creation' }
LeLocalSyncStatus class >> forDatabase: aDatabase [
	^ self new
		database: aDatabase
	
]

{ #category : #accessing }
LeLocalSyncStatus >> database [
	^ database
]

{ #category : #accessing }
LeLocalSyncStatus >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #accessing }
LeLocalSyncStatus >> formattedShortName [
	^ self shortName asRopedText 
		foreground: self statusColor
]

{ #category : #testing }
LeLocalSyncStatus >> hasPendingChanges [
	^ false
]

{ #category : #testing }
LeLocalSyncStatus >> isErrorStatus [
	^ false
]

{ #category : #testing }
LeLocalSyncStatus >> isRunningCleanly [
	^ self isErrorStatus not
]

{ #category : #printing }
LeLocalSyncStatus >> printOn: aStream [
	super printOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self shortName;
		nextPutAll: ')'
]

{ #category : #accessing }
LeLocalSyncStatus >> shortName [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeLocalSyncStatus >> statusColor [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeLocalSyncStatus >> statusIcon [
	^ self subclassResponsibility
]
