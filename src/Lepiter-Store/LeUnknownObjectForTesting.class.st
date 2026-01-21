Class {
	#name : #LeUnknownObjectForTesting,
	#superclass : #Object,
	#instVars : [
		'unknownParsedObject'
	],
	#category : 'Lepiter-Store-Examples'
}

{ #category : #serialization }
LeUnknownObjectForTesting class >> deSerializeAllImplementorsInstances [
	"Answer a collection of instances to be tested for serialisation / deserialisation"

	^ {  }
]

{ #category : #'instance creation' }
LeUnknownObjectForTesting class >> forUnknownParsedObject: anUnknownObject [ 
	^ self new
			unknownParsedObject: anUnknownObject 
]

{ #category : #serialization }
LeUnknownObjectForTesting class >> leJsonV4MappingFor: aNeoJSONMapper [
	"LeUnknownPageType simply writes its jsonString out"

	"This should just be a custom mapper that encodes and decodes the json string in the snippet"
	aNeoJSONMapper for: self customDo: [ :mapping | 
		mapping 
			reader: [ :jsonReader :arg | 
				self error: 'Unknown object decoding happens in LeJsonV4Reader' ];
			writer: [ :jsonWriter :leUnknownObjectForTesting |
				leUnknownObjectForTesting unknownParsedObject map neoJsonOn: jsonWriter ] ]
]

{ #category : #serialization }
LeUnknownObjectForTesting class >> leJsonV4Name [
	^ #unknownObjectForTesting
]

{ #category : #accessing }
LeUnknownObjectForTesting >> unknownParsedObject [
	^ unknownParsedObject
]

{ #category : #accessing }
LeUnknownObjectForTesting >> unknownParsedObject: anObject [
	unknownParsedObject := anObject
]
