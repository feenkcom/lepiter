Class {
	#name : #LeContextMenuSpotterStartExamples,
	#superclass : #Object,
	#instVars : [
		'dbDir',
		'diskDb'
	],
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #private }
LeContextMenuSpotterStartExamples >> createDatabase [
	| database dbName |

	dbName := 'db'.
	dbDir := FileSystem memory root / dbName.
	dbDir ensureCreateDirectory.
	database := LeLocalStoreLoad current loadAndMonitorFrom: dbDir saveDelay: 0 seconds.
	database userEmail: dbName,'@example.com'.
	^ database
]

{ #category : #private }
LeContextMenuSpotterStartExamples >> createDatabaseOnDisk [

	dbDir := (FileReference newTempFilePrefix: self class name, '-' suffix: '-testDbs') / #db.
	dbDir ensureCreateDirectory.
	diskDb := LeLocalStoreLoad current loadAndMonitorFrom: dbDir saveDelay: 0 seconds.
	^ diskDb
]

{ #category : #private }
LeContextMenuSpotterStartExamples >> deleteTemporaryDirectory [

	dbDir ifNotNil: 	
		[ dbDir ensureDeleteAll ]
]

{ #category : #examples }
LeContextMenuSpotterStartExamples >> imageUrlForDbFile [
	"Demonstrate the URl that is used for the picture snippet when the supplied URL is a file that is already a DB attachment"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #ByteString>
	| sourceUrl pictureUrl |
	sourceUrl := self imageUrlForLocalFile.
	pictureUrl := LeContextMenuSpotterStart new
			database: diskDb;
			spotterPictureFileStringFor: sourceUrl.
	self assert: pictureUrl equals: sourceUrl.
	self
		assert: (diskDb localStoreRootDirectory / #attachments) children size
		equals: 1.
	^ pictureUrl
]

{ #category : #examples }
LeContextMenuSpotterStartExamples >> imageUrlForHttp [
	"Demonstrate the URl that is used for the picture snippet when the supplied URL is http(s)://..."

	<gtExample>
	<return: #ByteString>
	| db sourceUrl pictureUrl |
	db := self createDatabase.
	sourceUrl := 'https://feenk.com/assets/pictures/feenk.png'.
	pictureUrl := LeContextMenuSpotterStart new
			database: db;
			spotterPictureFileStringFor: sourceUrl.
	self assert: pictureUrl equals: sourceUrl.
	self assert: (db localStoreRootDirectory / #attachments) hasChildren not.
	^ pictureUrl
]

{ #category : #examples }
LeContextMenuSpotterStartExamples >> imageUrlForHttpNonImage [
	"Demonstrate the URl that is used for the picture snippet when the supplied URL is http(s)://..."

	<gtExample>
	<return: #LeContextMenuSpotterStartExamples>
	| db sourceUrl pictureUrl |
	db := self createDatabase.
	sourceUrl := 'https://feenk.com'.
	pictureUrl := LeContextMenuSpotterStart new
			database: db;
			spotterPictureFileStringFor: sourceUrl.
	self assert: pictureUrl isNil.
	self assert: (db localStoreRootDirectory / #attachments) hasChildren not
]

{ #category : #examples }
LeContextMenuSpotterStartExamples >> imageUrlForLocalFile [
	"Demonstrate the URl that is used for the picture snippet when the supplied URL is a local file"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #ByteString>
	| sourceUrl pictureUrl |
	self createDatabaseOnDisk.
	sourceUrl := dbDir parent / #'image.jpg'.
	PluginBasedJPEGReadWriter putForm: BrGlamorousIcons gt onFileNamed: sourceUrl.
	pictureUrl := LeContextMenuSpotterStart new
			database: diskDb;
			spotterPictureFileStringFor: sourceUrl fullName.
	self assert: (pictureUrl beginsWith: #attachments).
	self assert: (pictureUrl endsWith: #'image.jpg').
	self
		assert: (diskDb localStoreRootDirectory / #attachments) children size
		equals: 1.
	^ pictureUrl
]

{ #category : #examples }
LeContextMenuSpotterStartExamples >> imageUrlForLocalFileNonImage [
	"Demonstrate the URl that is used for the picture snippet when the supplied URL is http(s)://..."

	<gtExample>
	<return: #LeContextMenuSpotterStartExamples>
	| db sourceUrl pictureUrl |
	db := self createDatabase.
	sourceUrl := db localStoreRootDirectory fullName.
	pictureUrl := LeContextMenuSpotterStart new
			database: db;
			spotterPictureFileStringFor: sourceUrl.
	self assert: pictureUrl isNil.
	self assert: (db localStoreRootDirectory / #attachments) hasChildren not
]

{ #category : #examples }
LeContextMenuSpotterStartExamples >> imageUrlForLocalFileUppercase [
	"Demonstrate the URl that is used for the picture snippet when the supplied URL is a local file"

	<gtExample>
	<after: #deleteTemporaryDirectory>
	<return: #ByteString>
	| sourceUrl pictureUrl |
	self createDatabaseOnDisk.
	sourceUrl := dbDir parent / #'image.JPG'.
	PluginBasedJPEGReadWriter putForm: BrGlamorousIcons gt onFileNamed: sourceUrl.
	pictureUrl := LeContextMenuSpotterStart new
			database: diskDb;
			spotterPictureFileStringFor: sourceUrl fullName.
	self assert: (pictureUrl beginsWith: #attachments).
	self assert: (pictureUrl endsWith: #'image.JPG').
	self
		assert: (diskDb localStoreRootDirectory / #attachments) children size
		equals: 1.
	^ pictureUrl
]
