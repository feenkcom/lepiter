Class {
	#name : #LeOrFilter,
	#superclass : #LeCompositeFilter,
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #testing }
LeOrFilter >> matches: aLeContent [
	^ (left matches: aLeContent) or: [ right matches: aLeContent ]
]

{ #category : #printing }
LeOrFilter >> printOn: aStream [
	left printOn: aStream.
	aStream nextPutAll: ' or '.
	right printOn: aStream
]
