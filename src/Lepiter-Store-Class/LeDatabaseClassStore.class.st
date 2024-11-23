Class {
	#name : #LeDatabaseClassStore,
	#superclass : #LeDatabaseStore,
	#instVars : [
		'dbClass',
		'dbPackage'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #'instance creation' }
LeDatabaseClassStore class >> forJsonV4 [
	"Answer an instance of the receiver with JSON V4 storage format"

	^ self new storage: LeDatabaseClassJsonV4Storage new
]

{ #category : #'instance creation' }
LeDatabaseClassStore class >> newDbOnClass: classSymbol package: packageSymbol [
	"Answer a new LeDatabase with the supplied class details"

	^ self newDbOnClass: classSymbol package: packageSymbol saveDelay: 30 seconds
]

{ #category : #'instance creation' }
LeDatabaseClassStore class >> newDbOnClass: classSymbol package: packageSymbol saveDelay: aDuration [
	"Answer a new LeDatabase with the supplied class details"
	| db |

	self environment at: classSymbol
		ifPresent: [ :cls | self error: 'Class already exists: ', classSymbol ].

	LeDatabaseClassStoreExport forJsonV4
		database: LeDatabase new;
		dbClassName: classSymbol package: packageSymbol;
		export.
	db := LeDatabaseClassStoreLoad forJsonV4
		loadFrom: classSymbol
		package: packageSymbol
		saveDelay: aDuration.
	db properties savePersonalInformation: true.
	^ db.
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentByCopy: aFileReference [
	"Copy the attached file to the receiver's DB and answer the string identifying the attachment"

	<return: #String>
	^ self addAttachmentByCopy: aFileReference withId: UUID new
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentByCopy: aFileReference withId: aUuid [
	"Copy the attached file to the receiver's DB and answer the string identifying the attachment"
	<return: #String>
	| attachmentUUID metadata |

	attachmentUUID := aUuid asString36.
	metadata := LeAttachment new 
		uploadDate: DateAndTime now;
		originalBasename: aFileReference basename.
	self savePersonalInformation ifTrue:
		[ metadata
			originalReference: aFileReference asFileReference;
			uploadedBy: self userEmail ].
	storage
		saveAttachment: aFileReference binaryContents 
		inClass: dbClass 
		selector: ('attachment_', attachmentUUID) asSymbol
		title: aFileReference basename
		classified: 'attachments'
		metadata: metadata.
	^ 'attachments/',attachmentUUID, '/', aFileReference basename
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentByMove: aFileReference [
	"Move the attached file to the receiver's DB and answer a string identifying the attachment"

	self error: 'LeDatabaseClassStore is unable to reference external files'
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentWithContent: aString named: aName [
	"Copy the attached file to the receiver's DB and answer the string identifying the attachment"
	<return: #String>
	^ self addAttachmentWithContent: aString named: aName withId: UUID new
]

{ #category : #attachments }
LeDatabaseClassStore >> addAttachmentWithContent: aContents named: aName withId: aUuid [ 
	| attachmentUUID metadata |

	attachmentUUID := aUuid asString36.
	metadata := LeAttachment new uploadDate: DateAndTime now.
	self savePersonalInformation ifTrue:
		[ metadata
			originalReference: aName asFileReference;
			uploadedBy: self userEmail ].
	storage
		saveAttachment: aContents utf8Encoded
		inClass: dbClass 
		selector: ('attachment_', attachmentUUID) asSymbol
		title: aName
		classified: 'attachments'
		metadata: metadata.
	^ attachmentUUID
]

{ #category : #attachments }
LeDatabaseClassStore >> attachmentBinaryStream: attachmentId do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"

	^ aBlock value: (storage loadAttachmentFromMethod: (dbClass class >> (storage attachmentSelectorFor: attachmentId))) readStream
]

{ #category : #accessing }
LeDatabaseClassStore >> attachmentIds [

	^ storage attachmentIdsFor: dbClass
]

{ #category : #attachments }
LeDatabaseClassStore >> attachmentUtf8Stream: attachmentId do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"

	^ aBlock value: (ZnCharacterReadStream on: (storage loadAttachmentFromMethod: (dbClass class >> (storage attachmentSelectorFor: attachmentId))) readStream encoding: 'utf-8')
]

{ #category : #attachments }
LeDatabaseClassStore >> attachmentWithDataForId: aUuid [
	| selector properties |
	selector := storage 
		attachmentSelectorFor: aUuid asString36.
	properties := dbClass perform: selector.
			
	^ LeAttachmentWithClassStorageData new
		id: aUuid asString36;
		database: self database;
		metadata: properties 
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClass [
	^ dbClass
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClass: aClass [

	dbClass := aClass.
	dbPackage := aClass package name.
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClassName [

	^ dbClass name
]

{ #category : #accessing }
LeDatabaseClassStore >> dbClassName: aSymbol package: packageName [

	self assert: [ dbClass isNil ]
		description: 'Renaming the DB class store is not supported'.

	dbClass := self class environment
		at: aSymbol
		ifPresent: [ :aClass | aClass ]
		ifAbsent: 
			[ GtAbstractLepiterDb subclass: aSymbol
				instanceVariableNames: '' 
				classVariableNames: ''
				package: packageName ].
	dbPackage := packageName.
]

{ #category : #accessing }
LeDatabaseClassStore >> dbPackage [
	^ dbPackage
]

{ #category : #accessing }
LeDatabaseClassStore >> dbPackage: aString [
	dbPackage := aString
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> defaultDatabaseName [
	"Answer the name to be used if one hasn't been explicitly set"
	<return: #String>

	^ self dbClassName asString
]

{ #category : #private }
LeDatabaseClassStore >> explicitLinksHash [
	"Return hash of explicit links from the receiver's class"

	<return: #LeBinaryContentsHash or: nil>
	| method |

	method := dbClass class methodDict
		at: #links
		ifAbsent: [ ^ nil ].
	^ [ 
		storage hashFromMethod: method.
	]
		on: LeDBLoadError 
		fork: [ :ex | ex pass ].
]

{ #category : #attachments }
LeDatabaseClassStore >> findAttachmentById: aUuid [
	| attachmentUUID |
	attachmentUUID := aUuid asString36.

	(self hasAttachmentWithId: aUuid)
		ifFalse: [ ^ LeLocalAttachmentDoesNotExist new
				uuid: aUuid;
				signal ].

	^ storage
		findAttachmentById: ('attachment_' , attachmentUUID) asSymbol
		inClass: dbClass
]

{ #category : #attachments }
LeDatabaseClassStore >> hasAttachmentWithId: aUuid [
	| attachmentUUID |

	attachmentUUID := aUuid asString36.
	
	^ storage
		hasAttachmentWithId: ('attachment_', attachmentUUID) asSymbol inClass: dbClass
]

{ #category : #private }
LeDatabaseClassStore >> loadExplicitLinks [
	"Load all the explicit links from the receiver's class"
	| method |

	method := dbClass class methodDict
		at: #links
		ifAbsent: [ ^ nil ].
	^ [ 
		| theExplicitLinks |
		theExplicitLinks := storage loadFromMethod: method.
		LeReloadOptimization ifEnabled: [
			| aHash |
			aHash := storage hashFromMethod: method.
			theExplicitLinks storageHash: aHash.
			theExplicitLinks ]
	]
		on: LeDBLoadError 
		fork: [ :ex | ex pass ].
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> loadPropertiesDictionary [
	"Answer the lepiter properties dictionary"

	^ [ storage loadPropertiesFromClass: dbClass class ]
		on: KeyNotFound
		do: [ :ex | self newPropertiesDictionary ]
]

{ #category : #private }
LeDatabaseClassStore >> pageHashFor: aLePage [
	"Return stored content hash that corresponds to the given page"

	<return: #LeBinaryContentsHash or: nil>
	| method |

	method := dbClass class methodDict
		at: (storage pageSelectorFor: aLePage)
		ifAbsent: [ ^ nil ].
	
	^ [ 
		storage hashFromMethod: method.
	]
		on: LeDBLoadError 
		fork: [ :ex | ex pass ].
]

{ #category : #accessing }
LeDatabaseClassStore >> pagesFromStore [
	"Answer a collection of all pages loaded from the store"

	^ (storage pageSelectorsIn: dbClass) collect: [ :selector |
		| page |
		page := storage loadFromClass: dbClass selector: selector.
		page ifNotNil: [ 
			LeReloadOptimization ifEnabled: [
				page storageHash: (self pageHashFor: page) ] ].
		page ]
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> preloadScript [
	<return: #FileReference or: nil>

	^ nil
	"^ self dbProperties at: #preloadScript 
		ifPresent: [ :aString | self fileReferenceFrom: aString ]
		ifAbsent: [ nil ]"
]

{ #category : #private }
LeDatabaseClassStore >> reloadPage: aLePage [

	^ storage loadFromMethod: (dbClass class >> (storage pageSelectorFor: aLePage))
]

{ #category : #private }
LeDatabaseClassStore >> savePageNow: aLePage [

	LeDatabaseClassStoreQueueStorePageEntry new
		monitor: self;
		page: aLePage;
		apply.
]

{ #category : #'accessing - db properties' }
LeDatabaseClassStore >> savePropertiesDictionary: propertiesDictionary [

	storage
		saveProperties: propertiesDictionary
		inClass: dbClass
]

{ #category : #accessing }
LeDatabaseClassStore >> signalDuplicatePage: aPage reason: aString originalException: originalException [
	| error |

	UIManager default inform: 'Lepiter: Unable to load: ', aPage title, ' in ', dbClass name, ' due to a duplicate page ID'.
	storage renameTo: 'duplicate' pageUid: aPage uid class: dbClass.
	error := LeDBLoadError new.
	error properties 
		at: #class put: dbClass;
		at: #selector put: (storage pageSelectorFor: aPage).
	error
		pageTitle: aPage title;
		pageUid: aPage uid;
		reason: aString;
		originalException: nil;
		signal
]

{ #category : #accessing }
LeDatabaseClassStore >> storeLocation [
	"Answer the receiver's DB location."

	dbClass ifNil: [ ^ nil ].

	^ ZnUrl new
		scheme: #class;
		segments: (OrderedCollection with: dbPackage asString with: dbClass name asString)
]

{ #category : #attachments }
LeDatabaseClassStore >> updateAttachmentWithContent: aContents named: aName withId: aUuid [ 
	^ self addAttachmentWithContent: aContents named: aName withId: aUuid
]
