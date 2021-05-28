"
I am an abstract class.
I am a ${class:LeDatabase}$ announcement.
See my ${class:LeDatabaseAnnouncement|expanded|show=#gtSubclassesFor:}$ for concrete announcements:
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
