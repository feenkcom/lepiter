Class {
	#name : #LeWordSnippetExplanationChangedAnnouncement,
	#superclass : #LeWordSnippetChangedAnnouncement,
	#instVars : [
		'explanation'
	],
	#category : 'Lepiter-Snippet-Words-Announcements'
}

{ #category : #accessing }
LeWordSnippetExplanationChangedAnnouncement >> explanation [
	^ explanation
]

{ #category : #accessing }
LeWordSnippetExplanationChangedAnnouncement >> explanation: anObject [
	explanation := anObject
]
