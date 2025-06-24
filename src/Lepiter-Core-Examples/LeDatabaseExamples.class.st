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
	<return: #ByteString>
	| db attachmentId attachmentSource attachment userEmail now propertiesFileReference properties |
	memStore := FileSystem memory root.
	db := memStore / 'db'.
	db ensureCreateDirectory.

	attachmentSource := memStore / 'attachment.txt'.
	attachmentSource writeStreamDo: [ :stream | stream << 'Hello, World' ].

	userEmail := 'attached@email.com'.
	database := LeLocalStoreLoad current loadAndMonitorFrom: db.
	database properties savePersonalInformation: true.
	database userEmail: userEmail.
	now := DateAndTime now.

	self deny: ((db allChildren collect: #basename) includes: 'attachment.txt').

	attachmentId := database addAttachmentByCopy: attachmentSource.
	attachment := database resolveDbFile: attachmentId.

	self assert: attachmentSource exists.
	self assert: attachment exists.
	propertiesFileReference := attachment parent / LeAttachment basename.
	self assert: propertiesFileReference exists.

	properties := database attachmentProperties: attachmentId.
	self assert: properties uploadedBy email equals: userEmail.	"It isn't actually possible to directly reference the original, since it is a memory file system.  Just check that the path is correct."
	self assert: properties originalReference path equals: attachmentSource path.
	self assert: properties uploadDate - now < 1 hour.
	self
		assert: (database attachmentUtf8Stream: attachmentId do: [ :stream | stream contents ])
		equals: 'Hello, World'.
	self
		assert: (database attachmentBinaryStream: attachmentId do: [ :stream | stream contents ])
		equals: 'Hello, World' utf8Encoded.
	^ attachmentId
]

{ #category : #examples }
LeDatabaseExamples >> addAttachmentByMove [
	"Demonstrate attaching a file to a database by moving the file to the database"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabaseExamples>
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

	attachment := database
			resolveDbFile: (database addAttachmentByMove: attachmentSource).

	self deny: attachmentSource exists.
	self assert: attachment exists.
	propertiesFileReference := attachment parent / LeAttachment basename.
	self assert: propertiesFileReference exists.

	properties := LeAttachment loadFrom: propertiesFileReference.
	self assert: properties uploadedBy email equals: userEmail.	"It isn't actually possible to directly reference the original, since it is a memory file system.  Just check that the path is correct."
	self assert: properties originalReference path equals: attachmentSource path.
	self assert: properties uploadDate - now < 1 hour
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
LeDatabaseExamples >> corruptionInvalidJsonFromClassStore [
	"Check that pages with invalid JSON are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabaseExamples>
	| page snippet corruptSource |
	EpMonitor
		disableDuring: [ [ self class environment
				at: self dbClassName
				ifPresent: [ :cls | cls removeFromSystem ].
			database := LeDatabaseClassStoreLoad
					newDbOnClass: self dbClassName
					package: self dbPackageName
					saveDelay: Duration zero.
			page := LePage named: #Page1.
			snippet := LeTextSnippet string: #Snippet1.
			page addSnippet: snippet.
			database addPage: page.
			self assert: (database hasPageNamed: #Page1).
			self deny: database monitor hasCorruptPages.
			corruptSource := 'page_123
			"Corrupt source example"
			"{ ""pageType"" : {"'.
			self
				should: [ database monitor dbClass class
						compile: corruptSource
						classified: 'test duplicate' ]
				raise: LeDBLoadError.
			self assert: database monitor hasCorruptPages.
			self assert: database pages size equals: 1.
			self assert: database monitor corruptSelectors size equals: 1 ]
				ensure: [ self class environment
						at: self dbClassName
						ifPresent: [ :cls | cls removeFromSystem ] ] ]
]

{ #category : #examples }
LeDatabaseExamples >> corruptionInvalidJsonFromLocalStore [
	"Check that pages with invalid JSON are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabaseExamples>
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
	pageFile := database monitor pageFileReference: page.	"db / (page uid asString36 , '.json')"
	self assert: pageFile exists.
	self deny: database monitor hasCorruptPages.
	corruptFile := db / 'truncated.lepiter'.
	corruptFile
		writeStreamDo: [ :stream | stream << (pageFile contents copyFrom: 1 to: 100) ].
	self should: [ database monitor reload ] raise: LeDBLoadError.
	self assert: database monitor hasCorruptPages.
	self deny: corruptFile exists.
	self assert: (corruptFile withExtension: 'corrupt') exists
]

{ #category : #examples }
LeDatabaseExamples >> corruptionLoadDuplicatePageFromClass [
	"Check that pages with duplicate names are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabaseExamples>
	| page snippet loader pageSource |
	EpMonitor
		disableDuring: [ [ database := LeDatabaseClassStoreLoad
					newDbOnClass: self dbClassName
					package: self dbPackageName
					saveDelay: Duration zero.
			page := LePage named: #Page1.
			snippet := LeTextSnippet string: #Snippet1.
			page addSnippet: snippet.
			database addPage: page.
			self assert: (database hasPageNamed: #Page1).
			self deny: database monitor hasCorruptPages.
			database monitor stopMonitoring.
			pageSource := (database monitor dbClass class
					>> (database monitor storage pageSelectorFor: page)) sourceCode.
			pageSource := 'page_Dup' , (pageSource copyFrom: 6 to: pageSource size).
			database monitor dbClass class
				compile: pageSource
				classified: 'test duplicate'.
			loader := LeDatabaseClassStoreLoad current.
			database := loader
					loadFrom: self dbClassName
					package: self dbPackageName
					saveDelay: Duration zero.
			self assert: loader hasDuplicatePages.
			self deny: loader hasCorruptedPages.
			self assert: database monitor hasCorruptPages.
			self assert: database monitor corruptSelectors size equals: 1 ]
				ensure: [ self class environment
						at: self dbClassName
						ifPresent: [ :cls | cls removeFromSystem ] ] ]
]

{ #category : #examples }
LeDatabaseExamples >> corruptionLoadDuplicatePageFromLocal [
	"Check that pages with duplicate names are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabaseExamples>
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
	self deny: database monitor hasCorruptPages.
	database monitor stopMonitoring.
	duplicateFile := db / 'duplicate.lepiter'.
	pageFile copyTo: duplicateFile.
	loader := LeLocalStoreLoad current.
	database := loader loadAndMonitorFrom: db saveDelay: Duration zero.
	self assert: loader hasDuplicatePages.
	self deny: loader hasCorruptedPages.
	self assert: database monitor hasCorruptPages.	"Which of the two files is marked corrupt is non-deterministic (depends on file name or inode number), simply check for the correct number of files"
	jsonFiles := db childrenMatching: '*.lepiter'.
	duplicateFiles := db childrenMatching: '*.duplicate'.
	self assert: jsonFiles size equals: 1.
	self assert: duplicateFiles size equals: 1
]

{ #category : #examples }
LeDatabaseExamples >> corruptionReloadDuplicatePageFromClass [
	"Check that pages with duplicate names are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabaseExamples>
	| page snippet pageSource |
	EpMonitor
		disableDuring: [ [ database := LeDatabaseClassStoreLoad
					newDbOnClass: self dbClassName
					package: self dbPackageName
					saveDelay: Duration zero.
			page := LePage named: #Page1.
			snippet := LeTextSnippet string: #Snippet1.
			page addSnippet: snippet.
			database addPage: page.
			self assert: (database hasPageNamed: #Page1).
			self deny: database monitor hasCorruptPages.
			pageSource := (database monitor dbClass class
					>> (database monitor storage pageSelectorFor: page)) sourceCode.
			pageSource := 'page_Dup' , (pageSource copyFrom: 6 to: pageSource size).
			database monitor dbClass class
				compile: pageSource
				classified: 'test duplicate'.
			self should: [ database monitor reload ] raise: LeDBLoadError.
			self assert: database monitor hasCorruptPages.
			self assert: database pages size equals: 1.
			self assert: database monitor corruptSelectors size equals: 1 ]
				ensure: [ self class environment
						at: self dbClassName
						ifPresent: [ :cls | cls removeFromSystem ] ] ]
]

{ #category : #examples }
LeDatabaseExamples >> corruptionReloadDuplicatePageFromLocal [
	"Check that pages with duplicate names are signalled and renamed"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabaseExamples>
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
	self deny: database monitor hasCorruptPages.
	corruptFile := db / 'duplicate.lepiter'.
	pageFile copyTo: corruptFile.
	self should: [ database monitor reload ] raise: LeDBLoadError.
	self assert: database monitor hasCorruptPages.	"Which of the two files is marked corrupt is non-deterministic (depends on file name or inode number), simply check for the correct number of files"
	jsonFiles := db childrenMatching: '*.lepiter'.
	corruptFiles := db childrenMatching: '*.corrupt'.
	self assert: jsonFiles size equals: 1.
	self assert: corruptFiles size equals: 1
]

{ #category : #private }
LeDatabaseExamples >> dbClassName [

	^ #LeDatabaseExamplesClassStore
]

{ #category : #private }
LeDatabaseExamples >> dbPackageName [

	^ #LeDatabaseExamplesClassStore
]

{ #category : #examples }
LeDatabaseExamples >> pageWithID [
	"Demonstrate retrieving pages of various types by ID"

	<gtExample>
	<after: #cleanUp>
	<return: #LeDatabase>
	| page namedPageUID pharoClassPageUID unnamedPageUID flag |
	database := LeDatabase new.

	page := LePage named: #'Named Page'.
	database addPage: page.
	namedPageUID := page uid.

	page := LePage pharoClassName: self class name.
	database addPage: page.
	pharoClassPageUID := page uid.

	page := LePage unnamedPage.
	database addPage: page.
	unnamedPageUID := page uid.

	{namedPageUID.
		pharoClassPageUID.
		unnamedPageUID}
		do: [ :uid | 
			self assert: (database pageWithID: uid) uid equals: uid.

			self
				assert: (database pageWithID: uid ifAbsent: [ self error: 'Test page not found' ]) uid
				equals: uid.

			database
				pageWithID: uid
				ifPresent: [ :aPage | self assert: aPage uid equals: uid ]
				ifAbsent: [ self error: 'Test page not found' ] ].

	self should: [ database pageWithID: nil ] raise: NotFound.
	flag := false.
	database pageWithID: nil ifAbsent: [ flag := true ].
	self assert: flag.
	flag := false.
	database
		pageWithID: nil
		ifPresent: [ :aPage | self error: aPage asString ]
		ifAbsent: [ flag := true ].
	self assert: flag.

	^ database
]
