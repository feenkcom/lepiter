Class {
	#name : #LeIncomingPageLinksGroupedByOrigin,
	#superclass : #LeIncomingPageLinksGroup,
	#instVars : [
		'origin'
	],
	#category : 'Lepiter-Core-IncomingReferences'
}

{ #category : #adding }
LeIncomingPageLinksGroupedByOrigin >> addIncomingPageLink: anIncomingPageLink [
	links add: anIncomingPageLink
]

{ #category : #testing }
LeIncomingPageLinksGroupedByOrigin >> isGroupedByPage [
	^ false
]

{ #category : #accessing }
LeIncomingPageLinksGroupedByOrigin >> origin [
	<return: #Object>

	^ origin
]

{ #category : #accessing }
LeIncomingPageLinksGroupedByOrigin >> origin: anObject [
	origin := anObject
]
