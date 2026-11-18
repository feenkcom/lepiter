"
I present the memory used by a Lepiter logical database. A logical database only groups other databases, so I estimate each contained database with a {{gtClass:GtLepiterDatabaseMemoryMetrics}}, and show the results side by side and added together.

Each database is estimated separately. Objects shared by several databases are then counted once per database; in the default logical database this is about 0.1% of the total, so it is ignored.

Use {{gtClass:GtLepiterMemoryMetrics}} for the cached metrics of the default logical database.
"
Class {
	#name : #GtLepiterLogicalDatabaseMemoryMetrics,
	#superclass : #Object,
	#instVars : [
		'logicalDatabase',
		'databasesMetrics',
		'combinedEstimate'
	],
	#category : #'Lepiter-MemoryMetrics'
}

{ #category : #'instance creation' }
GtLepiterLogicalDatabaseMemoryMetrics class >> forLogicalDatabase: aLogicalDatabase [
	^ self new
		logicalDatabase: aLogicalDatabase;
		compute;
		yourself
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> combinedEstimate [
	"The estimates of all databases added together"

	^ combinedEstimate
		ifNil: [ combinedEstimate := GtMemorySpaceEstimate new.
			self databasesMetrics
				do: [ :each | combinedEstimate addEstimate: each estimate ].
			combinedEstimate ]
]

{ #category : #metrics }
GtLepiterLogicalDatabaseMemoryMetrics >> computationTime [
	^ self databasesMetrics
		inject: Duration zero
		into: [ :sum :each | sum + each computationTime ]
]

{ #category : #computing }
GtLepiterLogicalDatabaseMemoryMetrics >> compute [
	"Estimate each database contained in the logical database"

	databasesMetrics := logicalDatabase databases asArray
			collect: [ :aDatabase | GtLepiterDatabaseMemoryMetrics forDatabase: aDatabase ].
	combinedEstimate := nil
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> databasesMetrics [
	"The metrics of each contained database (GtLepiterDatabaseMemoryMetrics)"

	^ databasesMetrics ifNil: [ #() ]
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> gtBookMetrics [
	"The GT Book is the only database saved in the image"

	^ self databasesMetrics detect: [ :each | each isGtBook ] ifNone: [ nil ]
]

{ #category : #'gt - extensions' }
GtLepiterLogicalDatabaseMemoryMetrics >> gtViewCategoriesFor: aView [
	"The size of each category in all databases, and in each database"

	<gtView>
	| aList |
	aList := aView columnedList
			title: 'Categories';
			priority: 20;
			items: [ self combinedEstimate sortedCategoryEstimates ];
			column: 'Category'
				text: [ :each | each name ]
				width: 200;
			column: 'All databases'
				text: [ :each | each bytes humanReadableIsqByteSize ]
				width: 110.
	self databasesMetrics
		do: [ :aDatabaseMetrics | 
			aList
				column: aDatabaseMetrics databaseName
				text: [ :each | (aDatabaseMetrics sizeOfCategory: each category) humanReadableIsqByteSize ]
				width: 180 ].
	^ aList
]

{ #category : #'gt - extensions' }
GtLepiterLogicalDatabaseMemoryMetrics >> gtViewDatabasesFor: aView [
	"Each contained database; inspecting one shows its content"

	<gtView>
	^ aView columnedList
		title: 'Databases';
		priority: 10;
		items: [ self databasesMetrics ];
		column: 'Database' text: [ :each | each databaseName ];
		column: 'Role'
			text: [ :each | self roleOf: each ]
			width: 80;
		column: 'In saved image'
			text: [ :each | each isGtBook ifTrue: [ 'yes' ] ifFalse: [ 'no' ] ]
			width: 100;
		column: 'Storage'
			text: [ :each | each storageKind ]
			width: 70;
		column: 'Pages'
			text: [ :each | each pagesCount ]
			width: 60;
		column: 'Snippets'
			text: [ :each | each snippetsCount ]
			width: 70;
		column: 'Size'
			text: [ :each | each totalSize humanReadableIsqByteSize ]
			width: 90;
		column: '%'
			text: [ :each | (each totalSize * 100 / (self totalSize max: 1)) rounded asString , '%' ]
			width: 50
]

{ #category : #'gt - extensions' }
GtLepiterLogicalDatabaseMemoryMetrics >> gtViewSummaryFor: aView [
	<gtView>
	logicalDatabase ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Summary';
		priority: 5;
		items: [ self summaryItems ];
		column: 'Property'
			text: [ :each | each first ]
			width: 200;
		column: 'Value' text: [ :each | each second ];
		send: [ :each | each third ]
]

{ #category : #'gt - extensions' }
GtLepiterLogicalDatabaseMemoryMetrics >> gtViewTagsFor: aView [
	"The size of the objects with each tag in all databases, and in each database"

	<gtView>
	| aList |
	aList := aView columnedList
			title: 'Tags';
			priority: 30;
			items: [ self combinedEstimate sortedTagEstimates ];
			column: 'Tag'
				text: [ :each | each tagName ]
				width: 200;
			column: 'All databases'
				text: [ :each | each bytes humanReadableIsqByteSize ]
				width: 110.
	self databasesMetrics
		do: [ :aDatabaseMetrics | 
			aList
				column: aDatabaseMetrics databaseName
				text: [ :each | (aDatabaseMetrics sizeOfTag: each tagName) humanReadableIsqByteSize ]
				width: 180 ].
	^ aList
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> logicalDatabase [
	^ logicalDatabase
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> logicalDatabase: aLogicalDatabase [
	logicalDatabase := aLogicalDatabase
]

{ #category : #metrics }
GtLepiterLogicalDatabaseMemoryMetrics >> objectsCount [
	^ self databasesMetrics
		inject: 0
		into: [ :sum :each | sum + each objectsCount ]
]

{ #category : #metrics }
GtLepiterLogicalDatabaseMemoryMetrics >> pagesCount [
	^ self databasesMetrics inject: 0 into: [ :sum :each | sum + each pagesCount ]
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> primaryDatabaseMetrics [
	^ self databasesMetrics
		detect: [ :each | each database == logicalDatabase primaryDB ]
		ifNone: [ nil ]
]

{ #category : #printing }
GtLepiterLogicalDatabaseMemoryMetrics >> printOn: aStream [
	super printOn: aStream.
	databasesMetrics ifNil: [ ^ self ].
	aStream
		nextPut: $(;
		print: databasesMetrics size;
		nextPutAll: ' databases: ';
		nextPutAll: self totalSize humanReadableIsqByteSize;
		nextPut: $)
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> roleOf: aDatabaseMetrics [
	"How the logical database uses the database"

	aDatabaseMetrics database == logicalDatabase primaryDB ifTrue: [ ^ 'primary' ].
	aDatabaseMetrics database == logicalDatabase playgroundDB
		ifTrue: [ ^ 'playground' ].
	^ 'registered'
]

{ #category : #metrics }
GtLepiterLogicalDatabaseMemoryMetrics >> snippetsCount [
	^ self databasesMetrics
		inject: 0
		into: [ :sum :each | sum + each snippetsCount ]
]

{ #category : #accessing }
GtLepiterLogicalDatabaseMemoryMetrics >> summaryItems [
	"Rows of the summary: a label, a value to display, and the object to inspect"

	^ {{'Primary database'.
			self primaryDatabaseMetrics
				ifNil: [ '' ]
				ifNotNil: [ :aMetrics | aMetrics databaseName ].
			self primaryDatabaseMetrics}.
		{'Databases'.
			self databasesMetrics size printString.
			self databasesMetrics}.
		{'Pages'.
			self pagesCount printString.
			self pagesCount}.
		{'Snippets'.
			self snippetsCount printString.
			self snippetsCount}.
		{'Objects'.
			self objectsCount printString.
			self objectsCount}.
		{'Total size'.
			self totalSize humanReadableIsqByteSize.
			self combinedEstimate}.
		{'Saved in the image (GT Book)'.
			self totalGtBookSize humanReadableIsqByteSize.
			self gtBookMetrics}.
		{'Computation time'.
			self computationTime printString.
			self computationTime}}
]

{ #category : #metrics }
GtLepiterLogicalDatabaseMemoryMetrics >> totalGtBookSize [
	"The part saved in the image"

	^ self gtBookMetrics ifNil: [ 0 ] ifNotNil: [ :aMetrics | aMetrics totalSize ]
]

{ #category : #metrics }
GtLepiterLogicalDatabaseMemoryMetrics >> totalSize [
	"All contained databases, including the ones loaded at startup"

	^ self databasesMetrics inject: 0 into: [ :sum :each | sum + each totalSize ]
]
