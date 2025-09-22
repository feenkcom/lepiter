"
Similar to TDatabaseHolder, I add a database to a class, but instead of using storeString methods to create the pages, I copy existing database files to an in-memory database.

Since the source database does not have to be loaded, this can be used for:

- testing (mock databases)
- help databases (eg for Sceneries)
- slideshows (to replace the storeString methods)

NB: set or override `databaseName` and send `#initializeDatabase` to initialize the in0memory database.
NB: If the source database exists, use that instead of an in-memory copy.
See `LeInMemoryDatabaseHolderExamples>>#gtBookAsAnInMemoryDatabase` for an example of forcing the creation of an in-memory copy.
"
Trait {
	#name : #TLeInMemoryDatabaseHolder,
	#instVars : [
		'database',
		'databaseName'
	],
	#category : #'Lepiter-Core-Utility'
}

{ #category : #acccessing }
TLeInMemoryDatabaseHolder >> database [
	^ database
		ifNil: [ self initializeDatabase.
			database ]
]

{ #category : #accessing }
TLeInMemoryDatabaseHolder >> databaseName [
	^ databaseName
]

{ #category : #accessing }
TLeInMemoryDatabaseHolder >> databaseName: aDatabaseName [
	"A name like 'Glamorous Toolkit Book' or a path relative to `FileLocator gtResource`"
	databaseName := aDatabaseName
]

{ #category : #utility }
TLeInMemoryDatabaseHolder >> databaseNamed: aDatabaseName [
	"If there is a database registered underthis name, just return it."

	^ LeDatabase
		databaseNamed: aDatabaseName
		ifNone: [ self inMemoryDatabaseFor: (self folderForPath: aDatabaseName) ]
]

{ #category : #utility }
TLeInMemoryDatabaseHolder >> folderForPath: aPathString [
	^ ($/ split: aPathString)
		inject: FileLocator gtResource
		into: [ :path :part | path / part ifExists: #yourself ifAbsent: [ ^ nil ] ]
]

{ #category : #view }
TLeInMemoryDatabaseHolder >> gtDatabaseFor: aView [
	<gtView>
	database ifNil: [ ^ aView empty ].
	self database pages ifEmpty: [ ^ aView empty ].
	^ aView forward
		title: 'Database';
		priority: 90;
		object: [ self database ];
		view: #gtLiveFor:;
		actionUpdateButton
]

{ #category : #actions }
TLeInMemoryDatabaseHolder >> gtRefreshDatabaseActionFor: anAction [
	<gtAction>
	database ifNil: [ ^ anAction empty ].
	^ anAction explicit
		priority: 15;
		stencil: [ | button |
			button := BrButton new
					"id: GtInspectorInspectButtonId;"
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: BrGlamorousIcons refresh;
					label: 'Refresh database';
					action: [ :aButton :aModel :anEvent | aButton phlow spawnObject: self renewDatabase ].
			button ]
]

{ #category : #utility }
TLeInMemoryDatabaseHolder >> inMemoryDatabaseFor: aLeDatabaseFolder [
	| sourceFolder targetFolder newDatabase |
	self
		assert: (aLeDatabaseFolder / 'lepiter.properties') exists
		description: aLeDatabaseFolder printString
				, 'does not appear to be a valid Lepiter database (no lepiter.properties).'.
	sourceFolder := aLeDatabaseFolder asFileReference asAbsolute.
	targetFolder := FileSystem memory root.
	sourceFolder children
		do: [ :each | each copyAllTo: targetFolder / each basename ].
	newDatabase := LeLocalStoreLoad current loadAndMonitorFrom: targetFolder.
	newDatabase stopMonitoring.
	^ newDatabase
]

{ #category : #initialization }
TLeInMemoryDatabaseHolder >> initializeDatabase [
	self databaseName ifNil: [self error: 'databaseName not initialized' ].
	database := self databaseNamed: self databaseName
]

{ #category : #utility }
TLeInMemoryDatabaseHolder >> renewDatabase [
	"Recreate the database from scratch, eg after adding new pages."

	database := nil.
	self initializeDatabase.
	^ database
]
