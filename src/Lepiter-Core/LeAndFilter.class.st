Class {
	#name : #LeAndFilter,
	#superclass : #LeCompositeFilter,
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #testing }
LeAndFilter >> matches: aLeContent [
	^ (left matches: aLeContent) and: [ right matches: aLeContent ]
]

{ #category : #printing }
LeAndFilter >> printOn: aStream [
	left printOn: aStream.
	aStream nextPutAll: ' and '.
	right printOn: aStream
]
