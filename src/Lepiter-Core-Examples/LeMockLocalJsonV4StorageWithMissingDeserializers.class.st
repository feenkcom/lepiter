Class {
	#name : #LeMockLocalJsonV4StorageWithMissingDeserializers,
	#superclass : #LeLocalJsonV4Storage,
	#instVars : [
		'deserializersToRemove',
		'leJsonV4'
	],
	#category : #'Lepiter-Core-Examples-Mocks'
}

{ #category : #accessing }
LeMockLocalJsonV4StorageWithMissingDeserializers >> deserializersToRemove [
	^ deserializersToRemove
]

{ #category : #accessing }
LeMockLocalJsonV4StorageWithMissingDeserializers >> deserializersToRemove: aCollection [
	deserializersToRemove := aCollection
]

{ #category : #loading }
LeMockLocalJsonV4StorageWithMissingDeserializers >> leJsonV4 [
	^ leJsonV4
		ifNil: [ leJsonV4 := LeMockJsonV4WithMissingDeserializers new
					deserializersToDisable: self deserializersToRemove ]
]
