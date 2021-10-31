Class {
	#name : #LePageDatabaseChanged,
	#superclass : #LePageAnnouncement,
	#instVars : [
		'previousDatabase',
		'currentDatabase'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LePageDatabaseChanged >> currentDatabase [
	^ currentDatabase
]

{ #category : #accessing }
LePageDatabaseChanged >> currentDatabase: anObject [
	currentDatabase := anObject
]

{ #category : #accessing }
LePageDatabaseChanged >> previousDatabase [
	^ previousDatabase
]

{ #category : #accessing }
LePageDatabaseChanged >> previousDatabase: anObject [
	previousDatabase := anObject
]
