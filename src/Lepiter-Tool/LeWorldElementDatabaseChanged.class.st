"
Announce that the world element's database has been replaced


"
Class {
	#name : #LeWorldElementDatabaseChanged,
	#superclass : #Announcement,
	#instVars : [
		'database',
		'source'
	],
	#category : #'Lepiter-Tool-Announcements'
}

{ #category : #accessing }
LeWorldElementDatabaseChanged >> database [
	^ database
]

{ #category : #accessing }
LeWorldElementDatabaseChanged >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeWorldElementDatabaseChanged >> source [
	^ source
]

{ #category : #accessing }
LeWorldElementDatabaseChanged >> source: anObject [
	source := anObject
]
