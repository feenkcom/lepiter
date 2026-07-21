Class {
	#name : #LeWordViewModelWordChangedAnnouncement,
	#superclass : #LeWordViewModelChangedAnnouncement,
	#instVars : [
		'word'
	],
	#category : 'Lepiter-Snippet-Words-Announcements'
}

{ #category : #accessing }
LeWordViewModelWordChangedAnnouncement >> word [
	^ word
]

{ #category : #accessing }
LeWordViewModelWordChangedAnnouncement >> word: anObject [
	word := anObject
]
