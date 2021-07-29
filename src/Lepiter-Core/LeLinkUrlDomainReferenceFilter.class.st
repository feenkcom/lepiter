Class {
	#name : #LeLinkUrlDomainReferenceFilter,
	#superclass : #LeFilter,
	#instVars : [
		'urlDomain'
	],
	#category : 'Lepiter-Core-Database - Filters Links'
}

{ #category : #testing }
LeLinkUrlDomainReferenceFilter >> matches: aLinkReference [
	^ aLinkReference isExternalReference and: [
		aLinkReference isUrlReference and: [ 
			aLinkReference url asZnUrl host = self urlDomain  ] ]
]

{ #category : #printing }
LeLinkUrlDomainReferenceFilter >> printOn: aStream [
	aStream
		nextPutAll: 'with domain ';
		nextPutAll: self urlDomain
]

{ #category : #accessing }
LeLinkUrlDomainReferenceFilter >> urlDomain [
	^ urlDomain
]

{ #category : #accessing }
LeLinkUrlDomainReferenceFilter >> urlDomain: anObject [
	urlDomain := anObject
]
