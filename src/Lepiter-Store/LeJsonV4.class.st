Class {
	#name : #LeJsonV4,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#instVars : [
		'newReader',
		'newWriter',
		'mutex'
	],
	#category : #'Lepiter-Store-JsonV4'
}

{ #category : #loading }
LeJsonV4 class >> loadFile: aFileReference [

	^ self uniqueInstance loadFile: aFileReference
]

{ #category : #private }
LeJsonV4 >> allClassMappingsFor: aNeoJSONMapper [ 

	(SystemNavigation default allImplementorsOf: #leJsonV4Name) do: [ :method |
		| jsonName |
		jsonName := method 
							gtValueWithReceiver: method methodClass soleInstance 
							possibleArguments: #().
		jsonName ifNotNil: [ method methodClass instanceSide leJsonV4MappingFor: aNeoJSONMapper ] ].

]

{ #category : #testing }
LeJsonV4 >> canSerialize: anObject [
	"Answer a boolean indicating whether the supplied class can be serialised"

	^ anObject class class includesSelector: #leJsonV4Name
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
		[ object removeKey: '__schema' ifAbsent: [ ] ].

	^ object
]

{ #category : #initialization }
LeJsonV4 >> initialize [

	super initialize.
	mutex := Mutex new.
]

{ #category : #loading }
LeJsonV4 >> loadFile: aFileReference [

	^ aFileReference asFileReference readStreamDo: [ :stream |
		self deserialize: stream ]
]

{ #category : #initialization }
LeJsonV4 >> newReader [ 
	newReader ifNil: [ mutex critical: [ | reader |
		reader := LeJsonV4Reader new.
		self allClassMappingsFor: reader.
		newReader := reader ] ].
	^ newReader copy
]

{ #category : #initialization }
LeJsonV4 >> newWriter [ 

	newWriter ifNil: [ mutex critical: [ | writer |
		writer := LeJsonV4Writer new.
		self allClassMappingsFor: writer.
		newWriter := writer ] ].
	^ newWriter copy
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

{ #category : #accessing }
LeJsonV4 >> serializePretty: aLeModel [

	^ String streamContents: [ :stream | 
		  self serialize: aLeModel on: stream prettyPrint: true ]
]
