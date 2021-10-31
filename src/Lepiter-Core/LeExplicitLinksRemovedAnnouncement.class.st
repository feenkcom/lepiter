Class {
	#name : #LeExplicitLinksRemovedAnnouncement,
	#superclass : #LeExplicitLinksChange,
	#instVars : [
		'removedExplicitLinks'
	],
	#category : 'Lepiter-Core-Links'
}

{ #category : #accessing }
LeExplicitLinksRemovedAnnouncement >> removedExplicitLinks [
	^ removedExplicitLinks
]

{ #category : #accessing }
LeExplicitLinksRemovedAnnouncement >> removedExplicitLinks: aCollectionOfLeExplicitLinks [
	self assert: [ aCollectionOfLeExplicitLinks notNil ].
	removedExplicitLinks := aCollectionOfLeExplicitLinks
]

{ #category : #testing }
LeExplicitLinksRemovedAnnouncement >> requiresSavingOfLinks [
	^ self removedExplicitLinks notNil and: [
		self removedExplicitLinks anySatisfy: #isAttachedLink ]
]
