Class {
	#name : #LeMockJsonV4WithMissingDeserializers,
	#superclass : #LeJsonV4,
	#instVars : [
		'deserializersToDisable',
		'disableDeserializers'
	],
	#category : #'Lepiter-Core-Examples-Mocks'
}

{ #category : #accessing }
LeMockJsonV4WithMissingDeserializers >> deserializersToDisable [
	^ deserializersToDisable
]

{ #category : #accessing }
LeMockJsonV4WithMissingDeserializers >> deserializersToDisable: aCollection [
	deserializersToDisable := aCollection
]

{ #category : #accessing }
LeMockJsonV4WithMissingDeserializers >> disableDeserializers [
	disableDeserializers := true
]

{ #category : #accessing }
LeMockJsonV4WithMissingDeserializers >> enableDeserializers [
	disableDeserializers := false
]

{ #category : #initialization }
LeMockJsonV4WithMissingDeserializers >> initialize [
	super initialize.
	disableDeserializers := false
]

{ #category : #initialization }
LeMockJsonV4WithMissingDeserializers >> newReader [
	| aReader |
	mutex
		critical: [ aReader := LeJsonV4Reader new.
			self allClassMappingsFor: aReader.
			disableDeserializers
				ifTrue: [ self deserializersToDisable
						do: [ :each | 
							aReader mappings removeKey: each.
							(aReader instVarNamed: #typeMap) removeKey: each leJsonV4Name ] ] ].
	^ aReader
]
