Class {
	#name : #LeTweetRefLinkReference,
	#superclass : #LeLinkExternalUrlReference,
	#category : #'Lepiter-Core-Twitter'
}

{ #category : #accessing }
LeTweetRefLinkReference class >> leJsonV3Name [

	^ 'tweetReference'
]

{ #category : #accessing }
LeTweetRefLinkReference class >> leJsonV4Name [

	^ 'tweetReference'
]

{ #category : #accessing }
LeTweetRefLinkReference >> description [
	^ 'Tweet Reference: ', (self url asString ifNil: [ String empty ])
]

{ #category : #testing }
LeTweetRefLinkReference >> isExternalTweetReference [
	^ true
]
