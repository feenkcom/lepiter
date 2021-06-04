"
I am announced by ${class:LeDatabase}$, with the appropriate ${class:LeDatabase}$ and ${class:LePage}$, when a ${class:LePage}$ is added to the ${class:LeDatabase}$.
"
Class {
	#name : #LeDatabasePageAdded,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #'api - accessing' }
LeDatabasePageAdded >> page [
	^ page
]

{ #category : #'api - accessing' }
LeDatabasePageAdded >> page: anObject [
	page := anObject
]
