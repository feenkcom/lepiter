"
I am sent by a {{gtClass:LePage}} after it is removed from the system. 

When pages are moved between databasess this announcement is not triggered, as the page is not removed just moved. I differ from {{gtClass:LeDatabasePageRemoved}} that indicated a page was removed from a database, and it is triggered by the database when pages are moved.

"
Class {
	#name : #LePageRemovedFromDatabase,
	#superclass : #LePageAnnouncement,
	#instVars : [
		'database'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LePageRemovedFromDatabase >> database [
	^ database
]

{ #category : #accessing }
LePageRemovedFromDatabase >> database: anObject [
	database := anObject
]
