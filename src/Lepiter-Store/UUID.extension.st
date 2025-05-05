Extension { #name : #UUID }

{ #category : #'*Lepiter-Store' }
UUID >> gtLeJsonV4Methods [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	^ UUID class gtMethodsInClass & 'leJsonV4' gtSubstringMatch
]

{ #category : #'*Lepiter-Store' }
UUID class >> leFromJsonV3Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self fromString: (aDictionary at: #uuid)
]

{ #category : #'*Lepiter-Store' }
UUID class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self fromString: (aDictionary at: #uuid)
]

{ #category : #'*Lepiter-Store' }
UUID class >> leJsonV3MappingFor: aNeoJSONMapper [
	"Dates are encoded as their type and a single string in default Date format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV3Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #uuid
			getter: [ :object | object asString ]
			setter: [ :uuidString | self fromString: uuidString ] ].

]

{ #category : #'*Lepiter-Store' }
UUID class >> leJsonV3Name [

	^ #uuid
]

{ #category : #'*Lepiter-Store' }
UUID class >> leJsonV4MappingFor: aNeoJSONMapper [
	"Dates are encoded as their type and a single string in default Date format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #uuid
			getter: [ :object | object asString ]
			setter: [ :uuidString | self fromString: uuidString ] ].

]

{ #category : #'*Lepiter-Store' }
UUID class >> leJsonV4Name [

	^ #uuid
]

{ #category : #'*Lepiter-Store' }
UUID >> neoJsonOn: neoJSONWriter [
	"Write the receiver with the supplied writer"

	"If there is a specific mapping for the receiver, use that instead of the general collection"
	^ (neoJSONWriter mappingFor: self class ifAbsent: [ nil ])
		ifNotNil: [ neoJSONWriter writeObject: self ]
		ifNil: [ super neoJsonOn: neoJSONWriter ]
]
