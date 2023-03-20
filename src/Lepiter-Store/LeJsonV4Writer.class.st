Class {
	#name : #LeJsonV4Writer,
	#superclass : #NeoJSONWriter,
	#instVars : [
		'firstMappedObject'
	],
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #accessing }
LeJsonV4Writer >> gtMappingsFor: aView [
	<gtView>
	^ aView columnedList 
		title: 'Mappings';
		items: [ mappings associations sorted: [:a :b | a key name < b key name ] ];
		column: 'Class' text: #key;
		column: 'Mapping' text: #value
]

{ #category : #accessing }
LeJsonV4Writer >> gtSearchMappingsFor: aSearch [
	<gtSearch>
	^ aSearch list 
		priority: 1;
		title: 'Mappings';
		items: [ mappings associations ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true;
		send: #value
]

{ #category : #'initialize-release' }
LeJsonV4Writer >> on: aStream [

	super on: aStream.
	firstMappedObject := true.
]

{ #category : #copying }
LeJsonV4Writer >> postCopy [

	super postCopy.
	writeStream := nil.
	level := 0.
	firstMappedObject := nil.
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
