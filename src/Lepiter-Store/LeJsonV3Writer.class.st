"
LeJsonV3Writer is a type of {{gtClass:name=NeoJSONWriter}} that includes the schema identifier ""V3"" in the first mapped object written to the JSON stream.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	firstMappedObject:		<Boolean> 	A flag indicating whether the schema has been written.


### Implementation Points

"
Class {
	#name : #LeJsonV3Writer,
	#superclass : #NeoJSONWriter,
	#instVars : [
		'firstMappedObject'
	],
	#category : 'Lepiter-Store-JSONV3'
}

{ #category : #'initialize-release' }
LeJsonV3Writer >> on: aStream [

	super on: aStream.
	firstMappedObject := true.
]

{ #category : #writing }
LeJsonV3Writer >> writeMap: keyValueCollection [
	"Write the map out with sorted keys so code version history is cleaner"

	self writeMapStreamingDo: [ :jsonMapWriter |
		keyValueCollection keys sorted do: [ :key | | value |
			value := keyValueCollection at: key.
			jsonMapWriter writeKey: key value: value ] ]
]

{ #category : #writing }
LeJsonV3Writer >> writeMapStreamingDo: block [
	writeStream nextPut: ${.
	self writeStreamingDo: 
		[ :jsonMapWriter |
			firstMappedObject ifTrue: 
				[ self writeSchemaOn: jsonMapWriter. ].
			block value: jsonMapWriter ].
	writeStream nextPut: $}
]

{ #category : #writing }
LeJsonV3Writer >> writeSchemaOn: jsonMapWriter [

	jsonMapWriter writeKey: #'__schema' value: LeLocalJsonV3Storage currentVersionString.
	firstMappedObject := false.
]
