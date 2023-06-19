Class {
	#name : #LePageUnlinkedReferencesFilter,
	#superclass : #LePageLinkedReferencesFilter,
	#instVars : [
		'page'
	],
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #testing }
LePageUnlinkedReferencesFilter >> matches: aLeContent [
	"Answer a boolean indicating whether the supplied content (page or content) references the page with the receiver's title as part of its text (but not an explicit link)."

	page ifNil: [ page := aLeContent database pageNamed: title ].

	^ page incomingUnlinked
		detect: [ :each | each origin page = aLeContent ]
		ifFound: [ true ]
		ifNone: [ false ].

]

{ #category : #printing }
LePageUnlinkedReferencesFilter >> printOn: aStream [
	aStream
		nextPutAll: self title;
		nextPutAll: ' Unlinked References'
]
