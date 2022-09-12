Class {
	#name : #LeTweetRefMediaLinkReference,
	#superclass : #LeLinkExternalReference,
	#instVars : [
		'media'
	],
	#category : #'Lepiter-Core-Twitter'
}

{ #category : #jsonV3 }
LeTweetRefMediaLinkReference class >> leJsonV3AttributeMapping [

	^ super leJsonV3AttributeMapping
		add: (#mediaRawData -> #media);
		yourself
]

{ #category : #accessing }
LeTweetRefMediaLinkReference class >> leJsonV3Name [

	^ 'tweetMediaReference'
]

{ #category : #jsonV3 }
LeTweetRefMediaLinkReference class >> leJsonV4AttributeMapping [

	^ super leJsonV4AttributeMapping
		add: (#mediaRawData -> #media);
		yourself
]

{ #category : #accessing }
LeTweetRefMediaLinkReference class >> leJsonV4Name [

	^ 'tweetMediaReference'
]

{ #category : #converting }
LeTweetRefMediaLinkReference >> asPreviewElement [
	^ BrAsyncFileWidget new
		url: (self url asZnUrl & ('format' -> 'jpg')) asString;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]

{ #category : #'api - accessing' }
LeTweetRefMediaLinkReference >> description [
	^ 'Tweet Media Reference: ', (self url asString ifNil: [ String empty ])
]

{ #category : #'api - testing' }
LeTweetRefMediaLinkReference >> isExternalTweetMediaReference [
	^ true
]

{ #category : #'api - testing' }
LeTweetRefMediaLinkReference >> isPhoto [
	^ self media isPhoto
]

{ #category : #testing }
LeTweetRefMediaLinkReference >> matches: anotherObject [
	
	^ (super matches: anotherObject) and: [ 
			self url = anotherObject url ]
]

{ #category : #'api - accessing' }
LeTweetRefMediaLinkReference >> media [
	^ media
]

{ #category : #'api - accessing' }
LeTweetRefMediaLinkReference >> media: anObject [
	media := anObject
]

{ #category : #'api - json' }
LeTweetRefMediaLinkReference >> mediaRawData [
	"I am used to store the object as a JSON string"

	^ media ifNotNil: [ media rawData ].
]

{ #category : #'api - json' }
LeTweetRefMediaLinkReference >> mediaRawData: aDictionary [
	"I am used to initialize the object from a JSON string"

	media := aDictionary ifNotNil: [ LeTweetMedia new rawData: aDictionary ]
]

{ #category : #'api - accessing' }
LeTweetRefMediaLinkReference >> type [
	^ self media type
]

{ #category : #'api - accessing' }
LeTweetRefMediaLinkReference >> url [
	^ self media url
]
