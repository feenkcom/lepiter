Class {
	#name : #LeWordViewModelStateChangedAnnouncement,
	#superclass : #LeWordViewModelChangedAnnouncement,
	#instVars : [
		'word',
		'state'
	],
	#category : 'Lepiter-Snippet-Words-Announcements'
}

{ #category : #accessing }
LeWordViewModelStateChangedAnnouncement >> state [
	^ state
]

{ #category : #accessing }
LeWordViewModelStateChangedAnnouncement >> state: anObject [
	state := anObject
]

{ #category : #accessing }
LeWordViewModelStateChangedAnnouncement >> word [
	^ word
]

{ #category : #accessing }
LeWordViewModelStateChangedAnnouncement >> word: anObject [
	word := anObject
]
