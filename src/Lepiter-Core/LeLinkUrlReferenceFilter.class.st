Class {
	#name : #LeLinkUrlReferenceFilter,
	#superclass : #LeFilter,
	#instVars : [
		'urlString'
	],
	#category : 'Lepiter-Core-Database - Filters Links'
}

{ #category : #testing }
LeLinkUrlReferenceFilter >> matches: aLinkReference [
	^ aLinkReference isExternalReference and: [
		aLinkReference isUrlReference and: [ 
			aLinkReference url beginsWith: self urlString ] ]
]

{ #category : #printing }
LeLinkUrlReferenceFilter >> printOn: aStream [
	aStream
		nextPutAll: 'URL ';
		nextPutAll: self urlString
]

{ #category : #accessing }
LeLinkUrlReferenceFilter >> urlString [
	^ urlString
]

{ #category : #accessing }
LeLinkUrlReferenceFilter >> urlString: anObject [
	urlString := anObject
]
