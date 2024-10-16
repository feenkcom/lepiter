Class {
	#name : #LeLogicalDatabaseProperties,
	#superclass : #LeLocalAbstractProperties,
	#traits : 'TGtMacroFileReferenceEncoding',
	#classTraits : 'TGtMacroFileReferenceEncoding classTrait',
	#instVars : [
		'localFile',
		'properties'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLogicalDatabaseProperties class >> default [ 
	"Answer an instance of the logical DB properties from the default file.
	Create the file if necessary."
	| propertiesFile |
	
	propertiesFile := LepiterCoreDefaults logicalDatabasePropertiesFileReference.
	
	"Update an old properties file in the default location (which moved in V4).
	If the old properties file doesn't exist, no action is taken"
	LeJsonV4LogicalPropertiesUpdater updateDefault.
	
	^ self 
		forPropertiesFile: propertiesFile 
		ifAbsentUse: [ self withDefaultValues ]
]

{ #category : #accessing }
LeLogicalDatabaseProperties class >> defaultForGlamorousToolkit [
	"Answer an instance of the logical DB properties from the default file for Glamorous Toolkit.
	Create the file if necessary."
	| propertiesFile |
	
	propertiesFile := LepiterCoreDefaults defaultLocalLogicalDatabasePropertiesFileReference.
	^ self 
		forPropertiesFile: propertiesFile 
		ifAbsentUse: [ self withDefaultPrimaryDatabaseAndGlamorousDocumentation ]
]

{ #category : #accessing }
LeLogicalDatabaseProperties class >> forPropertiesFile: aPropertiesFile ifAbsentUse: anAbsentBlock [
	"Answer an instance of the logical DB properties from the default file.
	Create the file if necessary."
	| properties  |

	properties := aPropertiesFile exists ifTrue: [ 
		self new localFile: aPropertiesFile ]
	ifFalse: [ 
		aPropertiesFile parent ensureCreateDirectory.
		anAbsentBlock value localFile: aPropertiesFile; save ].
	
	^ properties
]

{ #category : #factory }
LeLogicalDatabaseProperties class >> null [
	^ LeLocalNullProperties default
]

{ #category : #accessing }
LeLogicalDatabaseProperties class >> withDefaultPrimaryDatabase [
	"Answer an instance of the logical DB properties with a default primary database.
	No file is associated with the properites."

	^ self new
		primaryDatabaseDirectory: LepiterCoreDefaults primaryDatabaseDirectory.

]

{ #category : #accessing }
LeLogicalDatabaseProperties class >> withDefaultPrimaryDatabaseAndGlamorousDocumentation [

	^ self withDefaultPrimaryDatabase
		addRegisteredDirectory: LepiterCoreDefaults defaultGtoolkitDocumentationDirectory
]

{ #category : #accessing }
LeLogicalDatabaseProperties class >> withDefaultValues [
	"Answer an instance of the logical DB properties with default values.
	No file is associated with the properites."

	^ self new
		primaryDatabaseDirectory: LepiterCoreDefaults primaryDatabaseDirectory;
		playgroundDatabaseDirectory: LepiterCoreDefaults playgroundDatabaseDirectory.

]

{ #category : #adding }
LeLogicalDatabaseProperties >> addRegisteredDirectory: aFileReference [ 
	"Add the supplied directories to the receiver's list of registered directories.
	Quietly ignore duplicates.
	This method is deprecated as lepiter databases now support multiple data stores and use a URL to identify the store type and location."
	| fileUrl |

	fileUrl := aFileReference asLepiterZnUrl.
	(self registeredDatabaseUrls includes: fileUrl) ifTrue: [ ^ self ].
	self registeredDatabaseUrls: 
		(self registeredDatabaseUrls copyWith: fileUrl)
]

{ #category : #adding }
LeLogicalDatabaseProperties >> addRegisteredUrl: aZnUrl [
	"Add the supplied directories to the receiver's list of registered directories.
	Quietly ignore duplicates."

	(self registeredDatabaseUrls includes: aZnUrl) ifTrue: [ ^ self ].
	self registeredDatabaseUrls: (self registeredDatabaseUrls copyWith: aZnUrl)
]

{ #category : #'api - testing' }
LeLogicalDatabaseProperties >> exists [
	^ self localFile isNotNil and: [ 
		self localFile asFileReference exists ]
]

{ #category : #'gt-extensions' }
LeLogicalDatabaseProperties >> gtFilePathFor: aView [
	<gtView>
	self localFile ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'File path';
		priority: 10;
		object: [ self localFile ];
		view: #gtPathFor:
]

{ #category : #'gt-extensions' }
LeLogicalDatabaseProperties >> gtJsonFor: aView [
	<gtView>
	self exists ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'JSON';
		priority: 5;
		actionButtonIcon: BrGlamorousIcons tree 
			action: [ :aButton | 
				aButton phlow spawnObject: (
					STONJSON fromString: self localFile contents) ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ (STONJSON toStringPretty: (
			STONJSON fromString: self localFile contents)) ]
]

{ #category : #'gt-extensions' }
LeLogicalDatabaseProperties >> gtPropertiesFor: aView [
	<gtView>
	properties ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Properties';
		priority: 1;
		object: [ self properties ];
		view: #gtItemsFor:
]

{ #category : #'gt-extensions' }
LeLogicalDatabaseProperties >> gtRegisteredUrlsFor: aView [

	<gtView>
	properties ifNil: [ ^ aView empty ].
	^ aView columnedList
		  title: 'URLs';
		  priority: 5;
		  items: [ 
			  Array streamContents: [ :aStream | 
					  | aUrl |
					  aStream nextPut: (aUrl := self primaryDatabaseUrl).
					  self playgroundDatabaseUrl = aUrl ifFalse: [ 
							  aStream nextPut: self playgroundDatabaseUrl ].
					  aStream nextPutAll: self registeredDatabaseUrls ] ];
		  column: 'Name' text: #yourself
]

{ #category : #testing }
LeLogicalDatabaseProperties >> hasLocalFile [

	^ localFile isNotNil
]

{ #category : #private }
LeLogicalDatabaseProperties >> integrityCheck: dictionary [
	"Check the supplied properties dictionary.
	The list of registered databases shouldn't contain duplicates."
	| registeredUrls |

	registeredUrls := dictionary at: #registeredDatabaseUrls ifAbsent: [ #() ].
	registeredUrls asBag doWithOccurrences:
		[ :url :count | count > 1 ifTrue: 
			[ self error: 'Duplicate Registered Database: ', url printString ] ].
	(registeredUrls includes: (dictionary at: #primaryDatabaseUrl ifAbsent: [])) ifTrue: 
		[ self error: 'Primary Database is also Registered' ].
	(registeredUrls includes: (dictionary at: #playgroundDatabaseUrl ifAbsent: [])) ifTrue: 
		[ self error: 'Playground Database is also Registered' ].
]

{ #category : #'api - testing' }
LeLogicalDatabaseProperties >> isNull [

	^ false
]

{ #category : #'api - storage' }
LeLogicalDatabaseProperties >> load [
	| dictionary |

	(localFile isNotNil and: [ localFile exists ]) ifFalse: [ ^ Dictionary new ].
	dictionary := localFile
		readStreamEncoded: #utf8 
		do: [ :aStream | 
			(NeoJSONReader on: aStream)
				mapClass: GtStringContentDictionary;
				next ].
	self migrateStonPropertiesIn: dictionary.
	self migrateDirectoryStringsIn: dictionary.
	self integrityCheck: dictionary.
	properties := dictionary.
	^ dictionary
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> localFile [
	<return: #FileReference>

	^ localFile
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> localFile: aFileReference [

	localFile := aFileReference
]

{ #category : #accessing }
LeLogicalDatabaseProperties >> logicalDatabase [ 
	"Answer a logical database with the receiver's properties"

	^ LeLogicalDatabase withProperties: self
]

{ #category : #private }
LeLogicalDatabaseProperties >> migrateDirectoryStringsIn: dictionary [
	"Migrate the old string format to URLs"
	| changed |

	changed := false.
	(dictionary includesKey: #primaryDatabaseDirectory) ifTrue:
		[ dictionary at: #primaryDatabaseUrl put: (dictionary at: #primaryDatabaseDirectory).
		dictionary removeKey: #primaryDatabaseDirectory.
		changed := true ].
	(dictionary includesKey: #playgroundDatabaseDirectory) ifTrue:
		[ dictionary at: #playgroundDatabaseUrl put: (dictionary at: #playgroundDatabaseDirectory).
		dictionary removeKey: #playgroundDatabaseDirectory.
		changed := true ].
	(dictionary includesKey: #registeredDatabaseDirectories) ifTrue:
		[ dictionary at: #registeredDatabaseUrls put: (dictionary at: #registeredDatabaseDirectories).
		dictionary removeKey: #registeredDatabaseDirectories.
		changed := true ].
	dictionary associationsDo: [ :assoc |
		(assoc value isString and: [ (assoc value indexOfSubCollection: '://') = 0 ]) ifTrue:
			[ assoc value: (self urlFromDirectoryString: assoc value).
			changed := true ].
		assoc value isArray ifTrue: 
			[ | collection |
			collection := assoc value.
			1 to: collection size do: [ :i |
				| value |
				value := collection at: i.
				(value indexOfSubCollection: '://') = 0 ifTrue:
					[ collection at: i put: (self urlFromDirectoryString: value) ].
				changed := true ] ] ].
	changed ifTrue: [ self saveDictionary: dictionary ].
]

{ #category : #private }
LeLogicalDatabaseProperties >> migrateStonCollection: association [
	| oldString |

	oldString := association value.
	((oldString includesSubstring: 'FileLocator{') or:
	[ oldString includesSubstring: 'FileReference{' ]) ifFalse: 
		[ ^ false ].

	association value: ((STON fromString: oldString) collect: [ :each |
		self encodeFileReferenceToString: each ]).
	^ true
]

{ #category : #private }
LeLogicalDatabaseProperties >> migrateStonPropertiesIn: dictionary [
	"Migrate the old STON encoded file references to the new string format"
	| changed |

	changed := false.
	dictionary associationsDo: [ :assoc |
		(assoc value isCollection and: [ assoc value isNotEmpty ]) ifTrue: [
			changed := changed |  (assoc value first = $[ ifFalse: 
					[ self migrateStonString: assoc ]
				ifTrue:
					[ self migrateStonCollection: assoc ]) ] ].
	changed ifTrue: [ self saveDictionary: dictionary ].
]

{ #category : #private }
LeLogicalDatabaseProperties >> migrateStonString: association [ 

	^ ((association value beginsWith: 'FileLocator{') or: 
		[ association value beginsWith: 'FileReference{' ]) ifTrue: 
			[ association value: (self encodeFileReferenceToString: (STON fromString: association value)).
			true ]
		ifFalse:
			[ false ].

]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> playgroundDatabase [ 
	| url |

	url := self playgroundDatabaseUrl.
	self primaryDatabaseUrl = url ifTrue: 
		[ ^ self primaryDatabase ].
	^ (LeDatabaseStore loaderFor: url) current 
		loadAndMonitorFrom: url
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> playgroundDatabaseDirectory [
	"This method is deprecated as lepiter databases now support multiple data stores and use a URL to identify the store type and location."
	| url |

	url := self playgroundDatabaseUrl.
	self assert: url isFile.
	^ self decodeFileReferenceString: url path
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> playgroundDatabaseDirectory: aFileReference [
	"This method is deprecated as lepiter databases now support multiple data stores and use a URL to identify the store type and location."

	^ self updateProperty: 'playgroundDatabaseUrl'
		value: aFileReference asLepiterZnUrl asString
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> playgroundDatabaseUrl [
	<return: #ZnUrl>

	^ (self properties 
		at: 'playgroundDatabaseUrl'
		ifAbsent: [ self properties at: 'primaryDatabaseUrl' ]) asZnUrl.
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> playgroundDatabaseUrl: aZnUrl [

	^ self updateProperty: 'playgroundDatabaseUrl'
		value: aZnUrl printString
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabase [ 
	| url |

	url := self primaryDatabaseUrl.
	^ (LeDatabaseStore loaderFor: url) current 
		loadAndMonitorFrom: url
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabaseDirectory [
	"This method is deprecated as lepiter databases now support multiple data stores and use a URL to identify the store type and location."
	| url |

	url := self primaryDatabaseUrl.
	self assert: url isFile.
	^ self decodeFileReferenceString: url path
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabaseDirectory: aFileReference [

	^ self updateProperty: 'primaryDatabaseUrl'
		value: aFileReference asLepiterZnUrl asString
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabaseUrl [
	<return: #ZnUrl>

	^ (self properties at: 'primaryDatabaseUrl') asZnUrl
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabaseUrl: aZnUrl [

	^ self updateProperty: 'primaryDatabaseUrl'
		value: aZnUrl printString
]

{ #category : #'private - accessing' }
LeLogicalDatabaseProperties >> properties [
	<return: #Dictionary>
	^ properties ifNil: [ properties := self load ]
]

{ #category : #'api - adding / removing' }
LeLogicalDatabaseProperties >> propertyAt: propertyName ifPresent: aPresentBlock ifAbsent: anAbsentBlock [
	^ self properties 
		at: propertyName 
		ifPresent: aPresentBlock
		ifAbsent: anAbsentBlock.
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> registeredDatabaseDirectories [
	"This method is deprecated as lepiter databases now support multiple data stores and use a URL to identify the store type and location."

	^ self registeredDatabaseUrls collect: [ :each | 
		self assert: each isFile.
		self decodeFileReferenceString: each path ]
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> registeredDatabaseDirectories: aCollection [

	^ self updateProperty: 'registeredDatabaseUrls'
		value: (aCollection collect: [ :each | each asLepiterZnUrl asString ])
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> registeredDatabaseUrls [

	^ (self properties at: 'registeredDatabaseUrls' ifAbsent: [ #() ]) collect: #asZnUrl
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> registeredDatabaseUrls: aCollectionOfZnUrl [

	^ self updateProperty: 'registeredDatabaseUrls' value: (aCollectionOfZnUrl collect: #asString)
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> registeredDatabases [

	^ self registeredDatabaseUrls collect: [ :each |
		(LeDatabaseStore loaderFor: each) current 
			loadAndMonitorFrom: each ]
]

{ #category : #'api - storage' }
LeLogicalDatabaseProperties >> save [

	self saveDictionary: properties
]

{ #category : #'api - storage' }
LeLogicalDatabaseProperties >> saveDictionary: dictionary [
	| aFile |

	localFile ifNil: [ ^ self ].
	aFile := localFile asFileReference.
	aFile ensureDelete.
	aFile 
		writeStreamEncoded: #utf8 
		do: [ :aStream | 
			STONJSON put: dictionary onStreamPretty: (ZnNewLineWriterStream on: aStream) ]
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> schemaVersion [

	^ self properties at: #schema ifAbsent: [ '3.0' ]
]

{ #category : #'api - adding / removing' }
LeLogicalDatabaseProperties >> updateProperty: propertyName value: aString [
	| aCurrentValue |
	aCurrentValue := self properties 
		at: propertyName 
		ifAbsent: [nil].
	aCurrentValue = aString ifTrue: [ ^ self ].
	self properties 
		at: propertyName 
		put: aString.
	self save.
]

{ #category : #private }
LeLogicalDatabaseProperties >> urlFromDirectoryString: aString [ 

	^ (self decodeFileReferenceString: aString) asLepiterZnUrl asString
]
