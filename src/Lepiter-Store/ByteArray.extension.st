Extension { #name : #ByteArray }

{ #category : #'*Lepiter-Store' }
ByteArray class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self evaluate: (aDictionary at: #byteArrayString)
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
			getter: [ :object | object storeString ]
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
	neoJSONWriter writeObject: self
]
