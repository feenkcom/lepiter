Class {
	#name : #LeLinkSearchPredicate,
	#superclass : #Object,
	#instVars : [
		'originSearchPredicate',
		'targetSearchPredicate'
	],
	#category : 'Lepiter-Core-Search'
}

{ #category : #initialization }
LeLinkSearchPredicate >> initialize [
	super initialize.
	self originSearchPredicate: (LeLinkReferenceSearchPredicate new
		searchBlock: [ :aReference | true ]).
	self targetSearchPredicate: (LeLinkReferenceSearchPredicate new
		searchBlock: [ :aReference | true ])
]

{ #category : #testing }
LeLinkSearchPredicate >> matches: aLink [
	^ (self originSearchPredicate matches: aLink originReference) and: [ 
		self targetSearchPredicate matches: aLink targetReference ] 
]

{ #category : #accessing }
LeLinkSearchPredicate >> originSearchPredicate [
	^ originSearchPredicate
]

{ #category : #accessing }
LeLinkSearchPredicate >> originSearchPredicate: anObject [
	originSearchPredicate := anObject
]

{ #category : #accessing }
LeLinkSearchPredicate >> targetSearchPredicate [
	^ targetSearchPredicate
]

{ #category : #accessing }
LeLinkSearchPredicate >> targetSearchPredicate: anObject [
	targetSearchPredicate := anObject
]
