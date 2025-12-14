Class {
	#name : #LeUnknownPageType,
	#superclass : #LePageType,
	#instVars : [
		'map'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #serialization }
LeUnknownPageType class >> deSerializeAllImplementorsInstances [
	"Answer a collection of instances to be tested for serialisation / deserialisation"

	^ {  }
]

{ #category : #'instance creation' }
LeUnknownPageType class >> forMap: anObject [ 
	^ self new
		map:anObject
]

{ #category : #serialization }
LeUnknownPageType class >> leJsonV4MappingFor: aNeoJSONMapper [
	"LeUnknownPageType simply writes its jsonString out"

	"This should just be a custom mapper that encodes and decodes the json string in the snippet"
	aNeoJSONMapper for: self customDo: [ :mapping | 
		mapping 
			reader: [ :jsonReader :arg | 
				self error: 'Unknown pahe type decoding happens in LeJsonV4Reader' ];
			writer: [ :jsonWriter :leUnknownPageType |
				leUnknownPageType map neoJsonOn: jsonWriter ] ]
]

{ #category : #serialization }
LeUnknownPageType class >> leJsonV4Name [

	^ #unknownPageType
]

{ #category : #comparing }
LeUnknownPageType >> = anObject [
	"Answer whether the receiver and anObject represent the same page type."

	self == anObject
		ifTrue: [ ^ true ].
	^ self class = anObject class

]

{ #category : #accessing }
LeUnknownPageType >> databaseKey [
	"Answer the attribute used to index a page of the receiver's type in the database."

	^ page uid
]

{ #category : #comparing }
LeUnknownPageType >> hash [ 

	^ self class hash
]

{ #category : #accessing }
LeUnknownPageType >> isUnknownPageType [
	^ true
]

{ #category : #accessing }
LeUnknownPageType >> map [
	^ map
]

{ #category : #accessing }
LeUnknownPageType >> map: aDictionary [ 
	map := aDictionary 
]

{ #category : #printing }
LeUnknownPageType >> printOn: aStream [
	aStream 
		<< 'Unknown page type: ';
		<< (map
			at: '__type'
			ifAbsent: [ '<missing type>'])
]

{ #category : #accessing }
LeUnknownPageType >> title [
	^ 'Unknown page type'
]
