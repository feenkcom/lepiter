Class {
	#name : #LeExplicitLinkAddedAnnouncement,
	#superclass : #LeExplicitLinksChange,
	#instVars : [
		'newExplicitLink'
	],
	#category : 'Lepiter-Core-Links'
}

{ #category : #accessing }
LeExplicitLinkAddedAnnouncement >> newExplicitLink [
	^ newExplicitLink
]

{ #category : #accessing }
LeExplicitLinkAddedAnnouncement >> newExplicitLink: anExplicitLink [
	self assert: [ anExplicitLink notNil ].
	newExplicitLink := anExplicitLink
]

{ #category : #testing }
LeExplicitLinkAddedAnnouncement >> requiresSavingOfLinks [
	^ self newExplicitLink notNil and: [
		self newExplicitLink isAttachedLink ]
]
