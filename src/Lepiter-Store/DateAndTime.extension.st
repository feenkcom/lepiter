Extension { #name : #DateAndTime }

{ #category : #'*Lepiter-Store' }
DateAndTime class >> leFromJsonV3Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self fromString: (aDictionary at: #dateAndTimeString)
]

{ #category : #'*Lepiter-Store' }
DateAndTime class >> leFromJsonV4Dictionary: aDictionary [
	"Create a new instance of the receiver from the supplied dictionary."

	^ self fromString: (aDictionary at: #dateAndTimeString)
]

{ #category : #'*Lepiter-Store' }
DateAndTime class >> leJsonV3MappingFor: aNeoJSONMapper [
	"DateAndTimes are encoded as their type and a single string in default Date format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV3Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #dateAndTimeString
			getter: [ :object | object printString ]
			setter: [ :dateAndTimeString | self fromString: dateAndTimeString ] ].

]

{ #category : #'*Lepiter-Store' }
DateAndTime class >> leJsonV3Name [

	^ #dateAndTime
]

{ #category : #'*Lepiter-Store' }
DateAndTime class >> leJsonV4MappingFor: aNeoJSONMapper [
	"DateAndTimes are encoded as their type and a single string in default Date format"

	aNeoJSONMapper for: self do: [ :mapping | 
		mapping
			mapProperty: #'__type' 
			getter: [ :object | object class leJsonV4Name ] 
			setter: [ :um | self error: 'Objects should not be read here' ].
		mapping 
			mapProperty: #dateAndTimeString
			getter: [ :object | object printString ]
			setter: [ :dateAndTimeString | self fromString: dateAndTimeString ] ].

]

{ #category : #'*Lepiter-Store' }
DateAndTime class >> leJsonV4Name [

	^ #dateAndTime
]
