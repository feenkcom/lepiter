Class {
	#name : 'LeGemStoneApplicationGlobalStrategy',
	#superclass : 'LeGemStoneApplicationStrategy',
	#category : 'Lepiter-Snippet-GemStone-Settings'
}

{ #category : 'accessing' }
LeGemStoneApplicationGlobalStrategy >> applicationServer [

	content database isDatabase ifFalse: [ ^ nil ].
	GtGemStoneClient uniqueInstance isRunning ifFalse:
		[ GtGemStoneClient uniqueInstance: (self newApplicationFor: content database) ].
	^ GtGemStoneClient uniqueInstance
]

{ #category : 'accessing' }
LeGemStoneApplicationGlobalStrategy >> applicationSettings [
	"Answer the settings that will be used by the server.
	The lepiter GemStone settings contain all the required information."

	^ content database properties gemStoneSettings
]
