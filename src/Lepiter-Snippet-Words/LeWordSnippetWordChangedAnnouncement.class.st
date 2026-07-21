Class {
	#name : #LeWordSnippetWordChangedAnnouncement,
	#superclass : #LeWordSnippetChangedAnnouncement,
	#instVars : [
		'word'
	],
	#category : 'Lepiter-Snippet-Words-Announcements'
}

{ #category : #accessing }
LeWordSnippetWordChangedAnnouncement >> word [
	^ word
]

{ #category : #accessing }
LeWordSnippetWordChangedAnnouncement >> word: anObject [
	word := anObject
]
