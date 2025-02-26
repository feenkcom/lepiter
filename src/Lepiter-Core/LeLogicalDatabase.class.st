"
LeLogicalDatabase provides a view of multiple physical databases.

Rules:

- Pages are added to the primary database by default.  A specific database can be requested, e.g. playground pages might be added specifically to the workspaceDB.
- The primaryDB and workspaceDB can be the same physical database.
- Search order is: primaryDB, workspaceDB, registered DBs in the order added.
- If a page with the same name exists in multiple databases, the page in lower priority databases is hidden from lookup operations.  WARNING: Iterating over all pages will include the lower priority pages.


## Public API and Key Messages

Messages in the `api - *` protocols are common between {{gtClass:name=LeDatabase}} and LeLogicalDatabase.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	announcer:		<Announcer>
	primaryDB:		<LeDatabase>
	registeredDBs:	<Array of LeDatabase>
	workspaceDB:		<LeDatabase>


### Implementation Points

- The current implementation is kept simple by assuming that the number of registered databases will be relatively small and that the cost of simply searching in db in turn is not excessive, so no additional indexes need to be kept.


### ToDos

- Be able to move pages between databases
- Create cross-database links
  - Requires links are pointers, and not hold on to the target page (can be by UID).

"
Class {
	#name : #LeLogicalDatabase,
	#superclass : #LeModel,
	#traits : 'TGtAnnouncer + TLeSpotterChildrenEnumerationSearch + TLeSpotterPagesSearch',
	#classTraits : 'TGtAnnouncer classTrait + TLeSpotterChildrenEnumerationSearch classTrait + TLeSpotterPagesSearch classTrait',
	#instVars : [
		'primaryDB',
		'registeredDBs',
		'announcer',
		'properties',
		'playgroundDB'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeLogicalDatabase class >> primaryDB: aLeDatabase [
	"Answer an instance of the receiver with the supplied primary DB"

	^ self new 
		primaryDB: aLeDatabase
]

{ #category : #'instance creation' }
LeLogicalDatabase class >> primaryDB: aPrimaryLeDatabase playgroundDB: aWorkspaceLeDatabase [
	"Answer an instance of the receiver with the supplied primary and workspace DBs"

	^ self new 
		primaryDB: aPrimaryLeDatabase;
		playgroundDB: aWorkspaceLeDatabase
]

{ #category : #'instance creation' }
LeLogicalDatabase class >> withProperties: aLeLogicalDatabaseProperties [

	^ self new 
		properties: aLeLogicalDatabaseProperties;
		loadFromProperties
]

{ #category : #accessing }
LeLogicalDatabase >> addDB: aLeDatabase [
	"Add the supplied database to the receiver"

	self assert: [ aLeDatabase isNotNil ].
	self assert: [ primaryDB ~= aLeDatabase and: [ playgroundDB ~= aLeDatabase ] ].
	self assert: aLeDatabase isDatabase.

	self basicAddDB: aLeDatabase.
	^ self setupAddedDB: aLeDatabase
]

{ #category : #'api - convenience' }
LeLogicalDatabase >> addKnowledgebaseFromDirectory: aFileReference [
	"Create a new database instance and add as registered DB"

	self assert: [ aFileReference isNotNil ].
	self assert: [ aFileReference exists ].

	"Do not add same database twice"
	self databasesDo: [ :eachDB | 
		(eachDB hasMonitor
			and: [ eachDB localStoreRootDirectory resolve = aFileReference resolve ])
			ifTrue: [ ^ self ] ].

	self properties
		addRegisteredDirectory: aFileReference;
		save.

	self reload
]

{ #category : #'api - adding / removing' }
LeLogicalDatabase >> addPage: aLePage [
	"Add the supplied page to the receiver's primary DB"

	^ primaryDB addPage: aLePage
]

{ #category : #announcer }
LeLogicalDatabase >> announcer [

	^ announcer
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> anyOne [

	^ primaryDB anyOne
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> asyncAllSnippets [
	^ self databases
		inject: #() asAsyncStream
		into: [ :sum :each | sum merge: each asyncAllSnippets ]
]

{ #category : #accessing }
LeLogicalDatabase >> asyncPagesForWord: aString [
	| results |
	results := #() asAsyncStream.
	self
		databasesDo: [ :each | results := results merge: (each asyncPagesForWord: aString) ].
	^ results
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> at: aKey forPageType: aPageType [
	"Lookup the given key for aPageType, if not present raise an exception"

	^ self
		at: aKey 
		ifAbsent: [ KeyNotFound signalFor: aKey ]
		forPageType: aPageType
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> at: aKey ifAbsent: anAbsentBlock forPageType: aPageType [
	"Lookup the given key for aPageType, if not present raise an exception"

	^ self 
		at: aKey 
		ifPresent: [ :aPage | ^ aPage ]
		ifAbsent: anAbsentBlock
		forPageType: aPageType

]

{ #category : #'api - accessing' }
LeLogicalDatabase >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock forPageType: aPageType [
	"Lookup the given key for aPageType, if not present raise an exception"

	self databasesDo: [ :aLeDatabase |
		aLeDatabase 
			at: aKey 
			ifPresent: [ :value | ^ aPresentBlock value: value ]
			ifAbsent: [ ]
			forPageType: aPageType ].
	^ anAbsentBlock value
]

{ #category : #'private - accessing' }
LeLogicalDatabase >> basicAddDB: aLeDatabase [
	"Add a DB without any processing."

	self assert: [ aLeDatabase isNotNil ].
	registeredDBs := registeredDBs copyWith: aLeDatabase.
]

{ #category : #'private - accessing' }
LeLogicalDatabase >> basicPlaygroundDB: aLeDatabase [
	"Set the primary DB without any processing."

	self assert: [ aLeDatabase isNotNil ].
	playgroundDB := aLeDatabase.
]

{ #category : #'private - accessing' }
LeLogicalDatabase >> basicPrimaryDB: aLeDatabase [
	"Set the primary DB without any processing."

	self assert: [ aLeDatabase isNotNil ].
	primaryDB := aLeDatabase.
]

{ #category : #'private - accessing' }
LeLogicalDatabase >> basicRemoveDB: aLeDatabase [
	"Remove a DB without any processing."

	self assert: [ aLeDatabase isNotNil ].
	registeredDBs := registeredDBs reject: [ :each | each = aLeDatabase ].
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> blockWithUID: aLeUID [
	"Answer the snippet with the supplied UID"

	self databasesDo: [ :db |
		db 
			blockWithUID: aLeUID
			ifPresent: [ :aLeSnippet | ^ aLeSnippet ] 
			ifAbsent: [ ] ].
	KeyNotFound signalFor: aLeUID
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> children [ 
	| children |

	children := OrderedCollection new.
	self databasesDo: [ :db |
		children addAll: db children ].
	^ children
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> dailyNotes [ 
	"Answer all the daily notes in the receiver sorted by date.
	Performance WARNING!"
	<return: #Collection of: #LePage>

	^ (self pages select: #isDailyNote) sorted: [ :a :b | 
		a type date > b type date ]
]

{ #category : #accessing }
LeLogicalDatabase >> databaseNamed: aDatabaseName [
	"Answer the database with the supplied name"
	<return: #LeDatabase>

	^ self databases 
		detect: [ :db | db databaseName = aDatabaseName ]
		ifNone: [ KeyNotFound signalFor: aDatabaseName ]
]

{ #category : #accessing }
LeLogicalDatabase >> databaseNamed: aDatabaseName ifNone: noneBlock [
	"Answer the database with the supplied name"

	<return: #LeDatabase>
	^ self databases
		detect: [ :db | db databaseName = aDatabaseName ]
		ifNone: noneBlock
]

{ #category : #accessing }
LeLogicalDatabase >> databaseWithID: aUUIDString [
	"Answer the database with the supplied id"
	<return: #LeDatabase>

	^ self databases 
		detect: [ :db | db uuidString = aUUIDString ]
		ifNone: [ KeyNotFound signalFor: aUUIDString ]
]

{ #category : #accessing }
LeLogicalDatabase >> databaseWithID: aUUIDString ifFound: foundBlock ifNone: noneBlock [
	"Answer the database with the supplied id"
	<return: #LeDatabase>

	^ self databases 
		detect: [ :db | db uuidString = aUUIDString ]
		ifFound: foundBlock
		ifNone: noneBlock
]

{ #category : #accessing }
LeLogicalDatabase >> databaseWithID: aUUIDString ifNone: noneBlock [
	"Answer the database with the supplied id"
	<return: #LeDatabase>

	^ self databases 
		detect: [ :db | db uuidString = aUUIDString ]
		ifNone: noneBlock
]

{ #category : #accessing }
LeLogicalDatabase >> databases [
	"Answer the receiver's databases in evaluation order, without duplicates"

	^ Array streamContents: [ :stream |
		self databasesDo: [ :db | stream nextPut: db ] ]
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> databasesDo: aBlock [
	"Evaluate aBlock for each of the receiver's DBS in the following order:
	1. primaryDB
	2. workspaceDB (if different from primaryDB)
	3. registeredDBs (in the order added)"

	aBlock cull: primaryDB.
	playgroundDB == primaryDB ifFalse:
		[ aBlock cull: playgroundDB ].
	registeredDBs do: [ :db |
		aBlock cull: db ].
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> ensurePageNamed: aString [ 
	"Answer the page named aString, creating if necessary"

	^ primaryDB ensurePageNamed: aString
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> explicitLinksCount [
	"Answer the number of links in the receiver"
	| total |

	total := 0.
	self databasesDo: [ :db |
		total := total + db explicitLinksCount ].
	^ total
]

{ #category : #accessing }
LeLogicalDatabase >> gtDatabasesFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Databases';
		items: [ self databases sorted: [ :each | each pageCount ] descending ];
		column: 'Name' text: #databaseName;
		column: 'Pages' text: [:db | db pageCount ];
		column: 'Snippets' text: [:db | db snippetsCount ];
		column: 'Links' text: [:db | db linksCount ]
]

{ #category : #'api - testing' }
LeLogicalDatabase >> hasChildren [ 
	"Answer a boolean indicating if any of the receiver's DBs have children"

	self databasesDo: [ :db |
		db hasChildren ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'api - testing' }
LeLogicalDatabase >> hasDatabaseAt: aFileReference [
	"Answer a boolean if the receiver has a database with its localStoreRootDirectory = aFileReference"
	| resolvedFr |

	"Ensure that the file references being compared are not FileLocators,
	which match on the other object being a FileLocator with the same origin"
	resolvedFr := aFileReference resolve.
	self databasesDo: [ :db |
		db localStoreRootDirectory resolve = resolvedFr ifTrue: 
			[ ^ true ] ].
	^ false
]

{ #category : #'api - testing' }
LeLogicalDatabase >> hasDatabaseNamed: aDatabaseName [
	^ self databases
		detect: [ :db | db databaseName = aDatabaseName ]
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #'api - testing' }
LeLogicalDatabase >> hasNamedPages [
	"Answer a boolean indicating if any of the receiver's DBs contain named pages"
	<return: #Boolean>

	self databasesDo: [ :db |
		db hasNamedPages ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'api - testing' }
LeLogicalDatabase >> hasPageNamed: aTitle [
	"Answer a boolean indicating if any of the receiver's DBs contain a page with the supplied name"
	<return: #Boolean>

	self databasesDo: [ :db |
		(db hasPageNamed: aTitle) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'api - query' }
LeLogicalDatabase >> hasPageWithLinkTo: aTargetReference [
	"Answer a boolean indicating if any of the receiver's DBs contain a page having a link to the given reference"
	
	self databasesDo: [ :aDatabase |
		(aDatabase hasPageWithLinkTo: aTargetReference) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'api - testing' }
LeLogicalDatabase >> hasParentDatabase [
	^ false
]

{ #category : #'api - testing' }
LeLogicalDatabase >> hasProperties [
	"Answer a boolean indicating whether the receiver has a configuration file (logical-database.properties)"

	^ properties isNull not and: [ properties hasLocalFile ]
]

{ #category : #initialization }
LeLogicalDatabase >> initialize [

	super initialize.
	announcer := Announcer new.
	registeredDBs := #().
	properties := LeLogicalDatabaseProperties null.
]

{ #category : #'api - testing' }
LeLogicalDatabase >> isDatabase [
	^ true
]

{ #category : #'api - testing' }
LeLogicalDatabase >> isLogicalDatabase [
	^ true
]

{ #category : #'api - testing' }
LeLogicalDatabase >> isPrimary [
	^ false
]

{ #category : #'api - testing' }
LeLogicalDatabase >> isPrimary: aDatabase [
	^ self primaryDB = aDatabase
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> linksCount [
	"Answer the number of links in the receiver"
	^ self explicitLinksCount
]

{ #category : #'api - initialization' }
LeLogicalDatabase >> loadFromProperties [
	"Load the receiver from its properties file"

	self assert: [ primaryDB isNil ].
	self assert: [ playgroundDB isNil ].
	self assert: [ registeredDBs isEmpty ].

	self primaryDB: properties primaryDatabase.
	
	properties playgroundDatabaseUrl = self primaryDB storeLocation
		ifFalse: [ self playgroundDB: properties playgroundDatabase ]
		ifTrue: [ self playgroundDB: self primaryDB ].
	
	properties registeredDatabases do: [ :db | self addDB: db ].
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> localStoreRootDirectory [
	<return: #FileReference or: nil>
	self databasesDo: [ :eachDatabase | 
		eachDatabase localStoreRootDirectory ifNotNil: [ :aDirectory |
			^ aDirectory ] ].
	^ nil
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> logicalDatabase [

	^ self
]

{ #category : #'private - notifying' }
LeLogicalDatabase >> notifyDatabaseAdded: aLeDatabase [
	self announce: (LeDatabasesAddedAnnouncement new
		database: aLeDatabase;
		parent: self)
]

{ #category : #'private - notifying' }
LeLogicalDatabase >> notifyDatabaseRemoved: aLeDatabase [
	self announce: (LeDatabaseUnloadAnnouncement new
		content: aLeDatabase)
]

{ #category : #'api - adding / removing' }
LeLogicalDatabase >> pageBuilder [

	^ primaryDB pageBuilder
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pageCount [
	"Answer the total number of pages in the receiver's databases"

	^ self databases inject: 0 into: [ :s :v | s + v pageCount ]
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pageNamed: aString [

	^ self at: aString forPageType: LeNamedPageType
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pageNamed: aString ifAbsent: absentBlock [

	^ self at: aString ifAbsent: absentBlock forPageType: LeNamedPageType
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pageNamed: aString ifPresent: presentBlock ifAbsent: absentBlock [

	^ self at: aString ifPresent: presentBlock ifAbsent: absentBlock forPageType: LeNamedPageType
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pageNamed: aString inDatabase: targetDatabaseUID ifDbAbsent: dbAbsentBlock [
	"Answer the page with the given title in the specified database.
	If the database is absent, answer dbAbsentBlock's value.  If the page is absent, raise an exception."

	^ self databaseWithID: targetDatabaseUID 
		ifFound: [ :db | db pageNamed: aString ]
		ifNone: dbAbsentBlock
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pageNames [
	"Answer the set of unique names in the receiver's DBs"
	| pageNames |

	pageNames := Set new.
	self databasesDo: [ :db |
		pageNames addAll: db pageNames ].
	^ pageNames
]

{ #category : #accessing }
LeLogicalDatabase >> pageWithID: pageId [
	| uid |

	uid := pageId isString 
		ifTrue: [ UUID fromString36: pageId ]
		ifFalse: [ pageId ].
	self pagesDo: [ :page | page uid = uid ifTrue: [ ^ page ] ].
	NotFound signalFor: pageId.
]

{ #category : #accessing }
LeLogicalDatabase >> pageWithID: pageId ifAbsent: absentBlock [
	| uid |

	uid := pageId isString 
		ifTrue: [ UUID fromString36: pageId ]
		ifFalse: [ pageId ].
	self pagesDo: [ :page | page uid = uid ifTrue: [ ^ page ] ].
	^ absentBlock value.
]

{ #category : #accessing }
LeLogicalDatabase >> pageWithID: pageId ifPresent: presentBlock ifAbsent: absentBlock [
	| uid |

	uid := pageId isString 
		ifTrue: [ UUID fromString36: pageId ]
		ifFalse: [ pageId ].
	self pagesDo: [ :page | page uid = uid ifTrue: [ ^ presentBlock value: page ] ].
	^ absentBlock value.
]

{ #category : #'api - query' }
LeLogicalDatabase >> pageWithLinkTo: aTargetReference ifAbsent: anAbsentBlock [ 
	^ self 
		pageWithLinkTo: aTargetReference 
		ifPresent: [ :aPage | aPage ]
		ifAbsent: anAbsentBlock 
]

{ #category : #'api - query' }
LeLogicalDatabase >> pageWithLinkTo: aTargetReference ifPresent: aPresentBlock ifAbsent: anAbsentBlock [ 
	self databasesDo: [ :aLeDatabase |
		aLeDatabase 
			pageWithLinkTo: aTargetReference 
			ifPresent: [ :value | ^ aPresentBlock value: value ]
			ifAbsent: [ ] ].
	^ anAbsentBlock value
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pages [
	"Answer the collection of all the pages in the receiver's DBs"
	| pages |

	pages := OrderedCollection new.
	self databasesDo: [ :db |
		pages addAll: db pages ].
	^ pages
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pagesByDate [
	"Answer the collection of all the pages in the receiver's DBs sorted by latestEditTime.
	This currently rebuilds the list each time it is requested.  Performance to be revisited."
	| sortedPages |

	sortedPages := SortedCollection new 
			sortBlock: [ :a :b | a latestEditTime > b latestEditTime ].
	sortedPages addAll: self pages.
	^ sortedPages
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> pagesByDateToShow [
	^ self pagesByDate reject: [ :aPage |
		aPage type isPharoClassPageType or: [
		aPage type isProxyClassPageType ] ]
]

{ #category : #'private - accessing' }
LeLogicalDatabase >> pagesByName [
	"Answer a single dictionary of all the pages by name.
	This is private, and very inefficient, and shouldn't be used."
	| pagesByName |

	pagesByName := Dictionary new.
	self databases reversed do: [ :db | 
		db pagesByName keysAndValuesDo: [ :key :value |
			pagesByName at: key put: value ] ].
	^ pagesByName
]

{ #category : #enumerating }
LeLogicalDatabase >> pagesDo: aBlock [ 

	self databasesDo: [ :db | db pagesDo: aBlock ]
]

{ #category : #'api - enumerating' }
LeLogicalDatabase >> pagesWithNameDo: aBlock [ 

	self databasesDo: [ :db | db pagesWithNameDo: aBlock ]

]

{ #category : #accessing }
LeLogicalDatabase >> playgroundDB [
	^ playgroundDB
]

{ #category : #accessing }
LeLogicalDatabase >> playgroundDB: aLeDatabase [
	| anOldPlayground shouldUnsubscribe |
	self assert: [ aLeDatabase isNotNil ].
	
	anOldPlayground := playgroundDB.
	
	aLeDatabase = anOldPlayground ifTrue: [ ^ self ].
	
	"Ensure the same instance is used if the primary and playground DBs are the same"
	aLeDatabase storeLocation = primaryDB storeLocation ifTrue: 
		[ (anOldPlayground isNotNil and: [ anOldPlayground ~= primaryDB ]) ifTrue: 
			[ self unsubscribeFromDatabase: anOldPlayground.
			playgroundDB := primaryDB.
			self notifyDatabaseRemoved: anOldPlayground ].

		playgroundDB := primaryDB.
		^ self ].
						
	shouldUnsubscribe := anOldPlayground isNotNil and: [ anOldPlayground ~= primaryDB ].

	self basicPlaygroundDB: aLeDatabase.
	playgroundDB parent: self.

	shouldUnsubscribe ifTrue: [
		self unsubscribeFromDatabase: anOldPlayground.
		self notifyDatabaseRemoved: anOldPlayground ].
	
	aLeDatabase = primaryDB ifFalse: [
		self subscribeToDatabase: aLeDatabase.
		self notifyDatabaseAdded: aLeDatabase ].
	
	"Cross-database links are updated by the target page.
	Update links from existing databases that reference the newly loaded database."
	aLeDatabase = primaryDB ifFalse: [
		self pagesDo: [ :page | page onAddedToDatabase ] ]
]

{ #category : #accessing }
LeLogicalDatabase >> primaryDB [
	^ primaryDB
]

{ #category : #accessing }
LeLogicalDatabase >> primaryDB: aLeDatabase [
	"Set the primary DB.
	If there isn't a workspaceDB, set it to the primary."

	self assert: [ aLeDatabase isNotNil ].

	primaryDB ifNotNil: [ :anOldDB | 
		self unsubscribeFromDatabase: anOldDB.
		self notifyDatabaseRemoved: anOldDB ].

	primaryDB := aLeDatabase.
	primaryDB parent: self.
	playgroundDB ifNil: [ playgroundDB := primaryDB ].
	
	self subscribeToDatabase: aLeDatabase.
	self notifyDatabaseAdded: aLeDatabase.
]

{ #category : #'api - initialization' }
LeLogicalDatabase >> properties [
	<return: #LeLogicalDatabaseProperties>
	^ properties
]

{ #category : #'api - initialization' }
LeLogicalDatabase >> properties: aLeLocalProperties [
	properties := aLeLocalProperties
]

{ #category : #'private - accessing' }
LeLogicalDatabase >> registeredDBs [
	<return: #Array of: #LeDatabase>
	^ registeredDBs
]

{ #category : #'private - accessing' }
LeLogicalDatabase >> registeredDBs: anArray [
	"Set the receiver's registered DBs.
	NOTE: This should only be used by LeLogicalDatabaseReload."

	registeredDBs := anArray
]

{ #category : #'startup-shutdown' }
LeLogicalDatabase >> reloadRequestFrom: aLeDatabase withErrorStrategy: aContentReloadErrorStrategy [
	"All concrete databases will be requested to reload at Pharo session startup.
	Only reload the receiver once - when the primary DB requests it."

	aLeDatabase == primaryDB ifTrue: [ 
		self reloadWithErrorStrategy: aContentReloadErrorStrategy ]
]

{ #category : #accessing }
LeLogicalDatabase >> removeDB: aLeDatabase [
	"Remove the supplied database from the receiver"

	self assert: [ (registeredDBs includes: aLeDatabase) or: [
		aLeDatabase = primaryDB or: [
		aLeDatabase = playgroundDB ] ] ].

	self unsubscribeFromDatabase: aLeDatabase.

	self basicRemoveDB: aLeDatabase.
	aLeDatabase unload.

	self notifyDatabaseRemoved: aLeDatabase.
	
	^ aLeDatabase 
]

{ #category : #'private - properties' }
LeLogicalDatabase >> saveProperties [
	"Update the properties to reflect the receiver's current state and save to disk"

	properties isNull ifTrue: [ ^ self ].
	properties 
		primaryDatabaseUrl: primaryDB storeLocation;
		playgroundDatabaseUrl: playgroundDB storeLocation;
		registeredDatabaseUrls: (registeredDBs collect:
			[ :each | each storeLocation ]).

]

{ #category : #'api - accessing' }
LeLogicalDatabase >> scanForLinksTo: aPage [
	"Answer the links to the supplied page.
	Right now there aren't any cross-DB links, so delegate to the page's DB"

	^ aPage database scanForLinksTo: aPage.
]

{ #category : #private }
LeLogicalDatabase >> setupAddedDB: aLeDatabase [
	"Set up the announcements and update links for a newly added DB.
	This is called by #addDB: and the logical DB reload code."

	aLeDatabase parent: self.
	
	self subscribeToDatabase: aLeDatabase.
	self notifyDatabaseAdded: aLeDatabase.

	"Cross-database links are updated by the target page.
	Update links from existing databases that reference the newly loaded database."
	self pagesDo: [ :page | page onAddedToDatabase ].

	^ aLeDatabase 
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> size [

	^ self pageCount
]

{ #category : #'api - enumerating' }
LeLogicalDatabase >> snippetsDo: aBlock [ 
	"Evalute aBlock against every snippet in the receiver"

	self databasesDo: [ :db | db snippetsDo: aBlock ]

]

{ #category : #'startup-shutdown' }
LeLogicalDatabase >> startMonitoring [ 
	"Instruct each of the physical databases to start monitoring changes"

	self databasesDo: [ :db | db startMonitoring ]
]

{ #category : #'startup-shutdown' }
LeLogicalDatabase >> stopMonitoring [

	self databasesDo: [ :db | db stopMonitoring ]
]

{ #category : #'private - subscriptions' }
LeLogicalDatabase >> subscribeToDatabase: aDatabase [
	aDatabase weak
		when: Announcement 
		send: #announce: 
		to: self
]

{ #category : #accessing }
LeLogicalDatabase >> tableOfContents [
	^ primaryDB tableOfContents
]

{ #category : #accessing }
LeLogicalDatabase >> tableOfContentsNodes [
	<return: #Collection of: #LeTableOfContentsNode>
	| page |
	page := self tableOfContents.
	page ifNil: [ ^ #() ].
	^ (LeTableOfContentsVisitor tocForPage: page) asOrderedCollection.
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> textualPageLinksCount [
	"Answer the number of textual page links in the receiver"
	| total |

	total := 0.
	self databasesDo: [ :db |
		total := total + db textualPageLinksCount ].
	^ total
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> textualSnippetsLinksCount [
	"Answer the number of textual snippet links in the receiver"
	| total |

	total := 0.
	self databasesDo: [ :db |
		total := total + db textualSnippetsLinksCount ].
	^ total
]

{ #category : #'api - enumerating' }
LeLogicalDatabase >> unnamedPagesDo: aBlock [ 

	self databasesDo: [ :db | db unnamedPagesDo: aBlock ]

]

{ #category : #'private - subscriptions' }
LeLogicalDatabase >> unsubscribeFromDatabase: aDatabase [
	aDatabase unsubscribe: self.
]

{ #category : #updating }
LeLogicalDatabase >> updateUnresolvedReferencesForPage: aPage [ 
	self databasesDo: [ :aDatabase |
		aDatabase updateLocalUnresolvedReferencesForPage: aPage ]
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> userEmail [
	"Answer the primaryDB email"
	<return: #LeEmail>

	^ primaryDB userEmail
]

{ #category : #'api - accessing' }
LeLogicalDatabase >> userEmail: anEmail [
	"Set the user's email address in the primaryDB"

	primaryDB userEmail: anEmail
]
