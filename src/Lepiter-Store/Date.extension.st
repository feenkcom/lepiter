Extension { #name : #Date }

{ #category : #'*Lepiter-Store' }
Date class >> leFromJsonV3Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self fromString: (aDictionary at: #dateString)
]

{ #category : #'*Lepiter-Store' }
Date class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self fromString: (aDictionary at: #dateString)
]

{ #category : #'*Lepiter-Store' }
Date class >> leJsonV3MappingFor: aNeoJSONMapper [
	"Dates are encoded as their type and a single string in default Date format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV3Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #dateString
			getter: [ :object | object printString ]
			setter: [ :dateString | self fromString: dateString ] ].

]

{ #category : #'*Lepiter-Store' }
Date class >> leJsonV3Name [

	^ #date
]

{ #category : #'*Lepiter-Store' }
Date class >> leJsonV4MappingFor: aNeoJSONMapper [
	"Dates are encoded as their type and a single string in default Date format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #dateString
			getter: [ :object | object printString ]
			setter: [ :dateString | self fromString: dateString ] ].

]

{ #category : #'*Lepiter-Store' }
Date class >> leJsonV4Name [

	^ #date
]
