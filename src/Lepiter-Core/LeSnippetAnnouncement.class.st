Class {
	#name : #LeSnippetAnnouncement,
	#superclass : #LeAnnouncement,
	#instVars : [
		'snippet'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeSnippetAnnouncement >> block [
	self 
		deprecated: 'Use #snippet instead.' 
		transformWith: '`@receiver block' -> '`@receiver snippet'.
	^ self snippet
]

{ #category : #accessing }
LeSnippetAnnouncement >> block: aSnippet [
	self 
		deprecated: 'Use #snippet: instead.' 
		transformWith: '`@receiver block: `@arg' -> '`@receiver snippet: `@arg'.
	^ self snippet: aSnippet.
]

{ #category : #accessing }
LeSnippetAnnouncement >> snippet [
	<return: #LeSnippet>
	^ snippet
]

{ #category : #accessing }
LeSnippetAnnouncement >> snippet: aSnippet [
	snippet := aSnippet
]
