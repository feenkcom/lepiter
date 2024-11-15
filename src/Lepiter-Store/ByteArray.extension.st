Extension { #name : #ByteArray }

{ #category : #'*Lepiter-Store' }
ByteArray class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."
	| serialized |

	serialized := aDictionary at: #byteArrayString.
	^ (serialized beginsWith: '#[')
		ifTrue: [ self evaluate: serialized ]
		ifFalse: [ serialized base64Decoded ]
]

{ #category : #'*Lepiter-Store' }
ByteArray class >> leJsonV4MappingFor: aNeoJSONMapper [
	"ByteArrays are encoded as their type and a single string in default storeString format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #byteArrayString
			getter: [ :object | object base64Encoded ]
			setter: [ :byteArrayString | self evaluate: byteArrayString ] ].

]

{ #category : #'*Lepiter-Store' }
ByteArray class >> leJsonV4Name [

	^ self = ByteArray
		ifTrue: [ #byteArray ]
		ifFalse: [ ].
]

{ #category : #'*Lepiter-Store' }
ByteArray >> neoJsonOn: neoJSONWriter [
	"Write the receiver with the supplied writer"

	"If there is a specific mapping for the receiver, use that instead of the general collection"
	^ (neoJSONWriter mappingFor: self class ifAbsent: [ nil ])
		ifNotNil: [ neoJSONWriter writeObject: self ]
		ifNil: [ super neoJsonOn: neoJSONWriter ]
]
