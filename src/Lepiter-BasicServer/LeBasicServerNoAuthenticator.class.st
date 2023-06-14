Class {
	#name : #LeBasicServerNoAuthenticator,
	#superclass : #Object,
	#category : #'Lepiter-BasicServer'
}

{ #category : #public }
LeBasicServerNoAuthenticator >> authenticateRequest: request do: block [
	^ ZnResponse unauthorized: 'Unauthorized'
]
