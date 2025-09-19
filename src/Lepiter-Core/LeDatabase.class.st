"
I am a root model object.
I hold all {{gtClass:LePage}} instances in my database.


## Internal Representation and Key Implementation Points.

### Instance Variables


### Implementation Points

The database currently holds a single userEmail address, implying that a database is only ever used by a single person, which isn't really a valid assumption.  This should probably be replaced by a ""current user"" model.


"
Class {
	#name : #LeDatabase,
	#superclass : #LeAbstractDatabase,
	#traits : 'TLeExplicitLinksKnowledgeBase',
	#classTraits : 'TLeExplicitLinksKnowledgeBase classTrait',
	#instVars : [
		'pagesByType',
		'pagesByDate',
		'dailyNotesByDate',
		'blocksByUID',
		'filename',
		'monitor',
		'attachmentsByType',
		'pagesByUuid',
		'index'
	],
	#classVars : [
		'LocalWorkspaceDatabaseLocation',
		'UserDatabaseLocation'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #'instance creation' }
LeDatabase class >> databaseNamed: aString [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase
		databaseNamed: aString
]

{ #category : #'instance creation' }
LeDatabase class >> gtBook [
	^ self databaseNamed: self gtBookName
]

{ #category : #constant }
LeDatabase class >> gtBookName [
	^ 'Glamorous Toolkit Book'
]

{ #category : #'api - instance creation' }
LeDatabase class >> null [
	^ LeNullDatabase default
]

{ #category : #'instance creation' }
LeDatabase class >> primaryDB [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase primaryDB
]

{ #category : #'api - attachments' }
LeDatabase >> addAttachmentByCopy: aFileReference [
	"Copy the attached file to the receiver's DB and answer the relative path string to the file"
	<return: #String>

	self 
		assert: monitor isNotNil
		description: 'Unable to add attachment, monitor not configured'.

	^ monitor addAttachmentByCopy: aFileReference
]

{ #category : #'api - attachments' }
LeDatabase >> addAttachmentByCopy: aFileReference withId: aUuid [
	"Copy the attached file to the receiver's DB and answer the relative path string to the file"
	<return: #String>

	self 
		assert: monitor isNotNil
		description: 'Unable to add attachment, monitor not configured'.

	^ monitor addAttachmentByCopy: aFileReference withId: aUuid
]

{ #category : #'api - attachments' }
LeDatabase >> addAttachmentByMove: aFileReference [
	"Move the attached file to the receiver's DB and answer the relative path string to the file"
	<return: #String>

	self 
		assert: monitor isNotNil
		description: 'Unable to add attachment, monitor not configured'.

	^ monitor addAttachmentByMove: aFileReference
]

{ #category : #'api - attachments' }
LeDatabase >> addAttachmentWithContent: aString named: aName [
	"Create an attachment to the receiver's DB and answer the relative path string to the file"
	<return: #String>

	self 
		assert: monitor isNotNil
		description: 'Unable to add attachment, monitor not configured'.

	^ monitor addAttachmentWithContent: aString named: aName
]

{ #category : #'api - attachments' }
LeDatabase >> addAttachmentWithContent: aString named: aName withId: aUuid [
	"Create an attachment to the receiver's DB and answer the relative path string to the file"
	<return: #String>

	self 
		assert: monitor isNotNil
		description: 'Unable to add attachment, monitor not configured'.

	^ monitor addAttachmentWithContent: aString named: aName withId: aUuid
]

{ #category : #'api - adding / removing' }
LeDatabase >> addPage: aLePage [
	"Add the supplied page.
	An exception handler may decide to ignore the page and answer nil if the page is a duplicate.
	This is separated out into two operations so that bulk loads can add all new pages to a database before updating links (which may create new pages prematurely)."
	| page |
	
	self assertNotReadOnly.

	page := self setPage: aLePage.
	page ifNotNil: [ self setPageUpdate: aLePage ].
	^ page
]

{ #category : #announcer }
LeDatabase >> announce: anAnnouncement [
	"This is a duplicate of the parent's trait, but is required since it is an explicit requirement of TLeExplicitLinksKnowledgeBase"

	^ self announcer announce: anAnnouncement
]

{ #category : #'api - accessing' }
LeDatabase >> anyOne [

	^ self do: [ :aPage | ^ aPage ]
]

{ #category : #'adding / removing' }
LeDatabase >> assertNotReadOnly [

	self assert: [ self readOnly isNil or: [ self readOnly not ] ]
]

{ #category : #'api - accessing' }
LeDatabase >> asyncAllSnippets [
	^ (self pages asAsyncStream collect: [ :page | page asyncAllSnippets ]) flatten
]

{ #category : #accessing }
LeDatabase >> asyncPagesContainingText: aQueryString [
	^ [ | filter results |
	results := OrderedCollection new.
	filter := LeSubstringFilter new
			caseSensitive: false;
			query: aQueryString.
	self
		pagesWithNameDo: [ :eachPage | (filter isMatchedItem: eachPage) ifTrue: [ results add: eachPage ] ].
	self
		unnamedPagesDo: [ :eachPage | (filter isMatchedItem: eachPage) ifTrue: [ results add: eachPage ] ].
	results asAsyncStream ] asAsyncFuture asAsyncStream flatten
]

{ #category : #accessing }
LeDatabase >> asyncPagesForWord: aString [
	^ ((self index asyncTitlesForWord: aString)
		collect: [ :each | self pageNamed: each ifAbsent: [  ] ]) select: #notNil
]

{ #category : #'api - query' }
LeDatabase >> asyncSnippetClassReferencesTo: aString [
	^ self index asyncSnippetClassReferencesTo: aString
]

{ #category : #'api - query' }
LeDatabase >> asyncSnippetReferencesTo: aString [
	^ self index asyncSnippetReferencesTo: aString
]

{ #category : #'api - accessing' }
LeDatabase >> at: aKey forPageType: aPageType [
	"Lookup the given key for aPageType, if not present raise an exception"

	^ (pagesByType at: aPageType) at: aKey
]

{ #category : #'api - accessing' }
LeDatabase >> at: aKey ifAbsent: anAbsentBlock forPageType: aPageType [
	"Lookup the given key for aPageType, if not present answer the value of anAbsentBlock"

	^ (pagesByType at: aPageType) at: aKey ifAbsent: anAbsentBlock
]

{ #category : #'api - accessing' }
LeDatabase >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock forPageType: aPageType [
	"Lookup the given key for aPageType, if present answer the value of aPresentBlock, if not, the value of anAbsentBlock"

	^ (pagesByType at: aPageType) at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock
]

{ #category : #'api - attachments' }
LeDatabase >> attachmentBinaryStream: attachmentPath do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"

	^ monitor attachmentBinaryStream: attachmentPath do: aBlock
]

{ #category : #'api - accessing' }
LeDatabase >> attachmentDirectories [

	self 
		assert: monitor isNotNil
		description: 'Unable to get attachmentDirectories, monitor not configured'.

	^ monitor attachmentDirectories
]

{ #category : #private }
LeDatabase >> attachmentDirectoryAndMetadataFor: aFileReference [
	"Create the attachment directory and populate the metadata for the supplied file reference.
	Answer the directory."
	<return: #FileReference>

	self 
		assert: monitor isNotNil
		description: 'Unable to add attachment, monitor not configured'.

	^ monitor attachmentDirectoryAndMetadataFor: aFileReference
]

{ #category : #'api - attachments' }
LeDatabase >> attachmentNames [
	"Return attachment names that, referencing to attachment files that are used by this snippet.
	Polymorhic to {{gtMethod: LeContent >> #attachmentNames }}"

	^ #()
]

{ #category : #'api - attachments' }
LeDatabase >> attachmentProperties: attachmentPath [

	^ monitor attachmentProperties: attachmentPath
]

{ #category : #'api - attachments' }
LeDatabase >> attachmentUtf8Stream: attachmentPath do: aBlock [
	"Answer a stream on the binary contents of the supplied attachment path"

	^ monitor attachmentUtf8Stream: attachmentPath do: aBlock
]

{ #category : #'api - attachments' }
LeDatabase >> attachmentWithDataForId: aUuid [
	"Return an attachment object containing the attachment data"
	<return: #LeAttachmentWithData>

	self 
		assert: monitor isNotNil
		description: 'Unable to search for attachment, monitor not configured'.

	^ (monitor hasAttachmentWithId: aUuid) 
		ifTrue: [ monitor attachmentWithDataForId: aUuid ]
		ifFalse: [ nil ]
]

{ #category : #'api - attachments' }
LeDatabase >> attachments [
	^ LeContentAttachmentsCollector new
		content: self;
		all
]

{ #category : #'private - accessing' }
LeDatabase >> attachmentsDirectory [
	"Answer the directory where DB attachments are stored"
	<return: #FileReference>

	self 
		assert: monitor isNotNil
		description: 'Unable to locate attachments'.

	"The monitor is responsible for ensuring that the attachments directory exists"
	^ monitor attachmentsDirectory.

]

{ #category : #'api - accessing' }
LeDatabase >> blockWithUID: aLeUID [

	^ blocksByUID at: aLeUID
]

{ #category : #'api - accessing' }
LeDatabase >> blockWithUID: aLeUID ifPresent: presentBlock ifAbsent: absentBlock [

	^ blocksByUID at: aLeUID ifPresent: presentBlock ifAbsent: absentBlock
]

{ #category : #'api - accessing' }
LeDatabase >> children [ 

	^ self pages
]

{ #category : #'api - accessing' }
LeDatabase >> commentPages [
	^ self pages select: #hasCommentSnippets
]

{ #category : #callbacks }
LeDatabase >> completeAddPageLaterFor: aTitleChangesAnnoucement [ 
	"This is a callback for adding a page to a database only when the title changed.
	This is added here so that registration for the announcement can be done using a
	weak announcement."
	
	aTitleChangesAnnoucement page unsubscribe:  self.
	self addPage: aTitleChangesAnnoucement page
]

{ #category : #'api - enumerating' }
LeDatabase >> dailyNotes [
	"Answer the receiver's daily notes sorted by date"
	<return: #Collection of: #LePage>
	
	^ dailyNotesByDate ifNil:
		[ dailyNotesByDate := SortedCollection new 
			sortBlock: [ :a :b | a type date > b type date ];
			addAll: (self pages select: #isDailyNote);
			yourself ]

]

{ #category : #accessing }
LeDatabase >> databaseName [
	<return: #String or: nil>
	
	^ monitor ifNotNil: [ :aMonitor | aMonitor databaseName ]
]

{ #category : #accessing }
LeDatabase >> databaseName: aString [
	"Set the database name. nil to clear the name"

	monitor ifNotNil: [ :aMonitor | aMonitor databaseName: aString ]
]

{ #category : #'api - accessing' }
LeDatabase >> databasesDo: aBlock [
	aBlock cull: self
]

{ #category : #'private - accessing' }
LeDatabase >> defaultEmail [
	"Answer the default email address to use"

	^ '<unknown>'
]

{ #category : #'private - accessing' }
LeDatabase >> defaultFilename [
	"Answer the default filename.
	If filename is nil the database doesn't yet havde a name, use lepiterexportXXX.json, where XXX is an auto-incrementing number (this is different from the version number generated in #save)"
	| exportNumber basename fileReference |

	exportNumber := 1.
	[ basename := 'lepiterexport', (exportNumber printPaddedWith: $0 to: 3), '.json'.
	fileReference := basename asFileReference.
	exportNumber := exportNumber + 1.
	fileReference exists ] whileTrue.
	^ fileReference
]

{ #category : #'api - adding / removing' }
LeDatabase >> detachPage: aPage [

	"I detach the page from the give database. The page could remain deleted or be later added to
	another database."

	self assertNotReadOnly.

	(pagesByType at: aPage pageTypeClass)
		removeKey: aPage databaseKey
		ifAbsent: [ "do nothing" ].
	pagesByUuid removeKey: aPage uid ifAbsent: [ "do nothing" ].

	aPage removedFromDatabase: self.
	self updateSortedCollectionsDueToRemoval: aPage.

	self announce: (LeDatabasePageRemoved new
			 database: self;
			 page: aPage)
]

{ #category : #'api - enumerating' }
LeDatabase >> do: aBlock [ 
	"Evaluate aBlock for every page in the receiver"

	pagesByType valuesDo: [ :pageType | pageType valuesDo: aBlock ]
]

{ #category : #'api - accessing' }
LeDatabase >> ensurePageNamed: aString [

	"Answer the page named aString, creating if necessary"

	^ self pageNamed: aString ifAbsent: [ 
		  self assertNotReadOnly.
		  self pageBuilder
			  title: aString;
			  add ]
]

{ #category : #accessing }
LeDatabase >> filename [
	<return: #FileReference>

	^ filename ifNil: [ filename := self defaultFilename ]
]

{ #category : #accessing }
LeDatabase >> filename: anObject [
	
	self assertNotReadOnly.

	filename := anObject asFileReference
]

{ #category : #'api - attachments' }
LeDatabase >> findAttachmentById: aUuid [
	"Find the attachment with that UUID"
	<return: #ByteArray>

	self 
		assert: monitor isNotNil
		description: 'Unable to search for attachment, monitor not configured'.

	^ monitor findAttachmentById: aUuid
]

{ #category : #accessing }
LeDatabase >> gtAttachmentsFor: aView [
	<gtView>
	monitor isVolatileMonitor ifTrue: [ ^ aView empty ].
	self monitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Attachments';
		priority: 70;
		object: [self monitor ];
		view: #gtAttachmentsFor:
]

{ #category : #'gt-extensions' }
LeDatabase >> gtDailyNotesFor: aView [
	<gtView>
	self pages ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'By day';
		priority: 10;
		items: [ self dailyNotesGroup ];
		children: [ :eachPage | eachPage children ];
		column: 'Content' text: [ :aPageOrDailyNote |
			(aPageOrDailyNote isKindOf: LeDailyNote)
				ifTrue: [ aPageOrDailyNote date  ]
				ifFalse: [ aPageOrDailyNote contentAsString ] ];
		column: 'Time' text: [ :aPageOrDailyNote |
			(aPageOrDailyNote isKindOf: LeDailyNote)
				ifTrue: [ ''  ]
				ifFalse: [ aPageOrDailyNote editTime ] ];
		column: 'Author' text: [ :aPageOrDailyNote |
			(aPageOrDailyNote isKindOf: LeDailyNote)
				ifTrue: [ ''  ]
				ifFalse: [ aPageOrDailyNote editEmail ] ];
		actionUpdateButton
]

{ #category : #'gt-extensions' }
LeDatabase >> gtMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Map';
		painting: [:m |
			m nodes 
				stencil: [:each | BlElement new
					size: 5@5; 
					geometry: BlCircleGeometry new; 
					background: (each isDailyNote ifTrue: [Color blue] ifFalse: [Color red])];
				with: (self pagesByDate select: [:each | 
					each allChildOutgoingTextualLinks notEmpty or: [each incomingLinks notEmpty]]) .
			m edges
				stencil: [:each | BlLineElement new
					zIndex: -1; 
					border: (BlBorder paint: (Color veryVeryLightGray alpha: 0.5))];
				connectToAll: [ :each | (each allChildOutgoingTextualLinks collect: [:l | l target ifNotNil: #page]) asSet ].
			m layout force.
			m ]
]

{ #category : #accessing }
LeDatabase >> gtViewCorruptFilesFor: aView [
	<gtView>
	monitor isVolatileMonitor ifTrue: [ ^ aView empty ].
	monitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Corrupt files';
		priority: 67;
		object: [ self monitor ];
		view: #gtViewCorruptFilesFor:
]

{ #category : #accessing }
LeDatabase >> gtViewFilesNameMappingFor: aView [
	<gtView>
	monitor isVolatileMonitor ifTrue: [ ^ aView empty ].
	monitor ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Page file mappings';
		priority: 66;
		object: [ self monitor ];
		view: #gtNameMappingFor:
]

{ #category : #'gt-extensions' }
LeDatabase >> gtViewPagesByTypeFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Pages (by type)';
		priority: 50;
		items: [ pagesByType associations ];
		column: 'Type' text: #key;
		column: 'Number of Pages' text: [ :assoc | assoc value size ];
		send: #value
]

{ #category : #'gt-extensions' }
LeDatabase >> gtViewUnnamedPageFor: aView [
	<gtView>
	(pagesByType includesKey: LeUnnamedPageType)
		ifFalse: [ ^ aView empty ].
	^ aView columnedList
		title: 'Unnamed pages';
		priority: 55;
		items: [ (pagesByType at: LeUnnamedPageType) values ];
		column: 'Created time' text: [ :aPage | aPage createTime ];
		column: 'Uid' text: [ :aPage | aPage uid ];
		column: 'Snippets count'
			text: [ :aPage | aPage children size ]
			width: 100;
		column: 'First snippet'
			text: [ :aPage | 
			aPage children isEmpty
				ifTrue: [ '' ]
				ifFalse: [ aPage children first ] ]
]

{ #category : #'api - attachments' }
LeDatabase >> hasAttachmentWithId: aUuid [
	"Check whether the attachment with that name already exists"
	<return: #String>

	self 
		assert: monitor isNotNil
		description: 'Unable to search for attachment, monitor not configured'.

	^ monitor hasAttachmentWithId: aUuid
]

{ #category : #'api - testing' }
LeDatabase >> hasBlockUID: aLeUID [

	^ blocksByUID includesKey: aLeUID
]

{ #category : #'api - testing' }
LeDatabase >> hasChildren [ 

	self do: [ :aPage | ^ true ].
	^ false
]

{ #category : #'api - testing' }
LeDatabase >> hasCommentPages [
	^ self commentPages notEmpty
]

{ #category : #'api - testing' }
LeDatabase >> hasMonitor [
	^ monitor notNil
]

{ #category : #'api - testing' }
LeDatabase >> hasNamedPages [
	"Answer a boolean indicating if the receiver has named pages"

	^ self pagesByName isNotEmpty
]

{ #category : #'api - testing' }
LeDatabase >> hasPageNamed: aTitle [
	<return: #Boolean>
	^ self pagesByName  
		at: aTitle 
		ifPresent: [ :aPage | true ]
		ifAbsent: [ false ]
]

{ #category : #'private - testing' }
LeDatabase >> hasPageUID: aUUID [
	"Answer a boolean indicating whether the receiver includes a page with the supplied UID"

	^ pagesByUuid includesKey: aUUID
]

{ #category : #'api - query' }
LeDatabase >> hasPageWithLinkTo: aTargetReference [
	^ self 
		pageWithLinkTo: aTargetReference 
		ifPresent: [ :aPage | true ] 
		ifAbsent: [ false ] 
]

{ #category : #'api - testing' }
LeDatabase >> hasParentDatabase [
	^ self parent isNotNil.
]

{ #category : #'private - testing' }
LeDatabase >> hasSortedDailyNotes [
	^ dailyNotesByDate isNotNil 
]

{ #category : #'private - testing' }
LeDatabase >> hasSortedItems [
	^ pagesByDate isNotNil 
]

{ #category : #'private - testing' }
LeDatabase >> hasTextualSnippetLinks [
	^ self textualSnippetsLinksCount > 0
]

{ #category : #accessing }
LeDatabase >> index [
	^ index ifNil: [ index := LeDatabaseIndex new database: self ]
]

{ #category : #initialization }
LeDatabase >> initialize [
	super initialize.
	readOnly := false.
	pagesByType := IdentityDictionary new.
	pagesByUuid := Dictionary new.
	"Populate all the page types"
	LePageType subclassesDo: [ :pageType |
		pagesByType
			at: pageType pageTypeClass
			ifAbsentPut: [ GtStringContentDictionary new ] ].
	blocksByUID := Dictionary new.
	self ensureExplicitLinksStorage.
	self weak
		when: LePageTitleChanged 
		send: #onPageTitleChanged: 
		to: self.
]

{ #category : #'api - testing' }
LeDatabase >> isDatabase [
	^ true
]

{ #category : #'api - testing' }
LeDatabase >> isLogicalDatabase [
	^ false
]

{ #category : #'api - testing' }
LeDatabase >> isPrimary [
	"Answer true if my parent considers me as a primary database"
	^ self parent
		ifNotNil: [ :aParent | aParent isPrimary: self ]
		ifNil: [ true ]
]

{ #category : #'api - query' }
LeDatabase >> leSnippetsInDB [
	^ LeSearchDatabaseSnippetFilter forDatabase: self
]

{ #category : #'private - accessing' }
LeDatabase >> linkKeyFor: aLink [
	"Answer the key used to index the link in the link dictionaries"

	^ aLink target 
		ifNil: [ #targetNotPresent ]
		ifNotNil: [ aLink targetUID ]
]

{ #category : #'api - accessing' }
LeDatabase >> linksCount [
	"Answer the number of links in the receiver"

	^ self explicitLinksCount
]

{ #category : #accessing }
LeDatabase >> linksWithMatchingOriginFilter: aReferenceFilter [
	| linkFilter |
	linkFilter := LeLinkOriginReferenceSearchFilter new
		searchFilter: aReferenceFilter.
	^ self explicitLinks select: [ :aLink | linkFilter matches: aLink ]
]

{ #category : #accessing }
LeDatabase >> linksWithMatchingTargetFilter: aReferenceFilter [
	| linkFilter |
	linkFilter := LeLinkTargetReferenceSearchFilter new
		searchFilter: aReferenceFilter.
	^ self explicitLinks select: [ :aLink | linkFilter matches: aLink ]
]

{ #category : #'api - query' }
LeDatabase >> linksWithOriginReferenceMatching: aLinkReference [
	^ self explicitLinks select: [:aLink | 
		aLink originReference matches:  aLinkReference ]
]

{ #category : #'api - query' }
LeDatabase >> linksWithTargetReferenceMatching: aLinkReference [
	^ self explicitLinks select: [:aLink | 
		aLink targetReference matches: aLinkReference ]
]

{ #category : #'api - accessing' }
LeDatabase >> localStoreRootDirectory [
	"Answer the directory where the receiver's data is stored.
	This should no longer be used as non-disk based stores are being added, use #storeLocation as a more general comparison of whether databases have the same data store."
	<return: #FileReference or: nil>

	^ monitor ifNotNil: [ :aMonitor | aMonitor localRoot ]
]

{ #category : #accessing }
LeDatabase >> monitor [
	^ monitor
]

{ #category : #accessing }
LeDatabase >> monitor: anObject [
	monitor := anObject
]

{ #category : #'api - adding / removing' }
LeDatabase >> movePage: aPage toDatabase: aNewDatabase [
	"Move the page from the current database to a new database."
	
	self detachPage: aPage.
	aNewDatabase addPage: aPage.
	
	aPage announce: (LePageDatabaseChanged new 
		previousDatabase: self;
		currentDatabase: aNewDatabase;
		page: aPage).
]

{ #category : #accessing }
LeDatabase >> name: aString [
	"Name the receiver.
	This is currently only used to name the db exports"
	| basename |

	basename := DiskStore current checkName: (aString, '.json') fixErrors: true.
	filename := basename asFileReference
]

{ #category : #'instance creation' }
LeDatabase >> newUID [
	"Generate a new UID.
	Ensure the UID doesn't already exist"
	| uid |

	[ uid := LeUID new.
	blocksByUID includesKey: uid ] whileTrue.

	^ uid
]

{ #category : #accessing }
LeDatabase >> newUniqueUuid [
	"Return a new UUID unique to this database based on the current content"
	| newUuid |
	
	newUuid := UUID new.
	[ (self hasPageUID: newUuid) or: [ 
			(self hasBlockUID: newUuid) or: [ 
				self hasExplicitLinkUID: newUuid ] ] ] whileTrue:
		[ newUuid := UUID new ].
	
	^ newUuid
]

{ #category : #'private - hooks' }
LeDatabase >> onPageTitleChanged: aLePageTitleChanged [
	| page |

	page := aLePageTitleChanged page.
	self updateByTypeStorageDueTo: aLePageTitleChanged.
	self updateUnresolvedReferencesForPage: page.
	
	self reSortCollectionsDueTo: aLePageTitleChanged.
	self announce: (LeDatabaseResorted new 
		page: page;
		isChangedToDailyNote: aLePageTitleChanged isChangedToDailyNote;
		isChangedToNormalPage: aLePageTitleChanged isChangedToNormalPage).
]

{ #category : #'api - adding / removing' }
LeDatabase >> pageBuilder [
	^ LeDatabasePageBuilder new database: self
]

{ #category : #accessing }
LeDatabase >> pageByUuid: aUUID [
	^ pagesByUuid at: aUUID
]

{ #category : #accessing }
LeDatabase >> pageByUuid: aUUID ifAbsent: absentBlock [

	^ pagesByUuid at: aUUID ifAbsent: absentBlock
]

{ #category : #accessing }
LeDatabase >> pageByUuid: aUUID ifPresent: aBlock [

	^ pagesByUuid at: aUUID ifPresent: aBlock
]

{ #category : #paging }
LeDatabase >> pageCount [

	^ pagesByType inject: 0 into: [ :s :v | s + v size ]
]

{ #category : #'api - accessing' }
LeDatabase >> pageNamed: aString [

	^ self pagesByName at: aString
]

{ #category : #'api - accessing' }
LeDatabase >> pageNamed: aString ifAbsent: absentBlock [

	^ self pagesByName at: aString
		ifAbsent: absentBlock
]

{ #category : #'api - accessing' }
LeDatabase >> pageNamed: aString ifPresent: presentBlock ifAbsent: absentBlock [

	^ self pagesByName at: aString
		ifPresent: presentBlock
		ifAbsent: absentBlock
]

{ #category : #'api - accessing' }
LeDatabase >> pageNamed: aString inDatabase: targetDatabaseUID [
	"Answer the page with the given UID"

	^ targetDatabaseUID 
		ifNil: [ ^ self pageNamed: aString ]
		ifNotNil: [ ^ self parent pageNamed: aString inDatabase: targetDatabaseUID ]
]

{ #category : #'api - accessing' }
LeDatabase >> pageNamed: aString inDatabase: targetDatabaseUID ifDbAbsent: dbAbsentBlock [
	"Answer the page with the given title in the specified database.
	If the database is absent, answer dbAbsentBlock's value.  If the page is absent, raise an exception."

	^ targetDatabaseUID ifNil: 
		[ ^ self pageNamed: aString ]
	ifNotNil: 
		[ ^ parent ifNotNil: [ self parent pageNamed: aString inDatabase: targetDatabaseUID ifDbAbsent: dbAbsentBlock ] ]
]

{ #category : #'api - accessing' }
LeDatabase >> pageNames [

	^ self pagesByName keys
]

{ #category : #'api - accessing' }
LeDatabase >> pageUIDs [

	^ pagesByUuid keys
]

{ #category : #'api - accessing' }
LeDatabase >> pageWithID: pageId [
	| uid |

	uid := pageId isString 
		ifTrue: [ UUID fromString36: pageId ]
		ifFalse: [ pageId ].
	self pagesDo: [ :page | page uid = uid ifTrue: [ ^ page ] ].
	NotFound signalFor: pageId.
]

{ #category : #'api - accessing' }
LeDatabase >> pageWithID: pageId ifAbsent: absentBlock [
	| uid |

	uid := pageId isString 
		ifTrue: [ UUID fromString36: pageId ]
		ifFalse: [ pageId ].
	self pagesDo: [ :page | page uid = uid ifTrue: [ ^ page ] ].
	^ absentBlock value.
]

{ #category : #'api - accessing' }
LeDatabase >> pageWithID: pageId ifPresent: presentBlock ifAbsent: absentBlock [
	| uid |

	uid := pageId isString 
		ifTrue: [ UUID fromString36: pageId ]
		ifFalse: [ pageId ].
	self pagesDo: [ :page | page uid = uid ifTrue: [ ^ presentBlock value: page ] ].
	^ absentBlock value.
]

{ #category : #'api - query' }
LeDatabase >> pageWithLinkTo: aTargetReference ifAbsent: anAbsentBlock [ 
	^ self 
		pageWithLinkTo: aTargetReference 
		ifPresent: [ :aPage | aPage ]
		ifAbsent: anAbsentBlock 
]

{ #category : #'api - query' }
LeDatabase >> pageWithLinkTo: aTargetReference ifPresent: aPresentBlock ifAbsent: anAbsentBlock [ 
	self pagesDo: [ :aPage |
		(aPage outgoingExplicitLinks anySatisfy: [ :aLink |
			aLink targetReference matches: aTargetReference ])
				ifTrue: [ ^ aPresentBlock cull: aPage ] ].
	^ anAbsentBlock value
]

{ #category : #'api - accessing' }
LeDatabase >> pages [
	| pages |

	pages := OrderedCollection new.
	pagesByType do: [ :each | pages addAll: each values ].
	^ pages
]

{ #category : #'api - accessing' }
LeDatabase >> pagesByDate [

	^ pagesByDate ifNil: [ 
			pagesByDate := SortedCollection new 
				sortBlock: [ :a :b | a latestEditTime > b latestEditTime ].
			pagesByType valuesDo: [ :aCollectionOfPages |
				pagesByDate addAll: aCollectionOfPages ].
			pagesByDate ]
]

{ #category : #'api - accessing' }
LeDatabase >> pagesByDateToShow [
	^ self pagesByDate reject: [ :aPage |
		aPage type isPharoClassPageType or: [
		aPage type isProxyClassPageType ] ]
]

{ #category : #'private - accessing' }
LeDatabase >> pagesByName [
	"Answer the pages by name.
	This is internal structure that may change."

	^ pagesByType at: LeNamedPageType
]

{ #category : #'api - enumerating' }
LeDatabase >> pagesDo: aBlock [ 

	^ self do: aBlock
]

{ #category : #'api - enumerating' }
LeDatabase >> pagesWithNameDo: aBlock [ 

	^ self pagesByName do: [ :assoc |
		aBlock value: assoc value ]
]

{ #category : #printing }
LeDatabase >> printOn: aStream [

	self hasMonitor ifTrue: 
		[ aStream
			<< self properties databaseName;
			<< ': ' ].
	aStream 
		print: self size;
		nextPutAll: ' pages'.
	self hasExplicitLinks ifFalse: [ ^ self ].
	aStream
		nextPutAll: ', ';
		print: self explicitLinksCount;
		nextPutAll: ' links'
]

{ #category : #accessing }
LeDatabase >> properties [
	"Answer the DB properties.
	For now, this is handled by the monitor"

	^ monitor
]

{ #category : #'private - adding / removing' }
LeDatabase >> reSortCollectionsDueTo: aLePageTitleChanged [
	| aPage |
	aPage := aLePageTitleChanged page.
	self hasSortedItems
		ifTrue: [ self sortedPages reSort ].
	(self hasSortedDailyNotes and: [ aLePageTitleChanged isChangedToNormalPage ])
		ifTrue: [ self dailyNotes remove: aPage ].
	(self hasSortedDailyNotes and: [ aLePageTitleChanged isChangedToDailyNote ])
		ifTrue: [ self dailyNotes add: aPage ].
	(self hasSortedDailyNotes and: [ aPage isDailyNote ])
		ifTrue: [ self dailyNotes reSort ]
]

{ #category : #'adding / removing' }
LeDatabase >> registerSnippet: aSnippet [

	self
		assert: [ aSnippet uid notNil ]
		description: [ 'Snippet UID must be non-nil: ' , aSnippet asString ].
	self
		assert: [ aSnippet uid uid notNil ]
		description: [ 
		'Snippet UID''s uid must be non-nil: ' , aSnippet uid asString ].
	self
		assert: [ (blocksByUID includesKey: aSnippet uid) not ]
		description: [ 
			'There is already a snippet with the same UID, existing '
			, (blocksByUID at: aSnippet uid) asString , ', registering '
			, aSnippet asString ].

	blocksByUID at: aSnippet uid put: aSnippet
]

{ #category : #'api - import and export' }
LeDatabase >> reload [
	"Reload the database.
	Any changes made during the reload may be lost"

	monitor reload
]

{ #category : #'private - development' }
LeDatabase >> removeEmptyPages [

	"Remove empty pages from the receiver.
	This is just for manual maintenace during development"

	| emptyPages |
	self assertNotReadOnly.

	emptyPages := self pages select: [ :each | each isEmpty ].
	emptyPages do: [ :page | self removePage: page ]
]

{ #category : #'api - adding / removing' }
LeDatabase >> removeFromParentDatabase [

	self assertNotReadOnly.

	self parent ifNil: [ ^ self ].
	self parent removeDB: self
]

{ #category : #'api - adding / removing' }
LeDatabase >> removeFromParentDatabaseUpdatingProperties [
	| aParent |
	aParent := self parent.
	
	self removeFromParentDatabase.
	aParent ifNotNil: [ aParent saveProperties ].
]

{ #category : #'api - adding / removing' }
LeDatabase >> removePage: aPage [
	"Remove the supplied page from the receiver.
	All outgoing links are removed. Incoming links becore unresolved.
	
	I am called when the intent is to remove the page completely, and not 
	readd it later to another database."

	self detachPage: aPage.
	
	aPage announce: (LePageRemovedFromDatabase new 
		database: self;
		page: aPage).
]

{ #category : #'api - attachments' }
LeDatabase >> resolveDbFile: aString [
	"Resolve the supplied relative path reference against the receiver's database"

	monitor ifNil: [ self error: 'No database directory available' ].

	^ monitor resolveDbFile: aString
]

{ #category : #'api - accessing' }
LeDatabase >> scanForLinksTo: aPage [
	"Answer the links to the supplied page.
	
	This does a scan of all the links to find 
	the one that have the page as target. "

	^ self explicitLinks select: [ :aLink | 
			aLink targetReference isPageReference and: [ 
				aLink targetReference page = aPage ] ]

]

{ #category : #'private - adding / removing' }
LeDatabase >> setPage: aLePage [
	"Add the supplied page to the receiver without updating links and metadata.
	This may be used as part of a bulk load to ensure linked pages aren't created prematurely.
	Raise an error if a page with the same title exists."

	| pages duplicate |
	pages := pagesByType at: aLePage pageTypeClass.	"Allow an exception handler to either ignore a duplicate page or repair it, and carry on"
	duplicate := (pages includesKey: aLePage databaseKey)
			ifTrue: [ LeDuplicatePageIdError new
					database: self;
					pageInCurrentDatabase: (pages at: aLePage databaseKey);
					pageToAdd: aLePage;
					signal.
					true]
			ifFalse: [ false ].
	duplicate ifTrue: [ ^ nil ].	"Ensure that the page UID is unique within the database.
	This is the one time a page can have its UID changed."
	[ self hasPageUID: aLePage uid ] whileTrue: [ aLePage assignNewUID ].

	aLePage aboutToAddToDatabase: self.
	pages at: aLePage databaseKey put: aLePage.
	pagesByUuid at: aLePage uid put: aLePage.

	^ aLePage
]

{ #category : #'api - adding / removing' }
LeDatabase >> setPageUpdate: aLePage [
	"Complete the addition of the supplied page, i.e. setting metadata if required, updating links, announcing.
	Raise an error if a page with the same title exists."

	aLePage addedToDatabase: self.
	self updateSortedCollectionsDueToAddition: aLePage.
	
	self announce: (LeDatabasePageAdded new 
		database: self;
		page: aLePage).
]

{ #category : #initialization }
LeDatabase >> setPages: aCollection [
	"Set the receiver's pages to aCollection.
	This is used for bulk loading, so assumes the database is empty."
	| setPages |

	self pageCount > 0 ifTrue: [ self error: 'Database isn''t empty' ].
	"Collect the pages that are actually loaded and then update them.
	This allows an exception handler to catch any errors during load and choose to either ignore them (by answering nil) or resolve the issue and continue the page load"
	setPages := aCollection collect: [ :aLePage |
		self setPage: aLePage ].
	setPages
		select: #isNotNil
		thenDo: [ :aLePage |
			self setPageUpdate: aLePage ].
]

{ #category : #'api - accessing' }
LeDatabase >> size [ 

	^ self pageCount
]

{ #category : #'api - accessing' }
LeDatabase >> snippetsCount [
	"Answer the number of snippets in the database"

	^ blocksByUID size

]

{ #category : #'api - enumerating' }
LeDatabase >> snippetsDo: aBlock [
	"Evalute aBlock against every snippet in the receiver"

	blocksByUID valuesDo: aBlock
]

{ #category : #'api - accessing' }
LeDatabase >> sortedPages [
	^ self pagesByDate
]

{ #category : #'startup-shutdown' }
LeDatabase >> startMonitoring [ 
	"If the receiver has a db monitor, tell it to start (saving changes to the receiver)"

	monitor ifNotNil: [ monitor startMonitoring ]
]

{ #category : #'startup-shutdown' }
LeDatabase >> stopMonitoring [ 
	"If the receiver has a db monitor, tell it to stop (saving changes to the receiver)"

	monitor ifNotNil: [ monitor stopMonitoring ]
]

{ #category : #'api - accessing' }
LeDatabase >> storeLocation [
	"Answer the location of the receiver's data store.
	E.g. for a disk based store it is the directory, for a class based store it is the class.
	If the database doesn't have a store, answer itself since two databases without stores can be considered the same."
	<return: #Object>

	^ monitor 
		ifNil: [ self ]
		ifNotNil: [ :aMonitor | aMonitor storeLocation ]
]

{ #category : #'api - accessing' }
LeDatabase >> tagPages [
	"Return a list of named pages whose titles consist of a single word (potentially a tag)."

	^ (self pages
		select: [ :p | p isUnnamedPage not and: [ p title substrings size = 1 ] ])
		sort: [ :a :b | a title < b title ]
]

{ #category : #'api - accessing' }
LeDatabase >> textualPageLinksCount [
	"Answer the number of textual page links in the receiver"

	^ self explicitLinks count: [ :aLink | 
		aLink isTextualLink and: [ 
			aLink isTextualPageLink ] ]

]

{ #category : #'api - accessing' }
LeDatabase >> textualSnippetsLinksCount [
	"Answer the number of textual snippet links in the receiver"

	^ self explicitLinks count: [ :aLink | 
		aLink isTextualLink and: [ 
			aLink isTextualSnippetLink ] ]

]

{ #category : #'api - import and export' }
LeDatabase >> unload [ 
	"Announce that the receiver and all its content has been unloaded"

	self stopMonitoring.
	self pagesDo: [ :page | page unload ].
	self announcer 
		announce: (LeDatabaseUnloadAnnouncement new content: self).
]

{ #category : #'private - accessing' }
LeDatabase >> unnamedPagesByUid [
	"Answer the unnamed pages by uid.
	This is internal structure that may change."

	^ pagesByType at: LeUnnamedPageType
]

{ #category : #'api - enumerating' }
LeDatabase >> unnamedPagesDo: aBlock [ 

	^ self unnamedPagesByUid do: [ :assoc |
		aBlock value: assoc value ]
]

{ #category : #'adding / removing' }
LeDatabase >> unregisterSnippet: aSnippet [

	self assertNotReadOnly.
	self assert: [ aSnippet uid notNil ].
	self assert: [ aSnippet uid uid notNil ].
	self assert: [ blocksByUID includesKey: aSnippet uid ].


	blocksByUID removeKey: aSnippet uid
]

{ #category : #accessing }
LeDatabase >> updateAttachmentNamed: aFileName content: anObject [
	| aFile |
	aFile := self resolveDbFile: aFileName.
	aFile ensureDelete.
	aFile writeStreamEncoded: 'utf8' do: [ :aStream |
		aStream nextPutAll: anObject asString ].
]

{ #category : #'api - attachments' }
LeDatabase >> updateAttachmentWithContent: aString named: aName withId: aUuid [
	"Update an attachment to the receiver's DB and answer the relative path string to the file"
	<return: #String>

	self 
		assert: monitor isNotNil
		description: 'Unable to add attachment, monitor not configured'.

	^ monitor updateAttachmentWithContent: aString named: aName withId: aUuid
]

{ #category : #'private - hooks' }
LeDatabase >> updateByTypeStorageDueTo: aLePageTitleChanged [
	| aPage oldTypeClass newTypeClass |
	aPage := aLePageTitleChanged page.
	oldTypeClass := aLePageTitleChanged oldType class pageTypeClass.
	newTypeClass := aLePageTitleChanged newType class pageTypeClass.
	self 
		at: aLePageTitleChanged oldDatabaseKey 
		ifPresent: [ 
			(pagesByType at: oldTypeClass) removeKey: aLePageTitleChanged oldDatabaseKey ] 
		ifAbsent: [ ] 
		forPageType: oldTypeClass.
	(pagesByType at: newTypeClass) 
		at: aLePageTitleChanged newDatabaseKey 
		put: aPage
]

{ #category : #'private - adding / removing' }
LeDatabase >> updateSortedCollectionsDueToAddition: aPage [
	self hasSortedItems
		ifTrue: [ self sortedPages add: aPage ].
	(self hasSortedDailyNotes and: [ aPage isDailyNote ])
		ifTrue: [ self dailyNotes add: aPage ]
]

{ #category : #'private - adding / removing' }
LeDatabase >> updateSortedCollectionsDueToRemoval: aPage [
	self hasSortedItems
		ifTrue: [ self sortedPages remove: aPage ].
	(self hasSortedDailyNotes and: [ aPage isDailyNote ])
		ifTrue: [ self dailyNotes remove: aPage ]
]

{ #category : #'api - accessing' }
LeDatabase >> userEmail [
	<return: #LeEmail>
	^ self 
		optionAt: self userEmailOptionName 
		ifAbsentPut: [ LeEmail new email: self defaultEmail ]
]

{ #category : #'api - accessing' }
LeDatabase >> userEmail: anEmail [
	"Set the user's email address"
	| email |

	anEmail isString ifTrue: 
		[ self assert: anEmail isNotEmpty.
		email := LeEmail new email: anEmail ]
	ifFalse:
		[ self assert: anEmail isEmail.
		email := anEmail ].
	self optionAt: self userEmailOptionName put: email.
	monitor ifNotNil: [ monitor userEmail: email email ].
]

{ #category : #'private - accessing' }
LeDatabase >> userEmailOptionName [

	^ #userEmail
]

{ #category : #'api - accessing' }
LeDatabase >> uuid [ 
	"Answer the receiver's UUID"
	<return: #UUID>

	^ monitor 
		ifNil: [ UUID nilUUID ]
		ifNotNil: [ monitor uuid ]
]

{ #category : #'api - accessing' }
LeDatabase >> uuidString [
	"Answer the receiver's UUID in string format"
	<return: #String>

	^ monitor uuidString
]
