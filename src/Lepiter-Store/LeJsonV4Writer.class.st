Class {
	#name : #LeJsonV4Writer,
	#superclass : #NeoJSONWriter,
	#instVars : [
		'firstMappedObject'
	],
	#category : 'Lepiter-Store-JsonV4'
}

{ #category : #'initialize-release' }
LeJsonV4Writer >> on: aStream [

	super on: aStream.
	firstMappedObject := true.
]

{ #category : #writing }
LeJsonV4Writer >> writeMap: keyValueCollection [
	"Write the map out with sorted keys so code version history is cleaner"

	self writeMapStreamingDo: [ :jsonMapWriter |
		keyValueCollection keys sorted do: [ :key | | value |
			value := keyValueCollection at: key.
			jsonMapWriter writeKey: key value: value ] ]
]

{ #category : #writing }
LeJsonV4Writer >> writeMapStreamingDo: block [
	writeStream nextPut: ${.
	self writeStreamingDo: 
		[ :jsonMapWriter |
			firstMappedObject ifTrue: 
				[ self writeSchemaOn: jsonMapWriter. ].
			block value: jsonMapWriter ].
	writeStream nextPut: $}
]

{ #category : #writing }
LeJsonV4Writer >> writeSchemaOn: jsonMapWriter [

	jsonMapWriter writeKey: #'__schema' value: LeLocalJsonV4Storage currentVersionString.
	firstMappedObject := false.
]
