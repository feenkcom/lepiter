"
LeJsonV3 reads and writes Lepiter pages in Lepiter's JSON V3 format. 

LeJsonV3 has a unique instance which is normally used.  If any of the following methods are removed, changed or added the default instance should be cleaned and a new one created:

- leJsonV3AttributeMapping
- leJsonV3MappingFor:
- leFromJsonV3Dictionary:
- leJsonV3AddMappingsTo:
- leJsonV3Name

## Public API and Key Messages

- uniqueInstance 					returns the default instance
- serialize:on:prettyPrint: 	is used to write an object to the supplied stream
- deserialize: 						reads an object from the supplied stream

"
Class {
	#name : #LeJsonV3,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : 'Lepiter-Store-JSONV3'
}

{ #category : #private }
LeJsonV3 >> allClassMappingsFor: aNeoJSONMapper [ 

	LeModel allSubclassesDo: [ :leClass |
		leClass leJsonV3MappingFor: aNeoJSONMapper ].
	Date leJsonV3MappingFor: aNeoJSONMapper.
	DateAndTime leJsonV3MappingFor: aNeoJSONMapper.
	UUID leJsonV3MappingFor: aNeoJSONMapper.
	FileReference leJsonV3MappingFor: aNeoJSONMapper.

]

{ #category : #'api - serializing' }
LeJsonV3 >> deserialize: aStream [
	"Deserialise the supplied object. aLeClass is a subclass of LeModel"

	^ self newReader 
		on: aStream;
		next.

]

{ #category : #initialization }
LeJsonV3 >> newReader [ 
	| newReader |

	newReader := LeJsonV3Reader new.
	self allClassMappingsFor: newReader.
	^ newReader

]

{ #category : #initialization }
LeJsonV3 >> newWriter [ 
	| newWriter |

	newWriter := LeJsonV3Writer new.
	self allClassMappingsFor: newWriter.
	^ newWriter 
]

{ #category : #private }
LeJsonV3 >> schemaFor: aKey [
	"Answer the schema (class) for the given key"

	^ LeModel allSubclasses detect: 
		[ :each | each leJsonV3Name = aKey ].
]

{ #category : #'api - serializing' }
LeJsonV3 >> serialize: aLeModel on: aStream prettyPrint: aBoolean [
	"Serialise the supplied object. aLeModel is a subclass of LeModel"

	self newWriter 
		on: aStream;
		prettyPrint: aBoolean;
		nextPut: aLeModel.

]
