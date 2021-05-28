"
I am announced by ${class:LeDatabase}$, with the appropriate ${class:LeDatabase}$ and ${class:LePage}$, when the ${class:LePage}$ is removed from the ${class:LeDatabase}$.
"
Class {
	#name : #LeDatabasePageRemoved,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeDatabasePageRemoved >> page [
	^ page
]

{ #category : #accessing }
LeDatabasePageRemoved >> page: anObject [
	page := anObject
]
