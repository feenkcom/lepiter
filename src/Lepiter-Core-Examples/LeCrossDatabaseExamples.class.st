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

{ #category : #examples }
LeCrossDatabaseExamples >> addingTheMissingPageResolvesTheCrossDatabaseLink [
	"Adding the missing page to the primary DB resolves the link to the primary DB, but not the local link of the playground DB"
	<gtExample>
	<after: #stopMonitoringDatabases>
	<return: #LeLogicalDatabase>
	| aTargetPage |
	self databaseWithCrossDatabaseLinkToMissingPage.
	aTargetPage := primaryDatabase
				addPage: (LePage named: self missingPageTitle).
	self assert: self linkToMissingPage targetReference content == aTargetPage.
	self assert: aTargetPage incomingLinks size equals: 1.
	self assert: aTargetPage incomingLinks first == self linkToMissingPage.
	self assert: self localLinkToMissingPage targetReference isResolved not.
	^logicalDB
]

{ #category : #examples }
LeCrossDatabaseExamples >> addingTheMissingPageToTheOtherDatabaseResolvesOnlyTheLocalLink [
	"A page with the same title in the playground DB resolves the local link, but not the link to the primary DB"
	<gtExample>
	<after: #stopMonitoringDatabases>
	<return: #LeLogicalDatabase>
	| aPage |
	self databaseWithCrossDatabaseLinkToMissingPage.
	aPage := playgroundDatabase addPage: (LePage named: self missingPageTitle).
	self assert: self localLinkToMissingPage targetReference content == aPage.
	self assert: aPage incomingLinks size equals: 1.
	self assert: aPage incomingLinks first == self localLinkToMissingPage.
	self assert: self linkToMissingPage targetReference isResolved not.
	^logicalDB
]

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
LeCrossDatabaseExamples >> databaseWithCrossDatabaseLinkToMissingPage [
	"Answer a LeLogicalDatabase whose playground DB links to a page that does not exist yet, once to the primary DB and once to itself"
	<gtExample>
	<after: #stopMonitoringDatabases>
	<return: #LeLogicalDatabase>
	| aSourcePage |
	self createDatabases.
	self populateDatabases.
	aSourcePage := playgroundDatabase pageNamed: #'DB2 Page1'.
	aSourcePage addSnippet: (LeTextSnippet
				string: '{{gtPage:' , self missingPageTitle , '|db='
						, primaryDatabase uuidString , '}}').
	aSourcePage
		addSnippet: (LeTextSnippet string: '[[' , self missingPageTitle , ']]').
	self assert: self linkToMissingPage targetReference isResolved not.
	self assert: self localLinkToMissingPage targetReference isResolved not.
	^logicalDB
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
LeCrossDatabaseExamples >> linkToMissingPage [
	^playgroundDatabase explicitLinks items detect: 
			[:each |
			each targetReference pageTitle = self missingPageTitle
				and: [each targetReference targetDatabaseUUID = primaryDatabase uuidString]]
]

{ #category : #private }
LeCrossDatabaseExamples >> localLinkToMissingPage [
	^playgroundDatabase explicitLinks items detect: 
			[:each |
			each targetReference pageTitle = self missingPageTitle
				and: [each targetReference targetDatabaseUUID isNil]]
]

{ #category : #private }
LeCrossDatabaseExamples >> missingPageTitle [
	^'DB1 Page2'
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

{ #category : #examples }
LeCrossDatabaseExamples >> renamingAPageToTheMissingTitleResolvesTheCrossDatabaseLink [
	"Renaming a page of the primary DB to the missing title resolves the link to the primary DB, but not the local link of the playground DB"
	<gtExample>
	<after: #stopMonitoringDatabases>
	<return: #LeLogicalDatabase>
	| aPage |
	self databaseWithCrossDatabaseLinkToMissingPage.
	aPage := primaryDatabase addPage: (LePage named: 'DB1 Other').
	self assert: aPage incomingLinks isEmpty.
	aPage updateTitle: self missingPageTitle.
	self assert: self linkToMissingPage targetReference content == aPage.
	self assert: aPage incomingLinks size equals: 1.
	self assert: aPage incomingLinks first == self linkToMissingPage.
	self assert: self localLinkToMissingPage targetReference isResolved not.
	^logicalDB
]

{ #category : #after }
LeCrossDatabaseExamples >> stopMonitoringDatabases [
	primaryDatabase ifNotNil: [:aDatabase | aDatabase stopMonitoring].
	playgroundDatabase ifNotNil: [:aDatabase | aDatabase stopMonitoring]
]
