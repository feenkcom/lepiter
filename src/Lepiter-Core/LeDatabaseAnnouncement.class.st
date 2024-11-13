"
I am an abstract class.
I am a {{gtClass:LeDatabase}} announcement.
See my {{gtClass:LeDatabaseAnnouncement|expanded|show=#gtSubclassesFor:}} for concrete announcements:

"
Class {
	#name : #LeDatabaseAnnouncement,
	#superclass : #LeAnnouncement,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #'api - accessing' }
LeDatabaseAnnouncement >> database [
	^ database
]

{ #category : #'api - accessing' }
LeDatabaseAnnouncement >> database: anObject [
	database := anObject
]

{ #category : #printing }
LeDatabaseAnnouncement >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		print: self database;
		nextPut: $)
]
