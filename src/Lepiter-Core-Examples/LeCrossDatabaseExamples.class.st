Class {
	#name : #LeCrossDatabaseExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#instVars : [
		'fileSystem',
		'logicalDB',
		'primaryDatabase',
		'playgroundDatabase'
	],
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #private }
LeCrossDatabaseExamples >> createDatabases [
	"Create the two empty databases ready to populate"
	| primaryDatabaseDirectory playgroundDatabaseDirectory |

	fileSystem := FileSystem memory.

	primaryDatabaseDirectory := fileSystem root / 'db1'.
	primaryDatabaseDirectory ensureCreateDirectory.
	primaryDatabase := LeLocalStoreLoad current loadAndMonitorFrom: primaryDatabaseDirectory.

	playgroundDatabaseDirectory := fileSystem root / 'db2'.
	playgroundDatabaseDirectory ensureCreateDirectory.
	playgroundDatabase := LeLocalStoreLoad current loadAndMonitorFrom: playgroundDatabaseDirectory.

	logicalDB := LeLogicalDatabase primaryDB: primaryDatabase playgroundDB: playgroundDatabase.
]

{ #category : #examples }
LeCrossDatabaseExamples >> databaseWithCrossReferences [
	"Answer a LeLogicalDatabase with primary and workspace DBs with cross-database references"

	<gtExample>
	<return: #LeLogicalDatabase>
	| links link targetPage |
	self createDatabases.
	self populateDatabases.

	self assert: logicalDB pageCount equals: 2.
	self assert: logicalDB playgroundDB equals: playgroundDatabase.

	links := ((playgroundDatabase pageNamed: #'DB2 Page1') children at: 2)
			outgoingExplicitLinks.
	self assert: links size equals: 1.
	link := links first.
	targetPage := primaryDatabase pageNamed: #'DB1 Page1'.
	self assert: link isTextualPageLink.
	self assert: link targetDatabaseUUID equals: primaryDatabase uuidString.
	self assert: link target equals: targetPage.
	self assert: targetPage incomingLinks size equals: 1.

	^ logicalDB
]

{ #category : #private }
LeCrossDatabaseExamples >> populateDatabases [
	"Add pages to the databases with cross references"
	| pageOne pageTwo |
	
	pageOne := LePage named: #'DB1 Page1'.
	pageOne addSnippet: (LeTextSnippet string: #'DB1 Page1 Block1').
	primaryDatabase addPage: pageOne.
	
	pageTwo := LePage named: #'DB2 Page1'.
	pageTwo addSnippet: (LeTextSnippet string: #'DB2 Page1 Block1').
	pageTwo
		addSnippet:
			(LeTextSnippet
				string: '{{gtPage:DB1 Page1|db=' , primaryDatabase uuidString , '}}').
	playgroundDatabase addPage: pageTwo
]
