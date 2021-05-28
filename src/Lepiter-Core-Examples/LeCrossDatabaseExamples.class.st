Class {
	#name : #LeCrossDatabaseExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'fileSystem',
		'db1',
		'db2',
		'logicalDB'
	],
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #private }
LeCrossDatabaseExamples >> createDatabases [
	"Create the two empty databases ready to populate"
	| db1Dir db2Dir |

	fileSystem := FileSystem memory.

	db1Dir := fileSystem root / 'db1'.
	db1Dir ensureCreateDirectory.
	db1 := LeLocalStoreLoad current loadAndMonitorFrom: db1Dir.

	db2Dir := fileSystem root / 'db2'.
	db2Dir ensureCreateDirectory.
	db2 := LeLocalStoreLoad current loadAndMonitorFrom: db2Dir.

	logicalDB := LeLogicalDatabase primaryDB: db1 playgroundDB: db2.
]

{ #category : #examples }
LeCrossDatabaseExamples >> databaseWithCrossReferences [
	"Answer a LeLogicalDatabase with primary and workspace DBs with cross-database references"
	<gtExample>
	| links link targetPage |

	self createDatabases.
	self populateDatabases.

	self assert: logicalDB pageCount equals: 2.
	self assert: logicalDB playgroundDB equals: db2.

	links := ((db2 pageNamed: #'DB2 Page1') children at: 2) outgoingExplicitLinks.
	self assert: links size equals: 1.
	link := links first.
	targetPage := db1 pageNamed: #'DB1 Page1'.
	self assert: link isTextualPageLink.
	self assert: link targetDatabaseUUID equals: db1 uuidString.
	self assert: link target equals: targetPage.
	self assert: targetPage incomingLinks size equals: 1.

	^ logicalDB
]

{ #category : #private }
LeCrossDatabaseExamples >> populateDatabases [
	"Add pages to the databases with cross references"

	| page |
	page := LePage named: #'DB1 Page1'.
	page addSnippet: (LeTextSnippet string: #'DB1 Page1 Block1').
	db1 addPage: page.
	page := LePage named: #'DB2 Page1'.
	page addSnippet: (LeTextSnippet string: #'DB2 Page1 Block1').
	page
		addSnippet:
			(LeTextSnippet
				string: '{{gtPage:DB1 Page1|db=' , db1 uuidString , '}}').
	db2 addPage: page
]
