"
I am the entry point for the memory used by the default logical database. I delegate to a {{gtClass:GtLepiterLogicalDatabaseMemoryMetrics}}, which estimates each contained database with a {{gtClass:GtLepiterDatabaseMemoryMetrics}}.

The GT Book is the only database saved in the image. Other databases, like the primary database, are loaded at startup. If the default logical database is not loaded, I do not load it, and answer no databases.

For performance reasons the results are cached in the default instance. Use #reset to compute them again.
"
Class {
	#name : #GtLepiterMemoryMetrics,
	#superclass : #Object,
	#instVars : [
		'logicalDatabaseMetrics'
	],
	#classInstVars : [
		'default'
	],
	#category : #'Lepiter-MemoryMetrics'
}

{ #category : #accessing }
GtLepiterMemoryMetrics class >> default [
	<gtExample>
	<noTest>
	^ default ifNil: [ default := self new ]
]

{ #category : #metrics }
GtLepiterMemoryMetrics class >> gtBookMetrics [
	<gtExample>
	<noTest>
	^ self default gtBookMetrics
]

{ #category : #accessing }
GtLepiterMemoryMetrics class >> reset [
	default := nil
]

{ #category : #metrics }
GtLepiterMemoryMetrics class >> totalDatabasesSize [
	<gtExample>
	<noTest>
	^ self default totalDatabasesSize
]

{ #category : #metrics }
GtLepiterMemoryMetrics class >> totalGtBookSize [
	<gtExample>
	<noTest>
	^ self default totalGtBookSize
]

{ #category : #accessing }
GtLepiterMemoryMetrics >> combinedEstimate [
	"The estimates of all databases added together"

	^ self logicalDatabaseMetrics
		ifNil: [ GtMemorySpaceEstimate new ]
		ifNotNil: [ :aMetrics | aMetrics combinedEstimate ]
]

{ #category : #accessing }
GtLepiterMemoryMetrics >> databasesMetrics [
	^ self logicalDatabaseMetrics
		ifNil: [ #() ]
		ifNotNil: [ :aMetrics | aMetrics databasesMetrics ]
]

{ #category : #accessing }
GtLepiterMemoryMetrics >> gtBookMetrics [
	"The GT Book is the only database saved in the image"

	^ self logicalDatabaseMetrics ifNotNil: [ :aMetrics | aMetrics gtBookMetrics ]
]

{ #category : #'gt - extensions' }
GtLepiterMemoryMetrics >> gtViewCategoriesFor: aView [
	<gtView>
	self logicalDatabaseMetrics ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Categories';
		priority: 20;
		object: [ self logicalDatabaseMetrics ];
		view: #gtViewCategoriesFor:
]

{ #category : #'gt - extensions' }
GtLepiterMemoryMetrics >> gtViewDatabasesFor: aView [
	<gtView>
	self logicalDatabaseMetrics ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Databases';
		priority: 10;
		object: [ self logicalDatabaseMetrics ];
		view: #gtViewDatabasesFor:
]

{ #category : #'gt - extensions' }
GtLepiterMemoryMetrics >> gtViewSummaryFor: aView [
	<gtView>
	self logicalDatabaseMetrics ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Summary';
		priority: 5;
		object: [ self logicalDatabaseMetrics ];
		view: #gtViewSummaryFor:
]

{ #category : #'gt - extensions' }
GtLepiterMemoryMetrics >> gtViewTagsFor: aView [
	<gtView>
	self logicalDatabaseMetrics ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Tags';
		priority: 30;
		object: [ self logicalDatabaseMetrics ];
		view: #gtViewTagsFor:
]

{ #category : #accessing }
GtLepiterMemoryMetrics >> logicalDatabaseMetrics [
	"The metrics of the default logical database, or nil if it is not loaded"

	^ logicalDatabaseMetrics
		ifNil: [ logicalDatabaseMetrics := LeDatabasesRegistry default
					currentLoadedDefaultLogicalDatabase
					ifNotNil: [ :aLogicalDatabase | GtLepiterLogicalDatabaseMemoryMetrics forLogicalDatabase: aLogicalDatabase ] ]
]

{ #category : #metrics }
GtLepiterMemoryMetrics >> totalDatabasesSize [
	"All databases of the default logical database, including the ones loaded at startup"

	^ self logicalDatabaseMetrics
		ifNil: [ 0 ]
		ifNotNil: [ :aMetrics | aMetrics totalSize ]
]

{ #category : #metrics }
GtLepiterMemoryMetrics >> totalGtBookSize [
	^ self logicalDatabaseMetrics
		ifNil: [ 0 ]
		ifNotNil: [ :aMetrics | aMetrics totalGtBookSize ]
]
