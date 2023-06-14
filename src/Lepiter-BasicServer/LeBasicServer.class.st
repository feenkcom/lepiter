Class {
	#name : #LeBasicServer,
	#superclass : #Object,
	#traits : 'TLeBasicServer',
	#classTraits : 'TLeBasicServer classTrait',
	#category : #'Lepiter-BasicServer'
}

{ #category : #accessing }
LeBasicServer >> configuration: aSyncServerConfiguration [
	self zincServer debugMode: aSyncServerConfiguration debugMode.
	self zincServer delegate configuration: aSyncServerConfiguration.
	self updateAuthenticator.
]
