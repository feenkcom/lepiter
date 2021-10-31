"
I am announced by {{gtClass:LeDatabase}}, with the appropriate {{gtClass:LeDatabase}} and {{gtClass:LePage}}, when the {{gtClass:LePage}} is removed from the {{gtClass:LeDatabase}}.

"
Class {
	#name : #LeDatabasePageRemoved,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'page'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeDatabasePageRemoved >> page [
	^ page
]

{ #category : #accessing }
LeDatabasePageRemoved >> page: anObject [
	page := anObject
]
