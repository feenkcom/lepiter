Class {
	#name : #LeGitHubModelAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'source',
		'model'
	],
	#category : 'Lepiter-GitHub-Announcements'
}

{ #category : #accessing }
LeGitHubModelAnnouncement >> model [
	^ model
]

{ #category : #accessing }
LeGitHubModelAnnouncement >> model: anObject [
	model := anObject
]

{ #category : #accessing }
LeGitHubModelAnnouncement >> source [
	^ source
]

{ #category : #accessing }
LeGitHubModelAnnouncement >> source: anObject [
	source := anObject
]
