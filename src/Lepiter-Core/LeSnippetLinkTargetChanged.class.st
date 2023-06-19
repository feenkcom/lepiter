Class {
	#name : #LeSnippetLinkTargetChanged,
	#superclass : #LeSnippetAnnouncement,
	#instVars : [
		'link',
		'target'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeSnippetLinkTargetChanged >> link [
	<return: #LeTextualLink>
	^ link
]

{ #category : #accessing }
LeSnippetLinkTargetChanged >> link: anObject [
	link := anObject
]

{ #category : #accessing }
LeSnippetLinkTargetChanged >> target [
	<return: #LeContent>
	^ target
]

{ #category : #accessing }
LeSnippetLinkTargetChanged >> target: anObject [
	target := anObject
]
