Class {
	#name : #LeContentMatchingLinkFilter,
	#superclass : #LeFilter,
	#instVars : [
		'linkFilter'
	],
	#category : 'Lepiter-Core-Database - Filters Links'
}

{ #category : #accessing }
LeContentMatchingLinkFilter >> linkFilter [
	^ linkFilter
]

{ #category : #accessing }
LeContentMatchingLinkFilter >> linkFilter: anObject [
	linkFilter := anObject
]

{ #category : #testing }
LeContentMatchingLinkFilter >> matches: aLeContent [
	^ aLeContent allOutgoingExplicitLinks anySatisfy: [ :aLink |
		self linkFilter matches: aLink ]
]

{ #category : #printing }
LeContentMatchingLinkFilter >> printOn: aStream [
	aStream
		nextPutAll: 'Content with links '.
	self linkFilter printOn: aStream
]
