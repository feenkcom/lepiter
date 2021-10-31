Class {
	#name : #LeLinkTargetReferenceSearchFilter,
	#superclass : #LeFilter,
	#instVars : [
		'searchFilter'
	],
	#category : 'Lepiter-Core-Database - Filters Links'
}

{ #category : #testing }
LeLinkTargetReferenceSearchFilter >> matches: aLeLink [
	^ self searchFilter matches: aLeLink targetReference
]

{ #category : #printing }
LeLinkTargetReferenceSearchFilter >> printOn: aStream [
	aStream
		nextPutAll: 'with target '.
	self searchFilter printOn: aStream
]

{ #category : #accessing }
LeLinkTargetReferenceSearchFilter >> searchFilter [
	^ searchFilter
]

{ #category : #accessing }
LeLinkTargetReferenceSearchFilter >> searchFilter: anObject [
	searchFilter := anObject
]
