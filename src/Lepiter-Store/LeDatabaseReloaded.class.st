Class {
	#name : #LeDatabaseReloaded,
	#superclass : #Announcement,
	#instVars : [
		'database',
		'logicalDatabase'
	],
	#category : #'Lepiter-Store-Reload - Announcements'
}

{ #category : #accessing }
LeDatabaseReloaded >> database [

	^ database
]

{ #category : #accessing }
LeDatabaseReloaded >> database: aLogicalDatabase [

	database := aLogicalDatabase
]

{ #category : #accessing }
LeDatabaseReloaded >> logicalDatabase [
	^ logicalDatabase
]

{ #category : #accessing }
LeDatabaseReloaded >> logicalDatabase: anObject [
	logicalDatabase := anObject
]

{ #category : #printing }
LeDatabaseReloaded >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		print: self database;
		nextPut: $)
]
