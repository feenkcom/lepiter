Class {
	#name : #LeLinkExternalReference,
	#superclass : #LeLinkReference,
	#category : 'Lepiter-Core-Links'
}

{ #category : #testing }
LeLinkExternalReference >> isExternalReference [
	^ true
]

{ #category : #testing }
LeLinkExternalReference >> isUrlReference [
	^ false
]
