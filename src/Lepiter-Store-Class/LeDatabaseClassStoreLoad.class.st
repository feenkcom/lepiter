Class {
	#name : #LeDatabaseClassStoreLoad,
	#superclass : #LeDatabaseClassStore,
	#instVars : [
		'duplicates',
		'corrupted'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #accessing }
LeDatabaseClassStoreLoad >> corrupted [
	^ corrupted
]

{ #category : #accessing }
LeDatabaseClassStoreLoad >> duplicates [
	^ duplicates
]

{ #category : #testing }
LeDatabaseClassStoreLoad >> hasCorruptedFiles [
	"Answer a boolean indicating whether any corrupted files were found.
	Only valid after loading the DB."

	^ corrupted isNotEmpty
]

{ #category : #testing }
LeDatabaseClassStoreLoad >> hasDuplicateFiles [
	"Answer a boolean indicating whether any duplicate files were found.
	Only valid after loading the DB."

	^ duplicates isNotEmpty
]

{ #category : #initialization }
LeDatabaseClassStoreLoad >> initialize [ 

	super initialize.
	duplicates := OrderedCollection new.
	corrupted := OrderedCollection new.
]

{ #category : #private }
LeDatabaseClassStoreLoad >> loadContentInDatabase: aDatabase [
	| pages explicitLinks |
	self assert: [ aDatabase explicitLinks notNil ].
	self assert: [ aDatabase explicitLinks uid isNil ].
	
	pages := self loadPages.
	explicitLinks := self loadExplicitLinks.
	
	"Before loading pages create the LeExplicitLink object with the
	same id as the one that is stored to disk. This is needed as setting pages 
	creates textual links that are added to storage."
	explicitLinks ifNotNil: [ 
		self assert: [ explicitLinks uid notNil ].
		aDatabase explicitLinks uid: explicitLinks uid ].
	
	aDatabase setPages: pages.
	explicitLinks ifNotNil: [ 
		aDatabase setExplicitLinks: explicitLinks ].
]

{ #category : #private }
LeDatabaseClassStoreLoad >> loadExplicitLinks [
	"Load all the explicit links from the receiver's class"
	| method |

	method := dbClass class methodDict
		at: #links
		ifAbsent: [ ^ nil ].
	^ [ storage loadFromMethod: method ]
		on: LeDBLoadError 
		fork: [ :ex | ex pass ].
]

{ #category : #private }
LeDatabaseClassStoreLoad >> loadExplicitLinksIn: aRootFolder [	
	
	storage withExplicitLinksFileIn: aRootFolder do: [ :aFile |
		[ ^ storage loadFromFile: aFile ] 
			on: LeDBLoadError 
			fork: [ :ex | ex pass ] ].
	^ nil
]

{ #category : #private }
LeDatabaseClassStoreLoad >> loadFrom: aSymbol package: aString [
	"Answer a LeDirectory with its pages loaded from the specified class.
	This is only used for testing as it answers a LeDatabase without a monitor, which means that any functionality that relies on properties, attachments, saving, etc. will fail."

	self dbClassName: aSymbol package: aString.
	storage updateDbStore: self.
	self preloadScript ifNotNil: 
		[ :script | script fileIn ].

	database := LeDatabase new.
	self loadDatabasePropertiesIn: database.
	self loadContentInDatabase: database.

	^ database
]

{ #category : #private }
LeDatabaseClassStoreLoad >> loadFrom: aSymbol package: aString saveDelay: aDuration [
	"Answer a LeDirectory with its pages loaded from the specified class.
	This is only used for testing as it answers a LeDatabase without a monitor, which means that any functionality that relies on properties, attachments, saving, etc. will fail."
	| monitor |

	self loadFrom: aSymbol package: aString.
	monitor := LeDatabaseClassStoreMonitor new.
	monitor 
		dbClass: dbClass;
		storage: storage;
		database: database.
	database monitor: monitor.
	aDuration ifNotNil: [ monitor saveDelay: aDuration ].
	monitor startMonitoring.

	^ database
]

{ #category : #loading }
LeDatabaseClassStoreLoad >> loadPageFrom: aFileReference [
	"Load a single page from the supplied file"

	^ storage loadFromFile: aFileReference
]

{ #category : #private }
LeDatabaseClassStoreLoad >> loadPages [
	"Load all the pages from the receiver's class.
	If a duplicate uid is found, raise a signal.  The exception handler can take action and decide whether to continue"
	| pages page pageIds file |

	pageIds := Set new.
	pages := OrderedCollection new.
	(storage pageSelectorsIn: dbClass) do: [ :selector |
		[ page := storage loadFromMethod: (dbClass class methodDict at: selector).
		(pageIds includes: page uid) ifTrue: 
			[ storage renameAsDuplicate: selector in: dbClass.
			duplicates add: selector ]
		ifFalse:
			[ pageIds add: page uid.
			pages add: page ] ]
				on: LeDBLoadError 
				fork: [ :ex | 
					corrupted add: file.
					ex pass ] ].
	^ pages reject: #isNil
]

{ #category : #private }
LeDatabaseClassStoreLoad >> loadPagesIn: aRootFolder [
	"Load all the pages from the supplied directory.
	If a duplicate uid is found, raise a signal.  The exception handler can take action and decide whether to continue"
	| pages page pageIds |

	pageIds := Set new.
	pages := OrderedCollection new.
	(storage dbFilesIn: aRootFolder) do: [ :file |
		[ page := storage loadFromFile: file.
		(pageIds includes: page uid) ifTrue: 
			[ file renameTo: (file withExtension: 'duplicate') basename.
			duplicates add: file ]
		ifFalse:
			[ pageIds add: page uid.
			pages add: page ] ]
				on: LeDBLoadError 
				fork: [ :ex | 
					corrupted add: file.
					ex pass ] ].
	^ pages reject: #isNil
]

{ #category : #accessing }
LeDatabaseClassStoreLoad >> onlyLoadFrom: aFileReference [
	| monitor |

	self localRoot: aFileReference.
	monitor := LeLocalStoreMonitor new.
	monitor localRoot: localRoot.
	monitor storage: storage.
	
	database := LeDatabase new.
	database monitor: monitor.
	monitor database: database.
	self loadDatabasePropertiesIn: database.
	self loadContentInDatabase: database. 

	^ database
]

{ #category : #accessing }
LeDatabaseClassStoreLoad >> onlyLoadReadOnlyFrom: aFileReference [
	| monitor |

	self localRoot: aFileReference.
	monitor := LeLocalStoreMonitor new.
	monitor localRoot: localRoot.
	monitor storage: storage.
	
	database := LeDatabase new.
	database readOnly: true.
	database monitor: monitor.
	monitor database: database.
	self loadDatabasePropertiesIn: database.
	self loadContentInDatabase: database. 

	^ database
]
