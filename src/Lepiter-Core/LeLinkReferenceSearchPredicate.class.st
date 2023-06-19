Class {
	#name : #LeLinkReferenceSearchPredicate,
	#superclass : #Object,
	#instVars : [
		'searchBlock'
	],
	#category : 'Lepiter-Core-Search'
}

{ #category : #testing }
LeLinkReferenceSearchPredicate >> matches: aLinkReference [
	^ searchBlock value: aLinkReference
]

{ #category : #accessing }
LeLinkReferenceSearchPredicate >> searchBlock [
	^ searchBlock
]

{ #category : #accessing }
LeLinkReferenceSearchPredicate >> searchBlock: anObject [
	searchBlock := anObject
]
