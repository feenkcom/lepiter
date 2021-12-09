Class {
	#name : #LeWordViewModelChangedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'source'
	],
	#category : 'Lepiter-Snippet-Words-Announcements'
}

{ #category : #accessing }
LeWordViewModelChangedAnnouncement >> source [
	^ source
]

{ #category : #accessing }
LeWordViewModelChangedAnnouncement >> source: anObject [
	source := anObject
]
