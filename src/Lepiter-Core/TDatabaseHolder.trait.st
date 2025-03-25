"
I decorate a class with a transient Lepiter database.
Pages are defined as methods with a `<page>` pragma.

The database is initialized on the first access to `#database`.
It is also possible for trait users to explicitly send `#initializeDatabase` in their `initialize` method.

Examples are in {{gtClass:name=DatabaseHolderExamples}}.
"
Trait {
	#name : #TDatabaseHolder,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Core-Utility'
}

{ #category : #accessing }
TDatabaseHolder >> database [
	^ database
		ifNil: [ self initializeDatabase.
			database ]
]

{ #category : #action }
TDatabaseHolder >> gtDatabaseFor: aView [
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

{ #category : #action }
TDatabaseHolder >> gtRefreshDatabaseActionFor: anAction [
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

{ #category : #'as yet unclassified' }
TDatabaseHolder >> initializeDatabase [
	"Create and initialize a transient Lepiter database for the dynamically created pages. We need to create a transient registry as well, so that links will work within the database. Automatically load all pages defined in methods with a <lePage> pragma."

	database
		ifNil: [ database := LeDatabase new monitor: LeVolatileMonitor new.
			LeBasicDatabasesRegistry new
				defaultLogicalDatabase: (LeLogicalDatabase new primaryDB: database) ].

	self pageMethods
		do: [ :m | 
			| page |
			page := self perform: m selector.
			(database hasPageNamed: page title) ifFalse: [ database addPage: page ] ]
]

{ #category : #acccessing }
TDatabaseHolder >> pageMethods [
	^ self class allMethods select: [ :m | m hasPragmaNamed: #lePage ]
]

{ #category : #actions }
TDatabaseHolder >> renewDatabase [
	"Recreate the database from scratch, eg after adding new pages."

	database := LeDatabase new.
	LeBasicDatabasesRegistry new
		defaultLogicalDatabase: (LeLogicalDatabase new primaryDB: database).
	self initializeDatabase.
	^ database
]
