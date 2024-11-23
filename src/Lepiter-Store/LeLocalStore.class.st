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
	#superclass : #LeDatabaseStore,
	#traits : 'TGtMacroFileReferenceEncoding',
	#classTraits : 'TGtMacroFileReferenceEncoding classTrait',
	#instVars : [
		'localRoot',
		'attachmentsDirectory'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalStore class >> attachmentsDirectoryName [
	^ 'attachments'
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

{ #category : #attachments }
LeLocalStore >> addAttachmentByCopy: aFileReference [
	"Copy the attached file to the receiver's DB and answer the relative path string to the file"

	<return: #String>
	^ self addAttachmentByCopy: aFileReference withId: UUID new
]

{ #category : #attachments }
LeLocalStore >> addAttachmentByCopy: aFileReference withId: aUuid [
	"Copy the attached file to the receiver's DB and answer the relative path string to the file"

	<return: #String>
	| attachmentFileReference attachmentDirectory |
	database assertNotReadOnly.

	attachmentDirectory := self
			attachmentDirectoryAndMetadataFor: aFileReference
			usingId: aUuid.
	attachmentFileReference := attachmentDirectory / aFileReference basename.
	aFileReference copyTo: attachmentFileReference.
	^ (attachmentFileReference relativeTo: localRoot) fullName
]

{ #category : #attachments }
LeLocalStore >> addAttachmentByMove: aFileReference [
	"Move the attached file to the receiver's DB and answer the relative path string to the file"
	<return: #String>
	| attachmentFileReference attachmentDirectory |

	database assertNotReadOnly.

	attachmentDirectory := self attachmentDirectoryAndMetadataFor:
		                       aFileReference usingId: UUID new.
	attachmentFileReference := attachmentDirectory
	                           / aFileReference basename.
	aFileReference resolve copy moveTo: attachmentFileReference resolve.
	^ (attachmentFileReference relativeTo: localRoot) fullName
]

{ #category : #attachments }
LeLocalStore >> addAttachmentWithContent: aString named: aName [
	"Create an attachment to the receiver's DB and answer the relative path string to the file"
	<return: #String>
	^ self addAttachmentWithContent: aString named: aName withId: UUID new
]

{ #category : #attachments }
LeLocalStore >> addAttachmentWithContent: aContents named: aName withId: aUuid [
	| attachmentFileReference attachmentDirectory |

	database assertNotReadOnly.

	attachmentDirectory := self attachmentDirectoryAndMetadataFor:
		                       aName asFileReference usingId: aUuid.
	attachmentFileReference := attachmentDirectory / aName asString.
	attachmentFileReference
		binaryWriteStreamDo: [ :aStream | aStream nextPutAll: aContents ].
	^ (attachmentFileReference relativeTo: localRoot)
		  fullName 
]

{ #category : #attachments }
LeLocalStore >> attachmentBinaryStream: attachmentPath do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"
	| attachmentFileReference |

	attachmentFileReference := database resolveDbFile: attachmentPath.
	self assert: attachmentFileReference exists.
	^ attachmentFileReference binaryReadStreamDo: aBlock
]

{ #category : #attachments }
LeLocalStore >> attachmentDirectories [

	^ attachmentsDirectory exists
		  ifTrue: [ attachmentsDirectory directories ]
		  ifFalse: [ #(  ) ]
]

{ #category : #attachments }
LeLocalStore >> attachmentDirectoryAndMetadataFor: aFileReference usingId: aUuid [
	"Create the attachment directory and populate the metadata for the supplied file reference.
	Answer the directory."
	| fileUID attachmentDirectory attachment |

	self assert: [ aFileReference basename ~= LeAttachment basename ] description: [ 
		String streamContents: [ :aStream | 
			aStream nextPutAll: 'Cannot create attachment directory and metadata. The filename is '.
			aStream nextPutAll: aFileReference basename.
			aStream nextPutAll: '.' 
		]
	].
	fileUID := aUuid asString36.
	attachmentDirectory := attachmentsDirectory / fileUID.
	attachmentDirectory exists ifTrue: [ 
		LeLocalAttachmentAlreadyExist new
			basename: aFileReference basename;
			uuid: fileUID;
			signal
	].
	
	attachmentDirectory ensureCreateDirectory.
	attachment := LeAttachment new
		originalReference: aFileReference asFileReference;
		uploadDate: DateAndTime now;
		uploadedBy: self userEmail.
	attachment saveTo: attachmentDirectory for: database.
	^ attachmentDirectory resolve
]

{ #category : #attachments }
LeLocalStore >> attachmentProperties: attachmentPath [
	"Answer a stream on the binary contents of the supplied attachment path"
	| attachmentFileReference |

	attachmentFileReference := database resolveDbFile: attachmentPath.
	self assert: attachmentFileReference exists.
	^ LeAttachment loadFrom: attachmentFileReference parent / LeAttachment basename
]

{ #category : #attachments }
LeLocalStore >> attachmentUtf8Stream: attachmentPath do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"
	| attachmentFileReference |

	attachmentFileReference := database resolveDbFile: attachmentPath.
	self assert: attachmentFileReference exists.
	^ attachmentFileReference readStreamDo: aBlock
]

{ #category : #attachments }
LeLocalStore >> attachmentWithDataForId: aUuid [
	| fileUID attachmentDirectory properties |
	
	fileUID := aUuid asString36.
	attachmentDirectory := attachmentsDirectory / fileUID.
	attachmentDirectory exists ifFalse: [ ^ nil ].
	
	properties := LeAttachment loadFromFolder: attachmentDirectory.
	^ LeAttachmentWithDiskStorageData new
		id: fileUID;
		database: self database;
		metadata: properties
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
LeLocalStore >> attachmentsDirectoryName [
	^ self class attachmentsDirectoryName
]

{ #category : #accessing }
LeLocalStore >> dbPropertiesFile [
	^ localRoot / self propertiesBasename
]

{ #category : #'accessing - db properties' }
LeLocalStore >> defaultDatabaseName [
	"Answer the name to be used if one hasn't been explicitly set"
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
LeLocalStore >> explicitLinksFileReference [
	^ self storage explicitLinksFileOrNilIn: self localRoot
]

{ #category : #private }
LeLocalStore >> explicitLinksHash [
	<return: #LeBinaryContentsHash or: nil>
	storage withExplicitLinksFileIn: localRoot do: [ :aFile |
		[
			^ LeBinaryContentsHash fromFileReference: aFile.
		 ]
			on: LeDBLoadError 
			fork: [ :ex | ex pass ] ].
	^ nil
]

{ #category : #accessing }
LeLocalStore >> explicitLinksOrNil [

	^ self explicitLinksFileReference ifNotNil:
		[ :file | storage loadPageFrom: file ].
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

{ #category : #attachments }
LeLocalStore >> findAttachmentById: aUuid [
	| attachmentDirectory fileUID targetFile |
	fileUID := aUuid asString36.
	attachmentDirectory := attachmentsDirectory / fileUID.

	attachmentDirectory exists
		ifFalse: [ ^ LeLocalAttachmentDoesNotExist new
				uuid: aUuid;
				signal ].

	targetFile := attachmentDirectory files
			detect: [ :aFile | aFile basename ~= LeAttachment basename ]
			ifNone: [ ^ LeLocalAttachmentMissingFile new
					uuid: aUuid;
					directory: attachmentDirectory;
					signal ].

	^ targetFile binaryContents
]

{ #category : #accessing }
LeLocalStore >> gtActionDBPropertiesFileFor: anAction [
	<gtAction>
	^ anAction button
		tooltip: 'Browse lepiter.properties file';
		priority: 10;
		icon: BrGlamorousIcons folder;
		action: [ :b | b phlow spawnObject: self dbPropertiesFile ]
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

{ #category : #attachments }
LeLocalStore >> hasAttachmentWithId: aUuid [
	| attachmentDirectory fileUID |

	database assertNotReadOnly.

	fileUID := aUuid asString36.
	attachmentDirectory := attachmentsDirectory / fileUID.
	
	^ attachmentDirectory exists
]

{ #category : #private }
LeLocalStore >> loadExplicitLinks [
	
	storage withExplicitLinksFileIn: localRoot do: [ :aFile |
		[
			| theExplicitLinks aHash |
			theExplicitLinks := storage loadFromFile: aFile.
			LeReloadOptimization ifEnabled: [
				aHash := LeBinaryContentsHash fromFileReference: aFile.
				theExplicitLinks storageHash: aHash ].
			^ theExplicitLinks
		 ]
			on: LeDBLoadError 
			fork: [ :ex | ex pass ] ].
	^ nil
]

{ #category : #'private - db properties' }
LeLocalStore >> loadPropertiesDictionary [
	"Answer the leptier.properties file contents"
	| propertiesFile |

	propertiesFile := localRoot / self propertiesBasename.
	propertiesFile exists ifFalse: [ ^ self newPropertiesDictionary ].
	^ propertiesFile readStreamDo: [ :stream |
		(NeoJSONReader on: stream)
			mapClass: GtStringContentDictionary;
			next ].

]

{ #category : #accessing }
LeLocalStore >> localRoot [
	^ localRoot
]

{ #category : #accessing }
LeLocalStore >> localRoot: aFileReference [
	"Set the localRoot for the storage"

	localRoot := aFileReference.
	attachmentsDirectory := localRoot / self attachmentsDirectoryName
]

{ #category : #attachments }
LeLocalStore >> lookupAttachmentDirectoryAndMetadataFor: aFileReference usingId: aUuid [
	"Create the attachment directory and populate the metadata for the supplied file reference.
	Answer the directory."
	| fileUID attachmentDirectory attachment |

	self assert: [ aFileReference basename ~= LeAttachment basename ].
	fileUID := aUuid asString36.
	attachmentDirectory := attachmentsDirectory / fileUID.
	self assert: attachmentDirectory exists.
	attachment := LeAttachment new
		originalReference: aFileReference asFileReference;
		uploadDate: DateAndTime now;
		uploadedBy: self userEmail.
	attachment saveTo: attachmentDirectory for: database.
	^ attachmentDirectory resolve
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

{ #category : #accessing }
LeLocalStore >> pageHashFor: aLePage [
	<return: #LeBinaryContentsHash or: nil>

	| aFile |
	aFile := localRoot / (self pageFilename: aLePage).
	aFile ifNil: [ ^ nil ].
	aFile exists ifFalse: [ ^ nil ].
	
	^ LeBinaryContentsHash fromFileReference: aFile
]

{ #category : #accessing }
LeLocalStore >> pagesFromStore [
	"Answer a collection of all pages loaded from the store"

	^ (storage dbFilesIn: self localRoot)
		collect: [ :file | 
			| aPage |
			aPage := storage loadFromFile: file.
			aPage ifNotNil: [
				LeReloadOptimization ifEnabled: [
					| aHash |
					aHash := LeBinaryContentsHash fromFileReference: file.
					aPage storageHash: aHash ] ].
			aPage ]
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

{ #category : #accessing }
LeLocalStore >> propertiesBasename [
	"Answer the basename of the receiver's database properties file"

	^ LepiterCoreDefaults databasePropertiesBasename
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

{ #category : #'private - db properties' }
LeLocalStore >> savePropertiesDictionary: properties [
	"Save the lepiter.properties file contents"
	| propertiesFile |

	propertiesFile := (localRoot / self propertiesBasename) resolve.
	localRoot ensureCreateDirectory.
	propertiesFile ensureDelete ensureCreateFile.
	^ propertiesFile writeStreamDo: [ :stream |
		STONJSON put: properties onStreamPretty: (ZnNewLineWriterStream on: stream) ].

]

{ #category : #accessing }
LeLocalStore >> signalDuplicatePage: aPage reason: aString originalException: originalException [
	| file corruptFileReference error |

	file := localRoot / (storage pageFilename: aPage).
	corruptFileReference := (file withExtension: 'corrupt') nextVersion.
	"UIManager default 
		inform: 'Lepiter: Unable to load: '
			, corruptFileReference basename
			, ' in ', corruptFileReference parent fullName
			, ' due to a duplicate page ID'."
	file resolve renameTo: corruptFileReference basename.
	error := LeDBLoadError new.
	error properties at: #fileReference put: corruptFileReference.
	error
		pageTitle: aPage title;
		pageUid: aPage uid;
		reason: aString;
		originalException: nil;
		signal
]

{ #category : #accessing }
LeLocalStore >> storeLocation [
	"Answer the receiver's directory.  This is used to compare whether two databases can be considered the same, i.e. have the same underlying store.  If no directory is configured, answer self so the comparison is false."

	localRoot ifNil: [ ^ self ].
	^ localRoot asLepiterZnUrl.
]

{ #category : #accessing }
LeLocalStore >> titleFilename: aString [

	^ storage titleFilename: aString
]

{ #category : #attachments }
LeLocalStore >> updateAttachmentWithContent: aContents named: aName withId: aUuid [
	| attachmentFileReference attachmentDirectory |

	database assertNotReadOnly.

	attachmentDirectory := self lookupAttachmentDirectoryAndMetadataFor:
		                       aName asFileReference usingId: aUuid.
	attachmentFileReference := attachmentDirectory / aName asString.
	attachmentFileReference
		binaryWriteStreamDo: [ :aStream | aStream nextPutAll: aContents ].
	^ (attachmentFileReference relativeTo: localRoot)
		  fullName 
]
