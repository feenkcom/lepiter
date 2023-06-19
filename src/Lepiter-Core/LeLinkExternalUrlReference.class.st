Class {
	#name : #LeLinkExternalUrlReference,
	#superclass : #LeLinkExternalReference,
	#instVars : [
		'url'
	],
	#category : 'Lepiter-Core-Links'
}

{ #category : #'instace creation' }
LeLinkExternalUrlReference class >> forUrl: aString [
	^ self new url: aString
]

{ #category : #accessing }
LeLinkExternalUrlReference >> description [
	^ 'URL Reference: ', (self url asString ifNil: [ String empty ])
]

{ #category : #testing }
LeLinkExternalUrlReference >> isUrlReference [
	^ true
]

{ #category : #comparing }
LeLinkExternalUrlReference >> matches: anotherObject [
	
	^ (super matches: anotherObject) and: [ 
			self url = anotherObject url ]
]

{ #category : #accessing }
LeLinkExternalUrlReference >> url [
	^ url
]

{ #category : #accessing }
LeLinkExternalUrlReference >> url: aString [
	url := aString
]
