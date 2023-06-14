Class {
	#name : #LeServerConfiguration,
	#superclass : #Object,
	#instVars : [
		'jwtPublicKey',
		'authServerUrl',
		'permissionsToken',
		'debugMode'
	],
	#category : #'Lepiter-BasicServer'
}

{ #category : #accessing }
LeServerConfiguration class >> defaultPortNumber [
	self subclassResponsibility
]

{ #category : #'instance creation' }
LeServerConfiguration class >> forCurrentEnvironment [
	| config |
	config := self new.
	config debugMode: false.
	config 
		jwtPublicKey: (OSPlatform current environment at: 'USER_AUTH_JWT_PUBKEY');
		permissionsToken: (OSPlatform current environment at: 'SERVER_AUTH_JWT_TOKEN');
		authServerUrl: (OSPlatform current environment at: 'SERVER_AUTH_URL').
	^ config
]

{ #category : #accessing }
LeServerConfiguration >> authServerUrl [
	^ authServerUrl
]

{ #category : #accessing }
LeServerConfiguration >> authServerUrl: anObject [
	authServerUrl := anObject
]

{ #category : #accessing }
LeServerConfiguration >> debugMode [
	^ debugMode ifNil: [ false ]
]

{ #category : #accessing }
LeServerConfiguration >> debugMode: aBoolean [
	^ debugMode := aBoolean
]

{ #category : #accessing }
LeServerConfiguration >> jwtPublicKey [
	^ jwtPublicKey
]

{ #category : #accessing }
LeServerConfiguration >> jwtPublicKey: anObject [
	jwtPublicKey := anObject
]

{ #category : #accessing }
LeServerConfiguration >> permissionsToken [
	^ permissionsToken
]

{ #category : #accessing }
LeServerConfiguration >> permissionsToken: anObject [
	permissionsToken := anObject
]
