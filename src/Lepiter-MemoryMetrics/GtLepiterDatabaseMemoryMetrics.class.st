"
I present the memory used by a Lepiter database: a summary, the size of each category, and how memory is attributed to categories.

I do not decide how memory is counted. {{gtClass:GtLepiterDatabaseMemorySpaceDefinition}} declares the categories, the attributions, the roots and the boundary, and a {{gtClass:GtMemorySpaceEstimation}} computes the estimate.

For databases stored in a class, the pages are compiled as methods of the storage class; the JSON of pages is in method comments, so only in the source files. Those methods are part of the methods of the image, and are not included in my total.

Use {{gtClass:GtLepiterLogicalDatabaseMemoryMetrics}} for all databases of a logical database, and {{gtClass:GtLepiterMemoryMetrics}} for the default logical database.
"
Class {
	#name : #GtLepiterDatabaseMemoryMetrics,
	#superclass : #Object,
	#instVars : [
		'database',
		'estimation',
		'pagesCount',
		'snippetsCount'
	],
	#category : #'Lepiter-MemoryMetrics'
}

{ #category : #'instance creation' }
GtLepiterDatabaseMemoryMetrics class >> forDatabase: aDatabase [
	^ self new
		database: aDatabase;
		compute;
		yourself
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> categoryEstimates [
	"The estimate of each category, largest first"

	^ self estimate sortedCategoryEstimates
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> computationTime [
	^ estimation computationTime
]

{ #category : #computing }
GtLepiterDatabaseMemoryMetrics >> compute [
	estimation := GtLepiterDatabaseMemorySpaceDefinition default estimate: database.
	self computeCounts
]

{ #category : #computing }
GtLepiterDatabaseMemoryMetrics >> computeCounts [
	pagesCount := 0.
	snippetsCount := 0.
	database
		pagesDo: [ :aPage | 
			pagesCount := pagesCount + 1.
			aPage
				allChildrenDepthFirstDo: [ :aSnippet | snippetsCount := snippetsCount + 1 ] ]
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> database [
	^ database
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> database: aDatabase [
	database := aDatabase
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> databaseName [
	"Only databases with a monitor have a name (and a uuid); 
	databases created in memory are told apart by their identity hash"

	^ database databaseName
		ifNil: [ 'Unnamed database ' , database identityHash printString ]
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> definition [
	"How the memory of a database is estimated: categories, attributions, roots and boundary.
	After computing, the definition that was used, as categories are compared by identity."

	^ estimation
		ifNil: [ GtLepiterDatabaseMemorySpaceDefinition default ]
		ifNotNil: [ estimation definition ]
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> estimate [
	"The size of each category"

	^ estimation estimate
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> estimation [
	^ estimation
]

{ #category : #'gt - extensions' }
GtLepiterDatabaseMemoryMetrics >> gtViewAttributionsFor: aView [
	<gtView>
	^ aView forward
		title: 'Attributions';
		priority: 20;
		object: [ self definition ];
		view: #gtViewAttributionsFor:
]

{ #category : #'gt - extensions' }
GtLepiterDatabaseMemoryMetrics >> gtViewCategoriesFor: aView [
	<gtView>
	estimation ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Categories';
		priority: 10;
		object: [ self estimate ];
		view: #gtViewCategoriesFor:
]

{ #category : #'gt - extensions' }
GtLepiterDatabaseMemoryMetrics >> gtViewSummaryFor: aView [
	<gtView>
	estimation ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ self summaryItems ];
		column: 'Property'
			text: [ :each | each first ]
			width: 250;
		column: 'Value' text: [ :each | each second ];
		send: [ :each | each third ]
]

{ #category : #testing }
GtLepiterDatabaseMemoryMetrics >> isClassStore [
	^ database monitor notNil and: [ database monitor isClassStore ]
]

{ #category : #testing }
GtLepiterDatabaseMemoryMetrics >> isGtBook [
	^ self databaseName = LeDatabase gtBookName
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> objectsCount [
	^ estimation objectsCount
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> pagesCount [
	^ pagesCount
]

{ #category : #printing }
GtLepiterDatabaseMemoryMetrics >> printOn: aStream [
	super printOn: aStream.
	database ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		nextPutAll: self databaseName.
	estimation
		ifNotNil: [ aStream
				nextPutAll: ': ';
				nextPutAll: self totalSize humanReadableIsqByteSize ].
	aStream nextPut: $)
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> sizeOfCategory: aCategory [
	^ self estimate bytesOf: aCategory
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> sizeOfTag: aTagName [
	^ self estimate bytesOfTag: aTagName
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> smaccSize [
	"Size of all SmaCC objects (nodes, tokens, intervals, scanner states), without the collections and strings they reference"

	^ self sizeOfTag: #smacc
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> snippetsCount [
	^ snippetsCount
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> storageClassMethods [
	"For databases stored in a class, the methods storing pages and attachments.
	They are part of the methods of the image."

	self isClassStore ifFalse: [ ^ #() ].
	^ database monitor dbClass
		ifNil: [ #() ]
		ifNotNil: [ :aClass | aClass classSide methods ]
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> storageClassMethodsSize [
	^ self storageClassMethods
		inject: 0
		into: [ :sum :aMethod | sum + aMethod gtSpecificSizeInMemory ]
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> storageDescription [
	^ database monitor
		ifNil: [ 'in memory' ]
		ifNotNil: [ :aMonitor | 
			aMonitor storeLocation
				ifNil: [ 'in memory' ]
				ifNotNil: [ :aLocation | aLocation asString ] ]
]

{ #category : #testing }
GtLepiterDatabaseMemoryMetrics >> storageKind [
	"How the pages are stored: in files, in a class, or only in memory"

	database monitor ifNil: [ ^ 'memory' ].
	^ self isClassStore ifTrue: [ 'class' ] ifFalse: [ 'files' ]
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> stringsSize [
	"Size of all strings in the database"

	^ self sizeOfTag: #string
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> summaryItems [
	"Rows of the summary: a label, a value to display, and the object to inspect"

	| items |
	items := OrderedCollection new.
	items
		add: {'Database'.
				self databaseName.
				database};
		add: {'Storage'.
				self storageDescription.
				database monitor};
		add: {'Pages'.
				self pagesCount printString.
				self pagesCount};
		add: {'Snippets'.
				self snippetsCount printString.
				self snippetsCount};
		add: {'Objects'.
				self objectsCount printString.
				estimation estimator};
		add: {'Total size'.
				self totalSize humanReadableIsqByteSize.
				self estimate};
		add: {'Strings in the text of snippets'.
				self textStringsSize humanReadableIsqByteSize.
				self textStringsSize};
		add: {'All strings'.
				self stringsSize humanReadableIsqByteSize.
				self estimate tagEstimateFor: #string};
		add: {'All SmaCC objects'.
				self smaccSize humanReadableIsqByteSize.
				self estimate tagEstimateFor: #smacc}.
	self isClassStore
		ifTrue: [ items
				add: {'Storage class methods (part of the methods of the image)'.
						self storageClassMethodsSize humanReadableIsqByteSize , ' for '
							, self storageClassMethods size asString , ' methods'.
						self storageClassMethods} ].
	items
		add: {'Computation time'.
				self computationTime printString.
				self computationTime}.
	^ items
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> textStringsSize [
	"Size of the strings in the text of snippets"

	^ self estimate bytesOf: (self definition category: #text) tag: #string
]

{ #category : #accessing }
GtLepiterDatabaseMemoryMetrics >> totalSize [
	^ estimation totalBytes
]
