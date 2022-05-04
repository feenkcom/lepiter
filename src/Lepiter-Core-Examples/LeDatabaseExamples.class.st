Class {
	#name : #LeDatabaseExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'database',
		'memStore'
	],
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #examples }
LeDatabaseExamples >> addAttachmentByCopy [
	"Demonstrate attaching a file to a database by copy"
	<gtExample>
	<after: #cleanUp>
	| db attachmentSource attachment userEmail now propertiesFileReference properties |

	memStore := FileSystem memory root.
	db := memStore / 'db'.
	db ensureCreateDirectory.

	attachmentSource := memStore / 'attachment.txt'.
	attachmentSource ensureCreateFile.

	userEmail := 'attached@email.com'.
	database := LeLocalStoreLoad current loadAndMonitorFrom: db.
	database properties savePersonalInformation: true.
	database userEmail: userEmail.
	now := DateAndTime now.

	self deny: ((db allChildren collect: #basename) includes: 'attachment.txt').

	attachment := database resolveDbFile: (database addAttachmentByCopy: attachmentSource).

	self assert: attachmentSource exists.
	self assert: attachment exists.
	propertiesFileReference := attachment parent / 'lepiter_attachment.properties'.
	self assert: propertiesFileReference exists.

	properties := LeAttachment loadFrom: propertiesFileReference.
	self assert: properties uploadedBy email equals: userEmail.
	"It isn't actually possible to directly reference the original, since it is a memory file system.  Just check that the path is correct."
	self assert: properties originalReference path equals: attachmentSource path.
	self assert: (properties uploadDate - now) < 1 hour.
]

{ #category : #examples }
LeDatabaseExamples >> addAttachmentByMove [
	"Demonstrate attaching a file to a database by moving the file to the database"
	<gtExample>
	<after: #cleanUp>
	| db attachmentSource sourceName attachment userEmail now propertiesFileReference properties |

	memStore := FileSystem memory root.
	db := memStore / 'db'.
	db ensureCreateDirectory.

	attachmentSource := memStore / 'attachment.txt'.
	attachmentSource ensureCreateFile.
	sourceName := attachmentSource fullName.

	userEmail := 'attached@email.com'.
	database := LeLocalStoreLoad current loadAndMonitorFrom: db.
	database properties savePersonalInformation: true.
	database userEmail: userEmail.
	now := DateAndTime now.

	self deny: ((db allChildren collect: #basename) includes: 'attachment.txt').

	attachment := database resolveDbFile: (database addAttachmentByMove: attachmentSource).

	self deny: attachmentSource exists.
	self assert: attachment exists.
	propertiesFileReference := attachment parent / 'lepiter_attachment.properties'.
	self assert: propertiesFileReference exists.

	properties := LeAttachment loadFrom: propertiesFileReference.
	self assert: properties uploadedBy email equals: userEmail.
	"It isn't actually possible to directly reference the original, since it is a memory file system.  Just check that the path is correct."
	self assert: properties originalReference path equals: attachmentSource path.
	self assert: (properties uploadDate - now) < 1 hour.
]

{ #category : #private }
LeDatabaseExamples >> cleanUp [ 
	"Clean up the database, shutting down any monitor process"

	database ifNil: [ ^ self ].
	database monitor ifNotNil: 
		[ database stopMonitoring ].
	database := nil.
	memStore := nil.
]

{ #category : #examples }
LeDatabaseExamples >> corruptionInvalidJSON [
	"Check that pages with invalid JSON are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	| db page snippet pageFile corruptFile |
	memStore := FileSystem memory root.
	db := memStore / 'db'.
	db ensureCreateDirectory.
	database := LeLocalStoreLoad current
		loadAndMonitorFrom: db
		saveDelay: Duration zero.
	page := LePage named: #Page1.
	snippet := LeTextSnippet string: #Snippet1.
	page addSnippet: snippet.
	database addPage: page.
	pageFile := database monitor pageFileReference: page.
		"db / (page uid asString36 , '.json')".
	self assert: pageFile exists.
	self deny: database monitor hasCorruptFiles.
	corruptFile := db / 'truncated.lepiter'.
	corruptFile
		writeStreamDo: [ :stream | stream << (pageFile contents copyFrom: 1 to: 100) ].
	self should: [ database monitor reload ] raise: LeDBLoadError.
	self assert: database monitor hasCorruptFiles.
	self deny: corruptFile exists.
	self assert: (corruptFile withExtension: 'corrupt') exists
]

{ #category : #examples }
LeDatabaseExamples >> corruptionLoadDuplicatePage [
	"Check that pages with duplicate names are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	| db page snippet pageFile loader duplicateFile duplicateFiles jsonFiles |
	memStore := FileSystem memory root.
	db := memStore / 'db'.
	db ensureCreateDirectory.
	database := LeLocalStoreLoad current
		loadAndMonitorFrom: db
		saveDelay: Duration zero.
	page := LePage named: #Page1.
	snippet := LeTextSnippet string: #Snippet1.
	page addSnippet: snippet.
	database addPage: page.
	pageFile := database monitor pageFileReference: page.
	self assert: pageFile exists.
	self deny: database monitor hasCorruptFiles.
	database monitor stopMonitoring.
	duplicateFile := db / 'duplicate.lepiter'.
	pageFile copyTo: duplicateFile.
	loader := LeLocalStoreLoad current.
	database := loader loadAndMonitorFrom: db saveDelay: Duration zero.
	self assert: loader hasDuplicateFiles.
	self deny: loader hasCorruptedFiles.
	self assert: database monitor hasCorruptFiles.
	"Which of the two files is marked corrupt is non-deterministic (depends on file name or inode number), simply check for the correct number of files"
	jsonFiles := db childrenMatching: '*.lepiter'.
	duplicateFiles := db childrenMatching: '*.duplicate'.
	self assert: jsonFiles size equals: 1.
	self assert: duplicateFiles size equals: 1
]

{ #category : #examples }
LeDatabaseExamples >> corruptionReloadDuplicatePage [
	"Check that pages with duplicate names are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	| db page snippet pageFile corruptFile corruptFiles jsonFiles |
	memStore := FileSystem memory root.
	db := memStore / 'db'.
	db ensureCreateDirectory.
	database := LeLocalStoreLoad current
		loadAndMonitorFrom: db
		saveDelay: Duration zero.
	page := LePage named: #Page1.
	snippet := LeTextSnippet string: #Snippet1.
	page addSnippet: snippet.
	database addPage: page.
	pageFile := database monitor pageFileReference: page.
	self assert: pageFile exists.
	self deny: database monitor hasCorruptFiles.
	corruptFile := db / 'duplicate.lepiter'.
	pageFile copyTo: corruptFile.
	self should: [ database monitor reload ] raise: LeDBLoadError.
	self assert: database monitor hasCorruptFiles.
	"Which of the two files is marked corrupt is non-deterministic (depends on file name or inode number), simply check for the correct number of files"
	jsonFiles := db childrenMatching: '*.lepiter'.
	corruptFiles := db childrenMatching: '*.corrupt'.
	self assert: jsonFiles size equals: 1.
	self assert: corruptFiles size equals: 1
]

{ #category : #examples }
LeDatabaseExamples >> pageWithID [
	"Demonstrate retrieving pages of various types by ID"
	<gtExample>
	<after: #cleanUp>
	| page dailyNoteUID namedPageUID pharoClassPageUID unnamedPageUID flag |

	database := LeDatabase new.

	page := LePage dailyNoteFor: Date today.
	database addPage: page.
	dailyNoteUID := page uid.

	page := LePage named: #'Named Page'.
	database addPage: page.
	namedPageUID := page uid.

	page := LePage pharoClassName: self class name.
	database addPage: page.
	pharoClassPageUID := page uid.

	page := LePage unnamedPage.
	database addPage: page.
	unnamedPageUID := page uid.

	{ dailyNoteUID. namedPageUID. pharoClassPageUID. unnamedPageUID. } do: [ :uid |
		self 
			assert: (database pageWithID: uid) uid
			equals: uid.

		self
			assert: (database pageWithID: uid ifAbsent: [ self error: 'Test page not found' ]) uid
			equals: uid.

		database 
			pageWithID: uid
			ifPresent: [ :aPage | self assert: aPage uid equals: uid ]
			ifAbsent: [ self error: 'Test page not found' ] ].

	self
		should: [ database pageWithID: nil ]
		raise: NotFound.
	flag := false.
	database 
		pageWithID: nil
		ifAbsent: [ flag := true ].
	self assert: flag.
	flag := false.
	database 
		pageWithID: nil
		ifPresent: [ :aPage | self error: aPage asString ]
		ifAbsent: [ flag := true ].
	self assert: flag.

]
