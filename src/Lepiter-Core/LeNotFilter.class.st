Class {
	#name : #LeNotFilter,
	#superclass : #LeFilter,
	#instVars : [
		'filter'
	],
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LeNotFilter >> filter [
	^ filter
]

{ #category : #accessing }
LeNotFilter >> filter: aLeFilter [
	filter := aLeFilter
]

{ #category : #testing }
LeNotFilter >> matches: aLeContent [
	^ (filter matches: aLeContent) not
]

{ #category : #printing }
LeNotFilter >> printOn: aStream [
	aStream nextPutAll: 'not '.
	self filter printOn: aStream
]
