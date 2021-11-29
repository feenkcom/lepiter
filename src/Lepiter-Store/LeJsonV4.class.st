Class {
	#name : #LeJsonV4,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #private }
LeJsonV4 >> allClassMappingsFor: aNeoJSONMapper [ 

	(SystemNavigation default allImplementorsOf: #leJsonV4Name) do: [ :method |
		| jsonName |
		jsonName := method 
							gtValueWithReceiver: method methodClass basicNew 
							possibleArguments: #().
		jsonName ifNotNil: [ method methodClass instanceSide leJsonV4MappingFor: aNeoJSONMapper ] ].

	"LeModel allSubclassesDo: [ :leClass |
		leClass leJsonV4MappingFor: aNeoJSONMapper ].
	Date leJsonV4MappingFor: aNeoJSONMapper.
	DateAndTime leJsonV4MappingFor: aNeoJSONMapper.
	UUID leJsonV4MappingFor: aNeoJSONMapper.
	FileReference leJsonV4MappingFor: aNeoJSONMapper."

]

{ #category : #'api - serializing' }
LeJsonV4 >> deserialize: aStream [
	"Deserialise the supplied stream"
	| object |

	object := self newReader 
		on: aStream;
		next.
	"If the deserialised object is a Dictionary, the __schema should be removed"
	object isDictionary ifTrue:
		[ object removeKey: #'__schema' ifAbsent: [ ] ].

	^ object
]

{ #category : #initialization }
LeJsonV4 >> newReader [ 
	| newReader |

	newReader := LeJsonV4Reader new.
	self allClassMappingsFor: newReader.
	^ newReader

]

{ #category : #initialization }
LeJsonV4 >> newWriter [ 
	| newWriter |

	newWriter := LeJsonV4Writer new.
	self allClassMappingsFor: newWriter.
	^ newWriter 
]

{ #category : #private }
LeJsonV4 >> schemaFor: aKey [
	"Answer the schema (class) for the given key"

	^ LeModel allSubclasses detect: 
		[ :each | each leJsonV4Name = aKey ].
]

{ #category : #accessing }
LeJsonV4 >> serialize: aLeModel [

	^ String streamContents: [ :stream | 
		  self serialize: aLeModel on: stream prettyPrint: false ]
]

{ #category : #'api - serializing' }
LeJsonV4 >> serialize: aLeModel on: aStream prettyPrint: aBoolean [
	"Serialise the supplied object. aLeModel is a subclass of LeModel"

	self newWriter 
		on: aStream;
		prettyPrint: aBoolean;
		nextPut: aLeModel.

]
