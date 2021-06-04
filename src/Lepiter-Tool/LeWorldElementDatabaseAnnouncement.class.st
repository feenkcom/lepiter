Class {
	#name : #LeWorldElementDatabaseAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'database',
		'source'
	],
	#category : #'Lepiter-Tool-Announcements'
}

{ #category : #accessing }
LeWorldElementDatabaseAnnouncement >> database [
	^ database
]

{ #category : #accessing }
LeWorldElementDatabaseAnnouncement >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeWorldElementDatabaseAnnouncement >> source [
	^ source
]

{ #category : #accessing }
LeWorldElementDatabaseAnnouncement >> source: anObject [
	source := anObject
]
