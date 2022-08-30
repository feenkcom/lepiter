Class {
	#name : #LeBasicDatabaseReloadExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'temporaryDirectory'
	],
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #private }
LeBasicDatabaseReloadExamples >> createDatabase [
	| fileSystem db |

	fileSystem := FileSystem memory.
	db := self newDb: 'db1' root: fileSystem root.
	self populate: db.
	^ db

]

{ #category : #private }
LeBasicDatabaseReloadExamples >> createDatabaseOnDisk [
	| db |

	temporaryDirectory := FileReference newTempFilePrefix: self class name, '-' suffix: '-testDbs'.
	db := self newDb: 'db1' root: temporaryDirectory.
	self populate: db.
	
	^ db
]

{ #category : #private }
LeBasicDatabaseReloadExamples >> createDatabaseOnDiskWithFileLocatorRoot [
	| db |

	temporaryDirectory := FileReference 
		gtNewTempFileLocatorPrefix: self class name, '-' suffix: '-testDbs'.
	db := self newDb: 'db1' root: temporaryDirectory.
	self populate: db.
	
	^ db
]

{ #category : #private }
LeBasicDatabaseReloadExamples >> deleteTemporaryDirectory [

	temporaryDirectory ifNotNil: 	
		[ temporaryDirectory ensureDeleteAll ]
]

{ #category : #private }
LeBasicDatabaseReloadExamples >> newDb: dbName root: aFileReference [
	| dbDir database |

	dbDir := aFileReference / dbName.
	dbDir ensureCreateDirectory.
	database := LeLocalStoreLoad current loadAndMonitorFrom: dbDir saveDelay: 0 seconds.
	database userEmail: dbName,'@example.com'.
	^ database
]

{ #category : #private }
LeBasicDatabaseReloadExamples >> populate: aLeDatabase [
	| page |
	page := LePage named: #Page1.
	page addSnippet: (LeTextSnippet string: #Snippet1).
	aLeDatabase addPage: page.
	page := LePage named: #Page2.
	page addSnippet: (LeTextSnippet string: #Snippet2).
	page addSnippet: (LeTextSnippet string: #'4+3').
	aLeDatabase addPage: page.
	^ aLeDatabase
]
