Class {
	#name : #LeJavaScriptApplicationGlobalStrategy,
	#superclass : #LeJavaScriptApplicationStrategy,
	#category : 'Lepiter-JavaScript'
}

{ #category : #accessing }
LeJavaScriptApplicationGlobalStrategy class >> strategyName [

	^ #global
]

{ #category : #accessing }
LeJavaScriptApplicationGlobalStrategy >> applicationServer [

	content database isDatabase ifFalse: [ ^ nil ].
	JSLinkApplication uniqueInstance ifNil:
		[ JSLinkApplication uniqueInstance: (self newJavaScriptApplicationFor: content database) ].
	^ JSLinkApplication uniqueInstance
]

{ #category : #'as yet unclassified' }
LeJavaScriptApplicationGlobalStrategy >> applicationSettings [
	"Answer the settings that will be used by the server.
	This musn't actually start the server as that should be deferred until a snippet is evaluated for the first time."

	^ JSLinkApplication isRunning ifTrue:
		[ JSLinkApplication uniqueInstance settings ]
	ifFalse:
		[ self updatedSettings: JSLinkApplication defaultSettings ]
]
