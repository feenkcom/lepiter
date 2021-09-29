Class {
	#name : #LeLogicalDatabaseProperties,
	#superclass : #LeLocalAbstractProperties,
	#traits : 'TGtMacroFileReferenceEncoding',
	#classTraits : 'TGtMacroFileReferenceEncoding classTrait',
	#instVars : [
		'localFile',
		'properties'
	],
	#category : 'Lepiter-Store-LocalJSON-Store'
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
	Quietly ignore duplicates."

	((self registeredDatabaseDirectories collect: #resolve) includes: aFileReference asFileReference resolve) ifTrue: [ ^ self ].
	self registeredDatabaseDirectories: (self registeredDatabaseDirectories copyWith: 
		(self encodeFileReferenceToString: aFileReference))
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
		title: 'File Path';
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
LeLogicalDatabaseProperties >> gtRegisteredDirectoriesFor: aView [

	<gtView>
	properties ifNil: [ ^ aView empty ].
	^ aView columnedList
		  title: 'Directories';
		  priority: 5;
		  items: [ 
			  Array streamContents: [ :aStream | 
					  | aDir |
					  aStream nextPut: (aDir := self primaryDatabaseDirectory).
					  self playgroundDatabaseDirectory = aDir ifFalse: [ 
							  aStream nextPut: self playgroundDatabaseDirectory ].
					  aStream nextPutAll: self registeredDatabaseDirectories ] ];
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
	| registeredDirectories |

	registeredDirectories := (dictionary at: #registeredDatabaseDirectories ifAbsent: [ #() ])
		collect: [ :each | (self decodeFileReferenceString: each) resolve ].
	registeredDirectories asBag doWithOccurrences:
		[ :directory :count | count > 1 ifTrue: 
			[ self error: 'Duplicate Registered Database: ', directory fullName ] ].
	(registeredDirectories includes: (dictionary at: #primaryDatabaseDirectory ifAbsent: [])) ifTrue: 
		[ self error: 'Primary Database is also Registered' ].
	(registeredDirectories includes: (dictionary at: #playgroundDatabaseDirectory ifAbsent: [])) ifTrue: 
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
		do: [ :aStream | STONJSON fromStream: aStream ].
	self migrateStonPropertiesIn: dictionary.
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
		changed := changed | (assoc value first = $[ ifFalse: 
				[ self migrateStonString: assoc ]
			ifTrue:
				[ self migrateStonCollection: assoc ]) ].
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

	self primaryDatabaseDirectory = self playgroundDatabaseDirectory ifTrue: 
		[ ^ self primaryDatabase ].
	^ LeLocalStoreLoad current loadAndMonitorFrom: self playgroundDatabaseDirectory
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> playgroundDatabaseDirectory [

	^ self decodeFileReferenceString: (self properties 
		at: #playgroundDatabaseDirectory ifAbsent: [ self properties at: #primaryDatabaseDirectory ])
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> playgroundDatabaseDirectory: aFileReference [

	^ self updateProperty: #playgroundDatabaseDirectory 
		value: (self encodeFileReferenceToString: aFileReference)
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabase [ 

	^ LeLocalStoreLoad current loadAndMonitorFrom: self primaryDatabaseDirectory
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabaseDirectory [

	^ self decodeFileReferenceString: (self properties at: #primaryDatabaseDirectory)
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> primaryDatabaseDirectory: aFileReference [

	^ self updateProperty: #primaryDatabaseDirectory 
		value: (self encodeFileReferenceToString: aFileReference)
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

	^ (self properties at: #registeredDatabaseDirectories ifAbsent: [ #() ])
		collect: [ :each | self decodeFileReferenceString: each ]
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> registeredDatabaseDirectories: aCollection [

	^ self updateProperty: #registeredDatabaseDirectories 
		value: (aCollection collect: [ :each | self encodeFileReferenceToString: each ])
]

{ #category : #'api - accessing' }
LeLogicalDatabaseProperties >> registeredDatabases [

	^ self registeredDatabaseDirectories collect: [ :each |
		LeLocalStoreLoad current loadAndMonitorFrom: each ]
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
