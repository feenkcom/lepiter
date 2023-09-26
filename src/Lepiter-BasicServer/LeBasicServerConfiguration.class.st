Class {
	#name : #LeBasicServerConfiguration,
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
LeBasicServerConfiguration class >> defaultPortNumber [
	self subclassResponsibility
]

{ #category : #'instance creation' }
LeBasicServerConfiguration class >> forCurrentEnvironment [
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
LeBasicServerConfiguration >> authServerUrl [
	^ authServerUrl
]

{ #category : #accessing }
LeBasicServerConfiguration >> authServerUrl: anObject [
	authServerUrl := anObject
]

{ #category : #accessing }
LeBasicServerConfiguration >> debugMode [
	^ debugMode ifNil: [ false ]
]

{ #category : #accessing }
LeBasicServerConfiguration >> debugMode: aBoolean [
	^ debugMode := aBoolean
]

{ #category : #accessing }
LeBasicServerConfiguration >> jwtPublicKey [
	^ jwtPublicKey
]

{ #category : #accessing }
LeBasicServerConfiguration >> jwtPublicKey: anObject [
	jwtPublicKey := anObject
]

{ #category : #accessing }
LeBasicServerConfiguration >> permissionsToken [
	^ permissionsToken
]

{ #category : #accessing }
LeBasicServerConfiguration >> permissionsToken: anObject [
	permissionsToken := anObject
]
