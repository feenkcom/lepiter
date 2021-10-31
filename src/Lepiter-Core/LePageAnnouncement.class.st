Class {
	#name : #LePageAnnouncement,
	#superclass : #LeAnnouncement,
	#instVars : [
		'page'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #'api - accessing' }
LePageAnnouncement >> page [
	^ page
]

{ #category : #'api - accessing' }
LePageAnnouncement >> page: anObject [
	page := anObject
]
