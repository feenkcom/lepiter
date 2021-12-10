"
{{gtClass:LeLocalStore}} is an abstract class providing a persistent, automatically updated store for a Lepiter database.

{{gtClass:LeLocalStore}} stores the database as a file per {{gtClass:LePage}} in its localRoot.  The file name and format are defined by subclasses.

As Lepiter is currently memory resident, databases may be converted from one format to another by loading the old format, see e.g. {{gtClass:name=LeLocalStoreLoad}}, and storing in the new format, e.g. {{gtClass:name=LeLocalStoreExport}}.

A Lepiter database may be loaded from an existing store with {{gtMethod:name=LeLocalStoreLoad>>#loadAndMonitorFrom:}}.  Using #loadAndMonitorFrom: will set up a {{gtClass:LeLocalStoreMonitor}}, which will automatically save changes to the database as they are made.

The store is responsible for ensuring that an attachments directory exists in the database.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	database:		<LeDatabase>
	localRoot:	<FileReference>


### Implementation Points

"
Class {
	#name : #LeLocalStore,
	#superclass : #Object,
	#instVars : [
		'localRoot',
		'storage',
		'database',
		'dbProperties',
		'attachmentsDirectory'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #'instance creation' }
LeLocalStore class >> current [
	"Answer an instance of the receiver with the current storage format"

	^ self forJsonV4
]

{ #category : #accessing }
LeLocalStore class >> currentStorageClass [

	^ LeLocalJsonV4Storage 
]

{ #category : #'instance creation' }
LeLocalStore class >> forJsonV3 [
	"Answer an instance of the receiver with JSON V3 storage format"

	^ self new storage: LeLocalJsonV3Storage new
]

{ #category : #'instance creation' }
LeLocalStore class >> forJsonV4 [
	"Answer an instance of the receiver with JSON V4 storage format"

	^ self new storage: LeLocalJsonV4Storage new
]

{ #category : #accessing }
LeLocalStore >> attachmentsDirectory [
	^ attachmentsDirectory
]

{ #category : #accessing }
LeLocalStore >> attachmentsDirectory: anObject [
	attachmentsDirectory := anObject
]

{ #category : #accessing }
LeLocalStore >> database [
	^ database
]

{ #category : #accessing }
LeLocalStore >> database: anObject [
	database := anObject
]

{ #category : #'accessing - db properties' }
LeLocalStore >> databaseName [
	<return: #String or: nil>

	^ self dbProperties at: #databaseName 
		ifPresent: [ :anArray | anArray ]
		ifAbsent: [ self databaseNameFromLocalRoot ]
]

{ #category : #'accessing - db properties' }
LeLocalStore >> databaseName: aString [
	"Store the database name"

	aString ifNil: [ 
		self dbProperties removeKey: #databaseName ifAbsent: [ ].
		^ self savePropertiesDictionary: dbProperties ].
	self updateProperty: #databaseName value: aString asString 
]

{ #category : #'accessing - db properties' }
LeLocalStore >> databaseNameFromLocalRoot [
	<return: #String>

	| theSegments reversedSegments usedSegments |
	theSegments := self localRoot asFileReference asAbsolute asPath segments.
	
	reversedSegments := Array new: theSegments size streamContents: [ :aStream | 
		| isSkip |
		isSkip := false.
		theSegments reverseWithIndexDo: [ :aString :anIndex |
			(aString = '..')
				ifFalse: [ isSkip 
					ifTrue: [ isSkip := false ]
					ifFalse: [ aStream nextPut: aString ] ]
				ifTrue: [ isSkip := true ] ] ].

	usedSegments := reversedSegments reversed last: (3 min: reversedSegments size).

	^ String streamContents: [ :aStream | 
		usedSegments 
			do: [ :eachSegment | aStream nextPutAll: eachSegment asString ]
			separatedBy: [ aStream nextPut: DiskStore delimiter ] ]
]

{ #category : #accessing }
LeLocalStore >> dbProperties [

	^ dbProperties ifNil: 
		[ dbProperties := self loadPropertiesDictionary.
		dbProperties
			at: #schema
			ifAbsent: [ self dbSchema: 'V3' ].
		dbProperties
			at: #uuid 
			ifAbsent: 
				[ dbProperties at: #uuid put: UUID new asString.
				self savePropertiesDictionary: dbProperties ].
		dbProperties ]
]

{ #category : #accessing }
LeLocalStore >> dbPropertiesFile [
	^ localRoot / self propertiesBasename
]

{ #category : #accessing }
LeLocalStore >> dbSchema [

	^ LeDbVersion fromString: (self dbProperties at: #schema)
]

{ #category : #'private - accessing' }
LeLocalStore >> dbSchema: aLeDbVersion [ 


	self dbProperties at: #schema put: aLeDbVersion asString.
	self savePropertiesDictionary: dbProperties
]

{ #category : #accessing }
LeLocalStore >> explicitLinksFileReference [
	^ self storage explicitLinksFileOrNilIn: self localRoot
]

{ #category : #'private - db properties' }
LeLocalStore >> fileReferenceFrom: aString [
	"Answer a FileReference or FileLocator from the supplied string.
	FileLocator origins + 'dbParentDirectory' are available as formatted strings, e.g.
		{home}/lepiter
	is the equivalent of
		FileLocator home / 'lepiter'"
	| namedDirectories regex name path |

	namedDirectories := (FileLocator supportedOrigins collect: [ :origin | 
		origin -> (FileLocator origin: origin) ]) asDictionary.
	namedDirectories at: #dbParentDirectory put: localRoot parent.
	regex := '\{([a-zA-Z]+)\}(.*)' asRegex.
	^ (regex matches: aString) ifTrue: 
		[ name := regex subexpression: 2.
		path := regex subexpression: 3.
		namedDirectories at: name
			ifPresent: [ :locator | locator resolve: path allButFirst ]
			ifAbsent: [ self error: 'Unknown directory: ', name printString ] ]
	ifFalse:
	 	[ aString asFileReference ].
]

{ #category : #'private - db properties' }
LeLocalStore >> fileReferenceString: aFileReferenceStringOrNil [
	"Answer the string form of the supplied reference"

	aFileReferenceStringOrNil ifNil: [ ^ nil ].
	^ aFileReferenceStringOrNil ifNotNil: 
			[ aFileReferenceStringOrNil isString ifTrue:
				[ aFileReferenceStringOrNil ]
			ifFalse: [ aFileReferenceStringOrNil class = FileLocator
				ifTrue: [ aFileReferenceStringOrNil asString ]
				ifFalse: [ String streamContents: [ :stream | 
						aFileReferenceStringOrNil fileSystem 
							printPath: aFileReferenceStringOrNil path 
							on: stream ] ] ] ]
]

{ #category : #ui }
LeLocalStore >> gtNameMappingFor: aView [
	"Provide a page title -> filename view"
	<gtView>

	database ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Files';
		priority: 10;
		items: [ (database pages sorted: [ :a :b | a title < b title ])
			collect: [ :page | page title -> (self pageFileReference: page) ] ];
		column: 'Title' text: [ :each | each key ];
		column: 'File' text: [ :each | each value basename ];
		send: [ :each | each value ]
]

{ #category : #ui }
LeLocalStore >> gtPropertiesFor: aView [
	"Provide a simple view of the current properties"
	<gtView>

	^ aView forward 
		title: 'Properties';
		priority: 15;
		object: [ self dbProperties ];
		view: #gtItemsFor:
]

{ #category : #'private - db properties' }
LeLocalStore >> loadDatabasePropertiesIn: aDatabase [
	"Load the lepiter.properties file and update the database"

	self dbProperties 
		at: #userEmail 
		ifPresent: [ :email | database userEmail: email ].
]

{ #category : #'private - db properties' }
LeLocalStore >> loadPropertiesDictionary [
	"Answer the leptier.properties file contents"
	| propertiesFile |

	propertiesFile := localRoot / self propertiesBasename.
	propertiesFile exists ifFalse: [ ^ Dictionary new ].
	^ propertiesFile readStreamDo: [ :stream |
		STONJSON fromStream: stream ].

]

{ #category : #accessing }
LeLocalStore >> localRoot [
	^ localRoot
]

{ #category : #accessing }
LeLocalStore >> localRoot: aFileReference [
	"Set the localRoot for the storage"

	localRoot := aFileReference.
	attachmentsDirectory := localRoot / 'attachments'.
]

{ #category : #accessing }
LeLocalStore >> pageFileReference: aLePage [

	^ localRoot / (self pageFilename: aLePage)
]

{ #category : #accessing }
LeLocalStore >> pageFilename: aLePage [

	^ storage pageFilename: aLePage
]

{ #category : #accessing }
LeLocalStore >> pageFilenameForId: aLePage [

	^ storage pageFilenameForUid: aLePage
]

{ #category : #'accessing - db properties' }
LeLocalStore >> preloadScript [
	<return: #FileReference or: nil>

	^ self dbProperties at: #preloadScript 
		ifPresent: [ :aString | self fileReferenceFrom: aString ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LeLocalStore >> preloadScript: aFileReferenceOrNil [

	self 
		updateProperty: #preloadScript
		value: (self fileReferenceString: aFileReferenceOrNil)
]

{ #category : #private }
LeLocalStore >> primitiveReload [
	"Reload the receiver.
	Flush any data that may have changed on-disk since the last (re)load."

	dbProperties := nil.
]

{ #category : #accessing }
LeLocalStore >> propertiesBasename [
	"Answer the basename of the receiver's database properties file"

	^ LepiterCoreDefaults databasePropertiesBasename
]

{ #category : #'accessing - db properties' }
LeLocalStore >> propertyAt: aSymbol [
	<return: #String or: #Dictionary>

	^ self dbProperties at: aSymbol
]

{ #category : #'accessing - db properties' }
LeLocalStore >> propertyAt: aSymbol ifAbsent: absentBlock [
	<return: #String or: #Dictionary>

	^ self dbProperties at: aSymbol ifAbsent: absentBlock
]

{ #category : #'accessing - db properties' }
LeLocalStore >> propertyAt: aSymbol ifPresent: presentBlock ifAbsent: absentBlock [

	^ self dbProperties 
		at: aSymbol 
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #loading }
LeLocalStore >> reloadExplicitLinks: aLeExplicitLinks [
	"Answer the explicit links as they exists in the store.
	This is for testing purposes."

	^ storage loadFromFile: localRoot / ((self pageFilename: aLeExplicitLinks), '.links')

]

{ #category : #loading }
LeLocalStore >> reloadPage: aLePage [
	"Answer the page as it exists in the store.
	This is for testing purposes."

	^ storage loadFromFile: localRoot / (self pageFilename: aLePage)

]

{ #category : #accessing }
LeLocalStore >> resolveDbFile: aString [
	"Resolve the supplied relative path reference against the receiver's database"

	^ localRoot / aString
]

{ #category : #private }
LeLocalStore >> savePageNow: aPage [
	"Write the supplied page back to the local store"
	
	(aPage isKindOf: LeExplicitLinks)
		ifTrue: [ storage saveExplicitLinksAsPage: aPage in: localRoot ]
		ifFalse: [ storage savePage: aPage in: localRoot ]
]

{ #category : #'accessing - db properties' }
LeLocalStore >> savePersonalInformation [
	<return: #Boolean>

	^ self dbProperties at: #savePersonalInformation 
		ifPresent: [ :aBoolean | aBoolean ]
		ifAbsent: [ false ]
]

{ #category : #'accessing - db properties' }
LeLocalStore >> savePersonalInformation: aBooleanOrNil [
	"Update the flag on whether to store personal information in the database.
	nil = default, which is false (see #savePersonalInformaation)"

	self updateProperty: #savePersonalInformation value: aBooleanOrNil 
]

{ #category : #'private - db properties' }
LeLocalStore >> savePropertiesDictionary: properties [
	"Save the lepiter.properties file contents"
	| propertiesFile |

	propertiesFile := (localRoot / self propertiesBasename) resolve.
	propertiesFile ensureDelete.
	^ propertiesFile writeStreamDo: [ :stream |
		STONJSON put: properties onStreamPretty: (ZnNewLineWriterStream on: stream) ].

]

{ #category : #accessing }
LeLocalStore >> storage [
	^ storage
]

{ #category : #accessing }
LeLocalStore >> storage: anObject [
	storage := anObject
]

{ #category : #'accessing - db properties' }
LeLocalStore >> tableOfContentsPageID [
	"Answer the page UUID for the Table Of Contents, or nil if not set"

	^ self dbProperties at: #tableOfContents 
		ifPresent: [ :uuidString | UUID fromString36: uuidString ]
		ifAbsent: [ nil ]
]

{ #category : #'accessing - db properties' }
LeLocalStore >> tableOfContentsPageID: aUUID [
	"Store the page to be used as a Table of Contents"

	self updateProperty: #tableOfContents value: (aUUID ifNotNil: #asString36) 
]

{ #category : #accessing }
LeLocalStore >> titleFilename: aString [

	^ storage titleFilename: aString
]

{ #category : #'private - db properties' }
LeLocalStore >> updateProperty: propertyName value: aJSONObject [
	| properties |

	properties := self dbProperties.
	aJSONObject ifNil: 
		[ properties removeKey: propertyName ifAbsent: [ ].
		^ self savePropertiesDictionary: properties ].
	(properties at: propertyName ifAbsent: [nil]) = aJSONObject ifTrue: [ ^ self ].
	properties at: propertyName put: aJSONObject.
	self savePropertiesDictionary: properties.
]

{ #category : #'accessing - db properties' }
LeLocalStore >> uuid [ 
	"Answer the UUID of the receiver's DB"
	<return: #UUID>

	^ UUID fromString: (self dbProperties at: #uuid)
]

{ #category : #'accessing - db properties' }
LeLocalStore >> uuidString [
	"Answer the UUID of the receiver's DB in String36 format"
	<return: #String>

	^ self uuid asString36
]
