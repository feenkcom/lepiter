Class {
	#name : #LeBasicServerJWTUserToken,
	#superclass : #Object,
	#instVars : [
		'jwtPublicKey',
		'jwtToken'
	],
	#category : #'Lepiter-BasicServer'
}

{ #category : #'instance creation' }
LeBasicServerJWTUserToken class >> forRequest: aRequest withPublicKey: aPublicKey [
	^ self new
		jwtPublicKey: aPublicKey;
		initializeFromRequest: aRequest
]

{ #category : #accessing }
LeBasicServerJWTUserToken >> bearerTextSize [
	^ 7
]

{ #category : #initialization }
LeBasicServerJWTUserToken >> initializeFromRequest: aRequest [
	| authorization receivedToken |
	
	(aRequest headers includesKey: 'Authorization') ifFalse: [ ^ nil ].
	
	authorization := aRequest authorization.
	authorization size <= self bearerTextSize ifTrue: [ ^ nil ].
	receivedToken := authorization 
		copyFrom: self bearerTextSize + 1 
		to: authorization size.
	
	jwtToken := JsonWebSignature 
		materializeCompact: receivedToken 
		key: jwtPublicKey.
]

{ #category : #accessing }
LeBasicServerJWTUserToken >> jwtPublicKey [
	^ jwtPublicKey
]

{ #category : #accessing }
LeBasicServerJWTUserToken >> jwtPublicKey: anObject [
	jwtPublicKey := anObject
]

{ #category : #accessing }
LeBasicServerJWTUserToken >> userSubClaim [
	^ jwtToken payload claims at: 'sub'
]

{ #category : #accessing }
LeBasicServerJWTUserToken >> userUuid [
	^ UUID fromString: self userSubClaim 
]
