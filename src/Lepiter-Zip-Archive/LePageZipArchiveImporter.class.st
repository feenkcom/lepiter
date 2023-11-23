"
I am LePageZipArchiveImporter.

I open and import a .lepiter.zip archive from an external origin.

The archive contains the original .lepiter file with all attachments that it refers to.s

See LePageZipArchiveExporter for the inverse operation.
"
Class {
	#name : #LePageZipArchiveImporter,
	#superclass : #Object,
	#instVars : [
		'file',
		'directory',
		'page',
		'database'
	],
	#category : #'Lepiter-Zip-Archive'
}

{ #category : #utilites }
LePageZipArchiveImporter class >> importPage: page [
	^ self 
		importPage: page 
		inDatabase: LeDatabasesRegistry new defaultLogicalDatabase primaryDB
]

{ #category : #utilities }
LePageZipArchiveImporter class >> importPage: page inDatabase: database [
	| pageCopy |
	"serialize/deserialize to make an independent copy"
	pageCopy := LeJsonV4 default deserialize: (LeJsonV4 default serialize: page) readStream.
	"set a unique title that indicates this was imported"
	pageCopy title: page title , ' - Imported ' , DateAndTime now printToSeconds.
	"change the page's uid (see LePage>>#assingNewUID to make it unique"
	pageCopy basicUid: database newUID uid.
	"change the uid's of all snippets to make them unique"
	pageCopy allChildrenDepthFirstDo: [ :snippet |
		snippet uid: database newUID ].
	"copy attachment files over, when needed"
	pageCopy attachments get items do: [ :attachment | | id file |
		id := UUID fromString36: ($/ split: attachment name) second.
		file := page database resolveDbFile: attachment name. "use the original page's database !:"
		(database hasAttachmentWithId: id)
			ifFalse: [ database addAttachmentByCopy: file withId: id ] ].
	"finally add the page"
	database addPage: pageCopy.
	^ pageCopy
]

{ #category : #accessing }
LePageZipArchiveImporter >> attachmentsDirectory [
	^ self exportDirectory / 'attachments'
]

{ #category : #operations }
LePageZipArchiveImporter >> createPageInTemporaryDatabase [
	| attachmentFiles |
	self page: (LeLocalStoreLoad current loadPageFrom: self lepiterFile).
	attachmentFiles := page attachments get items collect: [ :each | | id attachmentFile |
		id := ($/ split: each name) second. 
		attachmentFile := ($/ split: each name) third.
		self attachmentsDirectory / id / attachmentFile ].
	attachmentFiles do: [ :each | | id |
		id := each resolve parent path segments last.
		self database addAttachmentByCopy: each withId: (UUID fromString36: id) ].
	self database addPage: self page
]

{ #category : #accessing }
LePageZipArchiveImporter >> database [
	^ database
		ifNil: [ database := LeLocalStoreLoad current loadAndMonitorFrom: self lepiterDirectory ]
]

{ #category : #accessing }
LePageZipArchiveImporter >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LePageZipArchiveImporter >> directory [
	^ directory
		ifNil: [ directory := (FileReference newTempFilePrefix: 'gt-tmp-' suffix: '-dir')
					ensureCreateDirectory ]
]

{ #category : #accessing }
LePageZipArchiveImporter >> directory: anObject [
	directory := anObject
]

{ #category : #accessing }
LePageZipArchiveImporter >> exportDirectory [
	^ self directory / self exportTitle
]

{ #category : #accessing }
LePageZipArchiveImporter >> exportTitle [
	^ self file basename allButLast: '.lepiter.zip' size
]

{ #category : #operations }
LePageZipArchiveImporter >> extractZipArchive [
	| zipArchive |
	zipArchive := ZipArchive new readFrom: self file.
	zipArchive extractAllTo: self directory.
	^ zipArchive
]

{ #category : #accessing }
LePageZipArchiveImporter >> file [
	^ file
]

{ #category : #accessing }
LePageZipArchiveImporter >> file: anObject [
	file := anObject
]

{ #category : #accessing }
LePageZipArchiveImporter >> gtPageFor: aView [
	<gtView>
	self page ifNil: [ aView empty ].
	^ aView forward
		title: 'Page';
		object: [ self page ];
		view: #gtLiveFor:
]

{ #category : #operations }
LePageZipArchiveImporter >> import [
	self assert: (self file basename endsWith: '.lepiter.zip').
	self extractZipArchive.
	self createPageInTemporaryDatabase
]

{ #category : #accessing }
LePageZipArchiveImporter >> lepiterDirectory [
	^ self directory / #lepiter
]

{ #category : #accessing }
LePageZipArchiveImporter >> lepiterFile [
	^ self exportDirectory / self pageId , 'lepiter'
]

{ #category : #accessing }
LePageZipArchiveImporter >> page [
	^ page
]

{ #category : #accessing }
LePageZipArchiveImporter >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LePageZipArchiveImporter >> pageId [
	^ ($- split: self exportTitle) last
]
