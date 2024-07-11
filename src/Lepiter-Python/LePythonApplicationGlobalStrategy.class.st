Class {
	#name : #LePythonApplicationGlobalStrategy,
	#superclass : #LePythonApplicationStrategy,
	#category : #'Lepiter-Python-Settings'
}

{ #category : #naming }
LePythonApplicationGlobalStrategy class >> strategyName [

	^ #global
]

{ #category : #accessing }
LePythonApplicationGlobalStrategy >> applicationServer [
	PBApplication isRunning
		ifFalse: [ 
			PBApplication uniqueInstance
				ifNil: [ PBApplication uniqueInstance: (self newPbApplicationFor: content database) ] ].
	^ PBApplication uniqueInstance
]

{ #category : #accessing }
LePythonApplicationGlobalStrategy >> applicationSettings [
	"Answer the settings that will be used by the server.
	This musn't actually start the server as that should be deferred until a snippet is evaluated for the first time."

	^ PBApplication isRunning
		ifTrue: [ PBApplication uniqueInstance settings ]
		ifFalse: [ self updatedSettings: PBApplication new settings ]
]
