Class {
	#name : #LeUIPageSelectionRequest,
	#superclass : #LeUIAnnouncement,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-UI-Basic - Announcements'
}

{ #category : #accessing }
LeUIPageSelectionRequest >> page [
	^ page
]

{ #category : #accessing }
LeUIPageSelectionRequest >> page: anObject [
	page := anObject
]
