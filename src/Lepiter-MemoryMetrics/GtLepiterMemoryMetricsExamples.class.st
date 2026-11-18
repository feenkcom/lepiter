"
I show and check the memory metrics of Lepiter databases ({{gtClass:GtLepiterDatabaseMemoryMetrics}}) and logical databases ({{gtClass:GtLepiterLogicalDatabaseMemoryMetrics}}), on small databases created in memory.

The checks are not precise: they catch errors, check that the main categories receive memory and that totals add up, and that all views of the reports can be computed.
"
Class {
	#name : #GtLepiterMemoryMetricsExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-MemoryMetrics'
}

{ #category : #private }
GtLepiterMemoryMetricsExamples >> assertViewsOf: anObject [
	"Assert that all views of anObject can be computed without errors"

	| aCheck |
	aCheck := GtMemorySpaceViewsCheck forObject: anObject.
	self assert: aCheck hasErrors not description: [ aCheck errorsDescription ].
	^ aCheck
]

{ #category : #'examples - databases' }
GtLepiterMemoryMetricsExamples >> databaseMetrics [
	"The memory of a database with two pages, each with three snippets"

	<gtExample>
	<return: #GtLepiterDatabaseMemoryMetrics>
	| aDatabase aMetrics |
	aDatabase := self databaseWithPages.

	aMetrics := GtLepiterDatabaseMemoryMetrics forDatabase: aDatabase.

	self assert: aMetrics database identicalTo: aDatabase.
	self assert: aMetrics pagesCount equals: 2.
	self assert: aMetrics snippetsCount equals: 6.
	self assert: aMetrics objectsCount > 0.
	self assert: aMetrics totalSize > 0.
	self assert: aMetrics totalSize equals: aMetrics estimate totalBytes.
	self
		assert: (aMetrics categoryEstimates inject: 0 into: [ :aSum :each | aSum + each bytes ])
		equals: aMetrics totalSize.
	#(#pagesAndSnippets #text #textASTs #codeSource #links #times #uidsAndEmails #databaseStructures)
		do: [ :aKey | 
			self
				assert: (aMetrics sizeOfCategory: (aMetrics definition category: aKey)) > 0
				description: [ 'No memory in the category ' , aKey ] ].
	self assert: aMetrics textStringsSize > 0.
	self assert: aMetrics stringsSize >= aMetrics textStringsSize.
	self assert: aMetrics smaccSize > 0.

	self assert: aMetrics definition identicalTo: aMetrics estimation definition.
	self deny: aMetrics isGtBook.
	self deny: aMetrics isClassStore.
	self assert: aMetrics storageKind equals: 'memory'.
	self assert: aMetrics storageClassMethods isEmpty.
	self assert: (aMetrics databaseName beginsWith: 'Unnamed database').
	self assert: (aMetrics printString includesSubstring: aMetrics databaseName).

	self assertViewsOf: aMetrics.
	^ aMetrics
]

{ #category : #'examples - databases' }
GtLepiterMemoryMetricsExamples >> databaseMetricsBeforeComputing [
	"Metrics that were not computed have empty views"

	<gtExample>
	<return: #GtLepiterDatabaseMemoryMetrics>
	| aMetrics |
	aMetrics := GtLepiterDatabaseMemoryMetrics new database: self databaseWithPages.

	self assert: aMetrics estimation isNil.
	self assertViewsOf: aMetrics.
	^ aMetrics
]

{ #category : #'examples - databases' }
GtLepiterMemoryMetricsExamples >> databaseWithPages [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := self
			databaseWithPagesTitled: #('First memory page' 'Second memory page').

	self assert: aDatabase pageCount equals: 2.
	^ aDatabase
]

{ #category : #private }
GtLepiterMemoryMetricsExamples >> databaseWithPagesTitled: aCollectionOfTitles [
	"A database in memory with, on each page, a text snippet with a link and a child snippet, and a Pharo snippet"

	| aDatabase |
	aDatabase := LeDatabase new.
	aCollectionOfTitles
		do: [ :aTitle | 
			| aPage aTextSnippet |
			aPage := LePage named: aTitle.
			aTextSnippet := LeTextSnippet
					string: 'The text of ' , aTitle , ', with a link to [[' , aTitle , ']]'.
			aTextSnippet
				addSnippet: (LeTextSnippet string: 'A child snippet of ' , aTitle).
			aPage
				addSnippet: aTextSnippet;
				addSnippet: (LePharoSnippet code: '3 + 4').
			aDatabase addPage: aPage ].
	^ aDatabase
]

{ #category : #'examples - databases' }
GtLepiterMemoryMetricsExamples >> emptyDatabaseMetrics [
	"A database without pages only has its own structures"

	<gtExample>
	<return: #GtLepiterDatabaseMemoryMetrics>
	| aMetrics |
	aMetrics := GtLepiterDatabaseMemoryMetrics forDatabase: LeDatabase new.

	self assert: aMetrics pagesCount equals: 0.
	self assert: aMetrics snippetsCount equals: 0.
	self assert: aMetrics totalSize > 0.
	self
		assert: (aMetrics sizeOfCategory: (aMetrics definition category: #pagesAndSnippets))
		equals: 0.
	self assert: aMetrics textStringsSize equals: 0.

	self assertViewsOf: aMetrics.
	^ aMetrics
]

{ #category : #'examples - definition' }
GtLepiterMemoryMetricsExamples >> lepiterDefinition [
	"How the memory of Lepiter databases is estimated can be inspected without estimating anything"

	<gtExample>
	<return: #GtLepiterDatabaseMemorySpaceDefinition>
	| aDefinition aBoundary |
	aDefinition := GtLepiterDatabaseMemorySpaceDefinition new.

	self assert: aDefinition categories size equals: 16.
	self
		assert: (aDefinition rules collect: [ :each | each label ]) asArray
		equals: #('Pages and snippets' 'Database').
	self
		assert: (aDefinition rules
				inject: Set new
				into: [ :aSet :each | 
					aSet
						addAll: each attribution categories;
						yourself ])
		equals: aDefinition categories asSet.

	aBoundary := aDefinition newBoundary.
	self assert: (aBoundary shouldStopAtClass: LeTextSnippet).
	self assert: (aBoundary shouldStopAtClass: LeDatabase).
	self assert: (aBoundary tagForClass: ByteString) name equals: #string.
	self assert: (aBoundary tagForClass: SmaCCToken) name equals: #smacc.

	self assertViewsOf: aDefinition.
	aDefinition rules
		do: [ :each | 
			self assertViewsOf: each.
			self assertViewsOf: each attribution ].
	^ aDefinition
]

{ #category : #'examples - logical databases' }
GtLepiterMemoryMetricsExamples >> logicalDatabase [
	"A logical database with a primary database and another registered database"

	<gtExample>
	<return: #LeLogicalDatabase>
	| aLogicalDatabase |
	aLogicalDatabase := LeLogicalDatabase new
			primaryDB: (self databaseWithPagesTitled: #('Primary memory page'));
			yourself.
	aLogicalDatabase
		addDB: (self
				databaseWithPagesTitled: #('First registered page' 'Second registered page')).

	self assert: aLogicalDatabase databases size equals: 2.
	^ aLogicalDatabase
]

{ #category : #'examples - logical databases' }
GtLepiterMemoryMetricsExamples >> logicalDatabaseMetrics [
	"A logical database only contains other databases; each one is estimated, and the results are added"

	<gtExample>
	<return: #GtLepiterLogicalDatabaseMemoryMetrics>
	| aLogicalDatabase aMetrics |
	aLogicalDatabase := self logicalDatabase.

	aMetrics := GtLepiterLogicalDatabaseMemoryMetrics
			forLogicalDatabase: aLogicalDatabase.

	self assert: aMetrics databasesMetrics size equals: 2.
	self
		assert: (aMetrics databasesMetrics collect: [ :each | each database ]) asArray
		equals: aLogicalDatabase databases asArray.
	self
		assert: (aMetrics databasesMetrics collect: [ :each | aMetrics roleOf: each ]) asArray
		equals: #('primary' 'registered').
	self
		assert: aMetrics primaryDatabaseMetrics database
		identicalTo: aLogicalDatabase primaryDB.
	self assert: aMetrics pagesCount equals: 3.
	self assert: aMetrics snippetsCount equals: 9.
	self
		assert: aMetrics totalSize
		equals: (aMetrics databasesMetrics
				inject: 0
				into: [ :aSum :each | aSum + each totalSize ]).
	self assert: aMetrics combinedEstimate totalBytes equals: aMetrics totalSize.
	self assert: aMetrics combinedEstimate identicalTo: aMetrics combinedEstimate.
	self
		assert: aMetrics objectsCount
		equals: (aMetrics databasesMetrics
				inject: 0
				into: [ :aSum :each | aSum + each objectsCount ]).
	self assert: aMetrics gtBookMetrics isNil.
	self assert: aMetrics totalGtBookSize equals: 0.

	self assertViewsOf: aMetrics.
	aMetrics databasesMetrics do: [ :each | self assertViewsOf: each ].
	^ aMetrics
]

{ #category : #'examples - logical databases' }
GtLepiterMemoryMetricsExamples >> logicalDatabaseMetricsBeforeComputing [
	"Metrics that were not computed have no databases, and their views can still be computed"

	<gtExample>
	<return: #GtLepiterLogicalDatabaseMemoryMetrics>
	| aMetrics |
	aMetrics := GtLepiterLogicalDatabaseMemoryMetrics new.

	self assert: aMetrics databasesMetrics isEmpty.
	self assert: aMetrics totalSize equals: 0.
	self assertViewsOf: aMetrics.
	^ aMetrics
]
