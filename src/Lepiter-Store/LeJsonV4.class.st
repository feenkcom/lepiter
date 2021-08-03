Class {
	#name : 'LeJsonV4',
	#superclass : 'Object',
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Store-JsonV4'
}

{ #category : 'private' }
LeJsonV4 >> allClassMappingsFor: aNeoJSONMapper [ 

	LeModel allSubclassesDo: [ :leClass |
		leClass leJsonV4MappingFor: aNeoJSONMapper ].
	Date leJsonV4MappingFor: aNeoJSONMapper.
	DateAndTime leJsonV4MappingFor: aNeoJSONMapper.
	UUID leJsonV4MappingFor: aNeoJSONMapper.
	FileReference leJsonV4MappingFor: aNeoJSONMapper.

]

{ #category : 'api - serializing' }
LeJsonV4 >> deserialize: aStream [
	"Deserialise the supplied object. aLeClass is a subclass of LeModel"

	^ self newReader 
		on: aStream;
		next.

]

{ #category : 'initialization' }
LeJsonV4 >> newReader [ 
	| newReader |

	newReader := LeJsonV4Reader new.
	self allClassMappingsFor: newReader.
	^ newReader

]

{ #category : 'initialization' }
LeJsonV4 >> newWriter [ 
	| newWriter |

	newWriter := LeJsonV4Writer new.
	self allClassMappingsFor: newWriter.
	^ newWriter 
]

{ #category : 'private' }
LeJsonV4 >> schemaFor: aKey [
	"Answer the schema (class) for the given key"

	^ LeModel allSubclasses detect: 
		[ :each | each leJsonV4Name = aKey ].
]

{ #category : 'api - serializing' }
LeJsonV4 >> serialize: aLeModel on: aStream prettyPrint: aBoolean [
	"Serialise the supplied object. aLeModel is a subclass of LeModel"

	self newWriter 
		on: aStream;
		prettyPrint: aBoolean;
		nextPut: aLeModel.

]
