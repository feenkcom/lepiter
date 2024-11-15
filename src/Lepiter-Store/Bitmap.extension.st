Extension { #name : #Bitmap }

{ #category : #'*Lepiter-Store' }
Bitmap class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self decompressFromByteArray: (self evaluate: (aDictionary at: #byteArrayString))
]

{ #category : #'*Lepiter-Store' }
Bitmap class >> leJsonV4MappingFor: aNeoJSONMapper [
	"ByteArrays are encoded as their type and a single string in default storeString format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #byteArrayString
			getter: [ :object | object compressToByteArray storeString ]
			setter: [ :um | self error: 'Objects should not be read here' ] ].

]

{ #category : #'*Lepiter-Store' }
Bitmap class >> leJsonV4Name [

	^ #bitmap
]

{ #category : #'*Lepiter-Store' }
Bitmap >> neoJsonOn: neoJSONWriter [
	"Write the receiver with the supplied writer"

	"If there is a specific mapping for the receiver, use that instead of the general collection"
	^ (neoJSONWriter mappingFor: self class ifAbsent: [ nil ])
		ifNotNil: [ neoJSONWriter writeObject: self ]
		ifNil: [ super neoJsonOn: neoJSONWriter ]
]
