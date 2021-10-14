Class {
	#name : #LePharoLinkApplicationGlobalStrategy,
	#superclass : #LePharoLinkApplicationStrategy,
	#category : 'Lepiter-Snippet-PharoLink-Settings'
}

{ #category : #accessing }
LePharoLinkApplicationGlobalStrategy >> applicationServer [

	content database isDatabase ifFalse: [ ^ nil ].
	PharoLinkApplication isRunning ifFalse:
		[ PharoLinkApplication uniqueInstance: (self newApplicationFor: content database) ].
	^ PharoLinkApplication uniqueInstance
]

{ #category : #accessing }
LePharoLinkApplicationGlobalStrategy >> applicationSettings [
	"Answer the settings that will be used by the server.
	This musn't actually start the server as that should be deferred until a snippet is evaluated for the first time."

	^ PharoLinkApplication isRunning ifTrue:
		[ PharoLinkApplication uniqueInstance settings ]
	ifFalse:
		[ self updatedSettings: LanguageLinkSettings pharoDefaultSettings ]
]
