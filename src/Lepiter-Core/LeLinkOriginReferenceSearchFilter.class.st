Class {
	#name : #LeLinkOriginReferenceSearchFilter,
	#superclass : #LeFilter,
	#instVars : [
		'searchFilter'
	],
	#category : 'Lepiter-Core-Database - Filters Links'
}

{ #category : #testing }
LeLinkOriginReferenceSearchFilter >> matches: aLeLink [
	^ self searchFilter matches: aLeLink originReference
]

{ #category : #printing }
LeLinkOriginReferenceSearchFilter >> printOn: aStream [
	aStream
		nextPutAll: 'with origin '.
	self searchFilter printOn: aStream
]

{ #category : #accessing }
LeLinkOriginReferenceSearchFilter >> searchFilter [
	^ searchFilter
]

{ #category : #accessing }
LeLinkOriginReferenceSearchFilter >> searchFilter: anObject [
	searchFilter := anObject
]
