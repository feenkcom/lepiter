Class {
	#name : #LeLocalStoreLoad,
	#superclass : #LeLocalStore,
	#instVars : [
		'duplicates',
		'corrupted'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #accessing }
LeLocalStoreLoad >> corrupted [
	^ corrupted
]

{ #category : #accessing }
LeLocalStoreLoad >> duplicates [
	^ duplicates
]

{ #category : #testing }
LeLocalStoreLoad >> hasCorruptedFiles [
	"Answer a boolean indicating whether any corrupted files were found.
	Only valid after loading the DB."

	^ corrupted isNotEmpty
]

{ #category : #testing }
LeLocalStoreLoad >> hasDuplicateFiles [
	"Answer a boolean indicating whether any duplicate files were found.
	Only valid after loading the DB."

	^ duplicates isNotEmpty
]

{ #category : #initialization }
LeLocalStoreLoad >> initialize [ 

	super initialize.
	duplicates := OrderedCollection new.
	corrupted := OrderedCollection new.
]

{ #category : #loading }
LeLocalStoreLoad >> loadAndMonitorFrom: aFileReference [
	"Answer a LeLocalJSONStoreMonitor with its database loaded from the page files in aFileReference (directory)"

	^ self
		localRoot: aFileReference;
		loadAndMonitorWithDelay: nil
]

{ #category : #loading }
LeLocalStoreLoad >> loadAndMonitorFrom: aFileReference saveDelay: aDuration [
	"Answer a LeLocalStoreMonitor with its database loaded from the page files in aFileReference (directory)"

	^ self
		localRoot: aFileReference;
		loadAndMonitorWithDelay: aDuration
]

{ #category : #loading }
LeLocalStoreLoad >> loadAndMonitorWithDelay: aDuration [
	"Load the Lepiter database from the localRoot directory, start the monitor, and answer the database"
	| monitor |

	localRoot ensureCreateDirectory.
	monitor := LeLocalStoreMonitor new.
	monitor localRoot: localRoot.
	monitor storage: storage.
	aDuration ifNotNil: [ monitor saveDelay: aDuration ].
	storage updateDbStore: self.
	attachmentsDirectory ensureCreateDirectory.
	self preloadScript ifNotNil: 
		[ :script | script fileIn ].
	
	database := LeDatabase new.
	database monitor: monitor.
	monitor database: database.
	self loadDatabasePropertiesIn: database.
	self loadContentInDatabase: database. 
	
	database name: localRoot basename.
	monitor startMonitoring.
	^ database
]

{ #category : #private }
LeLocalStoreLoad >> loadContentInDatabase: aDatabase [
	| pages explicitLinks |
	self assert: [ aDatabase explicitLinks notNil ].
	self assert: [ aDatabase explicitLinks uid isNil ].
	
	pages := self loadPagesIn: localRoot.
	explicitLinks := self loadExplicitLinksIn: localRoot.
	
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
LeLocalStoreLoad >> loadExplicitLinksIn: aRootFolder [	
	
	storage withExplicitLinksFileIn: aRootFolder do: [ :aFile |
		[ ^ storage loadFromFile: aFile ] 
			on: LeDBLoadError 
			fork: [ :ex | ex pass ] ].
	^ nil
]

{ #category : #private }
LeLocalStoreLoad >> loadFrom: aFileReference [
	"Answer a LeDirectory with its pages loaded from the page files in aFileReference (directory).
	This is only used for testing as it answers a LeDatabase without a monitor, which means that any functionality that relies on properties, attachments, saving, etc. will fail."

	aFileReference ensureCreateDirectory.
	self localRoot: aFileReference.
	storage updateDbStore: self.
	attachmentsDirectory ensureCreateDirectory.
	self preloadScript ifNotNil: 
		[ :script | script fileIn ].
	
	database := LeDatabase new.
	self loadDatabasePropertiesIn: database.
	self loadContentInDatabase: database.

	^ database
]

{ #category : #loading }
LeLocalStoreLoad >> loadPageFrom: aFileReference [
	"Load a single page from the supplied file"

	^ storage loadFromFile: aFileReference
]

{ #category : #private }
LeLocalStoreLoad >> loadPagesIn: aRootFolder [
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
LeLocalStoreLoad >> onlyLoadFrom: aFileReference [
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
