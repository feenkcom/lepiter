"
I am announced by {{gtClass:LeDatabase}}, with the appropriate {{gtClass:LeDatabase}} and {{gtClass:LePage}}, when a {{gtClass:LePage}} is added to the {{gtClass:LeDatabase}}.

"
Class {
	#name : #LeDatabasePageAdded,
	#superclass : #LeDatabaseAnnouncement,
	#instVars : [
		'page'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #'api - accessing' }
LeDatabasePageAdded >> page [
	^ page
]

{ #category : #'api - accessing' }
LeDatabasePageAdded >> page: anObject [
	page := anObject
]
