Class {
	#name : 'LeGemStoneSettings',
	#superclass : 'LeSubSettings',
	#category : 'Lepiter-Snippet-GemStone-Settings'
}

{ #category : 'accessing - db properties' }
LeGemStoneSettings >> host [
	"Answer the host name string of the GemStone server"
	<return: #String or: nil>

	^ self subProperties at: #host ifAbsent: [ nil ]
]

{ #category : 'accessing - db properties' }
LeGemStoneSettings >> host: aStringOrNil [
	"Set the host string of the GemStone server"

	^ self updateProperty: #host value: aStringOrNil
]

{ #category : 'accessing - db properties' }
LeGemStoneSettings >> port [
	"Answer the host port number of the GemStone server"
	<return: #Integer or: nil>

	^ self subProperties at: #port ifAbsent: [ nil ]
]

{ #category : 'accessing - db properties' }
LeGemStoneSettings >> port: anIntegerOrNil [
	"Set the port number of the GemStone server"

	^ self updateProperty: #port value: anIntegerOrNil 
]

{ #category : 'private - accessing' }
LeGemStoneSettings >> subProperties [

	^ dbProperties gemStone
]

{ #category : 'private - accessing' }
LeGemStoneSettings >> subProperties: aDictionary [

	dbProperties gemStone: aDictionary
]
