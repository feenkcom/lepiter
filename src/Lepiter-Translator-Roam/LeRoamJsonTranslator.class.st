"
I read and write JSON files (stream in general) using the Roam format that include {{gtClass:LeDatabase}}.
I use {{gtClass:LeRoamJsonPurificator}} to properly initialize {{gtClass:LeDatabase}} structures for JSON files.
## Reading
{{gtExample:LeRoamJsonExamples>>#databaseWithOnePageNoEditValues_Read}}
## Writing
{{gtExample:LeRoamJsonExamples>>#databaseWithOnePageNoEditValues_Write}}

"
Class {
	#name : #LeRoamJsonTranslator,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'Lepiter-Translator-Roam-Core'
}

{ #category : #'private - asserting' }
LeRoamJsonTranslator >> assertReadFileReference: aFileReference [
	self 
		assert: [ aFileReference isNotNil ] 
		description: [ 'File reference must be non-nil' ].
	self 
		assert: [ aFileReference exists ] 
		description: [ 'File reference must exist' ].
]

{ #category : #'private - asserting' }
LeRoamJsonTranslator >> assertStream: aStream [
	self 
		assert: [ aStream isNotNil ] 
		description: [ 'Read stream must be non-nil' ].
]

{ #category : #'private - asserting' }
LeRoamJsonTranslator >> assertWriteFileReference: aFileReference [
	self 
		assert: [ aFileReference isNotNil ] 
		description: [ 'File reference must be non-nil' ].
	aFileReference exists ifFalse: [ ^ self ].
	self 
		assert: [ aFileReference isFile ] 
		description: [ 'File reference must be a regular file' ].
	self 
		assert: [ aFileReference isWritable ] 
		description: [ 'File reference must be a writable file' ].
]

{ #category : #'mapping - model' }
LeRoamJsonTranslator >> blockMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: LeTextSnippet do: [ :mapping |
			(mapping mapAccessor: #roamJsonStringContent to: #string). 
			(mapping mapAccessor: #heading to: #heading).
			(mapping mapAccessor: #createTime to: #'create-time') valueSchema: LeTime.
			(mapping mapAccessor: #createEmail to: #'create-email') valueSchema: LeEmail.
			(mapping mapAccessor: #editTime to: #'edit-time') valueSchema: LeTime.
			(mapping mapAccessor: #editEmail to: #'edit-email') valueSchema: LeEmail.
			(mapping mapAccessor: #uid to: #uid) valueSchema: LeUID.
			(mapping mapAccessor: #children to: #children) valueSchema: LeSnippets. ].
	self
		timeMappingFor: aNeoJSONMapper;
		emailMappingFor: aNeoJSONMapper;
		uidMappingFor: aNeoJSONMapper
]

{ #category : #'mapping - model' }
LeRoamJsonTranslator >> blocksMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: LeSnippets customDo: [ :mapping |
			mapping 
				reader: [ :jsonReader | 
					| aCollection |
					aCollection := jsonReader listClass streamContents: [ :stream |
						jsonReader parseListDo: [ 
							| element |
							element := jsonReader nextAs: LeTextSnippet.
							stream nextPut: element ]
						 ].
					LeSnippets new items: aCollection ];
				writer: [ :jsonWriter :parts | 
					jsonWriter writeListStreamingDo: [ :listWriter |
						parts do: [ :each | listWriter writeElement: each as: LeTextSnippet ] ] ] ].
	self blockMappingFor: aNeoJSONMapper.
]

{ #category : #'api - writing' }
LeRoamJsonTranslator >> database: aLeDatabase toFile: aFileReference [
	self assertWriteFileReference: aFileReference.
	aFileReference ensureDelete.
	^ aFileReference writeStreamDo: [ :aStream | 
			self database: aLeDatabase toStream: aStream ]
]

{ #category : #'api - writing' }
LeRoamJsonTranslator >> database: aLeDatabase toStream: aStream [
	^ self
		write: aLeDatabase
		stream: aStream 
		as: LeDatabase
]

{ #category : #'api - reading' }
LeRoamJsonTranslator >> databaseFromFile: aFileReference [
	self assertReadFileReference: aFileReference.
	^ aFileReference 
		readStreamEncoded: #utf8 
		do: [ :aStream | 
			(self databaseFromStream: aStream)
				filename: aFileReference;
				yourself ]
]

{ #category : #'api - reading' }
LeRoamJsonTranslator >> databaseFromStream: aStream [
	| aDatabase |
	aDatabase := self
		readStream: aStream 
		as: LeDatabase.
	LeRoamJsonPurificator new
		database: aDatabase;
		purify.
	^ aDatabase
]

{ #category : #'api - reading' }
LeRoamJsonTranslator >> databaseFromString: aString [
	^ self databaseFromStream: aString readStream
]

{ #category : #'mapping - model' }
LeRoamJsonTranslator >> databaseMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: LeDatabase customDo: [ :mapping |
			mapping 
				reader: [ :jsonReader | 
					| aCollection |
					aCollection := jsonReader listClass streamContents: [ :stream |
						jsonReader parseListDo: [ 
							| element |
							element := jsonReader nextAs: LePage.
							stream nextPut: element ]
						 ].
					LeDatabase new setPages: aCollection ];
				writer: [ :jsonWriter :pages | 
					jsonWriter writeListStreamingDo: [ :listWriter |
						pages do: [ :each | listWriter writeElement: each as: LePage ] ] ] ].
	self pageMappingFor: aNeoJSONMapper.
]

{ #category : #'mapping - basic' }
LeRoamJsonTranslator >> dateAndTimeMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: DateAndTime customDo: [ :mapping |
			mapping 
				decoder: [ :integer | 
					| unixTimeStamp milliSeconds |
					unixTimeStamp := integer // 1000.
					milliSeconds := integer \\ 1000.
					(DateAndTime fromUnixTime: unixTimeStamp) + milliSeconds milliSeconds ];
				encoder: [ :dateAndTime | 
					| unixTimeStamp milliSeconds |
					unixTimeStamp := dateAndTime asUnixTime * 1000.
					milliSeconds := dateAndTime nanoSecond // 1000000.
					unixTimeStamp + milliSeconds ] ].
]

{ #category : #'mapping - model' }
LeRoamJsonTranslator >> emailMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: LeEmail customDo: [ :mapping |
	      mapping 
				reader: [ :jsonReader |
					LeEmail new email: jsonReader next. ];
				writer: [ :jsonWriter :anEmail |
					jsonWriter nextPut: anEmail email ] ].
]

{ #category : #'api - writing' }
LeRoamJsonTranslator >> page: aLePage toFile: aFileReference [
	self assertWriteFileReference: aFileReference.
	aFileReference ensureDelete.
	^ aFileReference writeStreamDo: [ :aStream | 
			self page: aLePage toStream: (ZnNewLineWriterStream on: aStream) ]
]

{ #category : #'api - writing' }
LeRoamJsonTranslator >> page: aLePage toStream: aStream [
	^ self
		writePage: aLePage
		stream: aStream 
		as: LePage
]

{ #category : #'api - reading' }
LeRoamJsonTranslator >> pageFromFile: aFileReference [
	self assertReadFileReference: aFileReference.
	^ aFileReference 
		readStreamEncoded: #utf8 
		do: [ :aStream | 
			self pageFromStream: aStream ]
]

{ #category : #'api - reading' }
LeRoamJsonTranslator >> pageFromStream: aStream [

	^ self
		readStream: aStream 
		as: LePage.

]

{ #category : #'mapping - model' }
LeRoamJsonTranslator >> pageMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: LePage do: [ :mapping |
			(mapping mapAccessor: #title to: #title).
			"(mapping mapAccessor: #uid to: #uid) valueSchema: LeUID."
			(mapping mapAccessor: #createTime to: #'create-time') valueSchema: LeTime.
			(mapping mapAccessor: #createEmail to: #'create-email') valueSchema: LeEmail.
			(mapping mapAccessor: #editTime to: #'edit-time') valueSchema: LeTime.
			(mapping mapAccessor: #editEmail to: #'edit-email') valueSchema: LeEmail.
			(mapping mapAccessor: #children to: #children) valueSchema: LeSnippets. ].
	self
		timeMappingFor: aNeoJSONMapper;
		emailMappingFor: aNeoJSONMapper;
		blocksMappingFor: aNeoJSONMapper
]

{ #category : #'private - reading and writing' }
LeRoamJsonTranslator >> read: aReadStream as: jsonSchema withMapping: messageSymbol [
	"Read a JSON string using the JSON schema and return an object.
	The messageSymbol variable is a message to configure mapping between JSON and objects."
	<return: #Object>
	| reader |
	reader := (NeoJSONReader on: aReadStream).
	reader listClass: OrderedCollection.
	self perform: messageSymbol with: reader.
	^ reader nextAs: jsonSchema
]

{ #category : #'api - reading' }
LeRoamJsonTranslator >> readStream: aStream as: jsonSchema [
	self assertStream: aStream.
	^ self
		read: aStream 
		as: jsonSchema 
		withMapping: #databaseMappingFor:
]

{ #category : #'private - reading and writing' }
LeRoamJsonTranslator >> readString: aString as: jsonSchema withMapping: messageSymbol [
	"Read a JSON string using the JSON schema and return an object.
	The messageSymbol variable is a message to configure mapping between JSON and objects."
	<return: #Object>
	^ aString readStreamDo: [ :aReadStream |
		self read: aReadStream as: jsonSchema withMapping: messageSymbol ]

]

{ #category : #'mapping - model' }
LeRoamJsonTranslator >> timeMappingFor: aNeoJSONMapper [
	aNeoJSONMapper
		for: LeTime customDo: [ :mapping |
	      mapping 
				reader: [ :jsonReader |
					LeTime new time: (jsonReader nextAs: DateAndTime). ];
				writer: [ :jsonWriter :aTime |
					jsonWriter nextPut: aTime time as: DateAndTime ] ].
	self dateAndTimeMappingFor: aNeoJSONMapper.
]

{ #category : #'mapping - model' }
LeRoamJsonTranslator >> uidMappingFor: neoJSONMapper [
	"Reading a Roam block UID as a string36 UUID representation works fine (the same UUID will always be generated).
	Whether Roam can take a longer UID back is untested (UUID asString36 is about 25 characters long)"

	neoJSONMapper
		for: LeUID customDo: [ :mapping |
	      mapping 
				reader: [ :jsonReader |
					| currentUid migratedUid |
					currentUid := jsonReader next.
					migratedUid := LeJsonV4000Updater cleanUidString: currentUid.
					LeUID new uidString: migratedUid ];
				writer: [ :jsonWriter :uid |
					jsonWriter nextPut: uid uidString ] ].
]

{ #category : #'private - reading and writing' }
LeRoamJsonTranslator >> write: anObject as: schema mappedTo: mappingSymbol prettyPrint: aBoolean [
	"Return a JSON string representation of anOobject."
	<return: #String>
	^ String streamContents: [ :stream | | writer |
		writer := (NeoJSONWriter on: stream)
			newLine: Character cr asString;
			prettyPrint: aBoolean;
			yourself.
		self perform: mappingSymbol with: writer.
		writer nextPut: anObject as: schema ].
]

{ #category : #'private - reading and writing' }
LeRoamJsonTranslator >> write: anObject as: schema withMapping: mappingSymbol [
	"Return a JSON string representation of anOobject."
	^ self write: anObject as: schema mappedTo: mappingSymbol prettyPrint: true
]

{ #category : #'private - reading and writing' }
LeRoamJsonTranslator >> write: anObject mappedTo: mappingSymbol prettyPrint: aBoolean [
	"Return a JSON string representation of anobject."
	<return: #String>
	^ String streamContents: [ :stream | | writer |
		writer := (NeoJSONWriter on: stream)
			newLine: Character cr asString;
			prettyPrint: aBoolean;
			yourself.
		self perform: mappingSymbol with: writer.
		writer nextPut: anObject ].
]

{ #category : #'api - writing' }
LeRoamJsonTranslator >> write: aLeDatabase stream: aStream as: jsonSchema [
	self assertStream: aStream.
	^ self
		write: aLeDatabase
		stream: aStream 
		as: jsonSchema 
		withMapping: #databaseMappingFor:
		prettyPrint: true.
]

{ #category : #'private - reading and writing' }
LeRoamJsonTranslator >> write: anObject stream: aWriteStream as: schema withMapping: mappingSymbol prettyPrint: aBoolean [
	"Return a JSON string representation of anOobject."
	| writer |

	writer := (NeoJSONWriter on: aWriteStream)
			newLine: Character cr asString;
			prettyPrint: aBoolean;
			yourself.
	self perform: mappingSymbol with: writer.
	writer nextPut: anObject as: schema.
]

{ #category : #'api - writing' }
LeRoamJsonTranslator >> writePage: aLePage stream: aStream as: jsonSchema [
	self assertStream: aStream.
	^ self
		write: aLePage
		stream: aStream 
		as: jsonSchema 
		withMapping: #pageMappingFor:
		prettyPrint: true.
]
