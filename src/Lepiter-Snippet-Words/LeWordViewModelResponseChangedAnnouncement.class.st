Class {
	#name : #LeWordViewModelResponseChangedAnnouncement,
	#superclass : #LeWordViewModelChangedAnnouncement,
	#instVars : [
		'word',
		'response'
	],
	#category : 'Lepiter-Snippet-Words-Announcements'
}

{ #category : #accessing }
LeWordViewModelResponseChangedAnnouncement >> response [
	^ response
]

{ #category : #accessing }
LeWordViewModelResponseChangedAnnouncement >> response: anObject [
	response := anObject
]

{ #category : #accessing }
LeWordViewModelResponseChangedAnnouncement >> word [
	^ word
]

{ #category : #accessing }
LeWordViewModelResponseChangedAnnouncement >> word: anObject [
	word := anObject
]
