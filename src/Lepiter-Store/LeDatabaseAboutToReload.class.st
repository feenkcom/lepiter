Class {
	#name : #LeDatabaseAboutToReload,
	#superclass : #Announcement,
	#instVars : [
		'database',
		'logicalDatabase'
	],
	#category : #'Lepiter-Store-Reload - Announcements'
}

{ #category : #accessing }
LeDatabaseAboutToReload >> database [

	^ database
]

{ #category : #accessing }
LeDatabaseAboutToReload >> database: aLogicalDatabase [

	database := aLogicalDatabase
]

{ #category : #accessing }
LeDatabaseAboutToReload >> logicalDatabase [
	^ logicalDatabase
]

{ #category : #accessing }
LeDatabaseAboutToReload >> logicalDatabase: anObject [
	logicalDatabase := anObject
]

{ #category : #printing }
LeDatabaseAboutToReload >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		print: self database;
		nextPut: $)
]
