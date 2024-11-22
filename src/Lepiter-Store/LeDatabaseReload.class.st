"
LeDatabaseReload updates a database to match the on-disk storage.

### Notes

Pages that have been deleted on disk are not removed from the in-memory copy by default.  This is to prevent pages that are added prior to the reload completing from being incorrectly removed.  Most people move to a new image fairly regularly and the deleted page will be lost at that point.  Keeping the deleted page in memory is considered less of an evil than removing a page that someone has just added (and which hasn't been saved to disk).

The intention is to move to implementing all changes as commands and saving a transaction log.  At that point, reloading the database will be a replay of the transaction log, and so will avoid this issue (we well as being much faster).

See: <https://github.com/feenkcom/gtoolkit/issues/2163>
"
Class {
	#name : #LeDatabaseReload,
	#superclass : #Object,
	#instVars : [
		'monitor',
		'monitorIsRunning',
		'loadedPageIDs',
		'addedPages',
		'reloadedPages',
		'loadedLinkIDs',
		'addedExplicitLinks',
		'deletedPageIDs',
		'deletedLinksIDs',
		'shouldDeletePages',
		'contentReloadErrorStrategy'
	],
	#category : #'Lepiter-Store-Reload'
}

{ #category : #accessing }
LeDatabaseReload >> contentReloadErrorStrategy: aContentReloadErrorStrategy [
	self assert: [ aContentReloadErrorStrategy notNil ].
	
	contentReloadErrorStrategy := aContentReloadErrorStrategy
]

{ #category : #accessing }
LeDatabaseReload >> database [ 

	^ monitor database
]

{ #category : #initialization }
LeDatabaseReload >> defaultContentReloadErrorStrategy [
	^ LeDatabaseContentReloadErrorStrategy forkDebuggerOnErrorStrategy
]

{ #category : #accessing }
LeDatabaseReload >> enablePageDeletion [
	shouldDeletePages := true
]

{ #category : #initialization }
LeDatabaseReload >> initialize [
	super initialize.
	
	self resetData.
	self contentReloadErrorStrategy: self defaultContentReloadErrorStrategy
]

{ #category : #accessing }
LeDatabaseReload >> localRoot [ 

	^ monitor localRoot
]

{ #category : #accessing }
LeDatabaseReload >> monitor [
	^ monitor
]

{ #category : #accessing }
LeDatabaseReload >> monitor: anObject [
	monitor := anObject
]

{ #category : #accessing }
LeDatabaseReload >> properties [ 

	^ self database properties
]

{ #category : #actions }
LeDatabaseReload >> reload [
	"Reload the receiver's database.
	The monitor has flushed the db properties prior to calling this method."

	monitor database hasParentDatabase ifFalse: [
		"If there is logical parent database, then LeDatabaseAboutToReload
		was already announced. We therefore do not repeat it. We want to let users
		know as soon as possible, that a database is going to be reloaded. UI widgets
		can therefore disable editing, etc."
		monitor database announce: (LeDatabaseAboutToReload new
			logicalDatabase: monitor database parent;
			database: monitor database) ].
	
	monitorIsRunning := monitor isRunning.
	monitorIsRunning ifTrue: [ monitor stopMonitoring ].

	self resetData.

	monitor storage updateDbStore: monitor.
	self reloadDatabaseProperties.
	self properties preloadScript ifNotNil: [ :script | script fileIn ].

	[ | explicitLinks |
	contentReloadErrorStrategy actBeforeDatabaseReloadFor: self database.

	explicitLinks := monitor loadExplicitLinks.
	self updateExplicitLinksContainer: explicitLinks.

	monitor pagesFromStore
		do: [ :page | contentReloadErrorStrategy executeManaged: [ self reloadPage: page ] ].

	self updateReloadedPages.
	self updateAddedPages.

	contentReloadErrorStrategy
		executeManaged: [ self reloadExplicitLinks: explicitLinks ].

	self updateAddedExplicitLinks.
	
	"Only remove deleted pages if the flag is set.
	This removes pages that are added (new pages) prior to the reload completing.
	See the class comments for more information."
	self shouldDeletePages ifTrue: [ self removeDeletedPages ].
	self removeDeletedLinks.

	contentReloadErrorStrategy actAfterDatabaseReloadFor: self database ]
		ensure: [ monitorIsRunning
				ifTrue: [ monitor startMonitoring ]
				ifFalse: [ monitor loadCorruptPages ] ].
				
	monitor database announce: (LeDatabaseReloaded new
		logicalDatabase: monitor database parent;
		database: monitor database).
]

{ #category : #private }
LeDatabaseReload >> reloadDatabaseProperties [
	"Update attributes from lepiter.properties that affect the database"

	self database clearOption: self database userEmailOptionName ifAbsent: [].
	self monitor loadDatabasePropertiesIn: self database.
]

{ #category : #private }
LeDatabaseReload >> reloadExplicitLink: anExplicitLink [
	| loadError |

	(loadedLinkIDs includes: anExplicitLink linkUuid) 
		ifTrue: [ 
			UIManager default inform: 'Lepiter: Unable to load explicitLinks due to a duplicate link ID: ', anExplicitLink linkUuid printString.
			loadError := LeDBLoadError new.
			loadError properties at: #explicitLink put: anExplicitLink.
			loadError
				pageTitle: '<Explicit Links>';
				pageUid: anExplicitLink linkUuid;
				reason: 'Duplicate link ID';
				originalException: nil;
				signal ]
		ifFalse: [ 
			self database
				explicitLinkWithUuid: anExplicitLink linkUuid
				ifPresent: [ :existingLink | 
					existingLink reloadFromExternalLink: anExplicitLink ]
				ifAbsent: [ 
					anExplicitLink onAboutToAddToDatabase: self database.
					self database basicAddExplicitLink: anExplicitLink.
					addedExplicitLinks add: anExplicitLink ].
			
			loadedLinkIDs add: anExplicitLink linkUuid ]
]

{ #category : #private }
LeDatabaseReload >> reloadExplicitLinks: explicitLinks [

	explicitLinks ifNil: [ ^ self ].
	
	LePageIsReloadNecessaryChecker new
		existingPage: self database explicitLinks;
		loadedPage: explicitLinks;
		ifUpToDate: [ ^ self ] ifOutOfDate: [ "ignore" ].
	
	explicitLinks do: [ :anExplicitLink |
		self reloadExplicitLink: anExplicitLink ].
		
	LeReloadOptimization ifEnabled: [
		self database explicitLinks storageHash: explicitLinks storageHash ]
]

{ #category : #actions }
LeDatabaseReload >> reloadOnlyLinks [
	"Reload the receiver's explicit links."

	monitorIsRunning := monitor isRunning.
	monitorIsRunning ifTrue: [ monitor stopMonitoring ].
	
	loadedLinkIDs := Set new.
	addedExplicitLinks := Set new.
	deletedLinksIDs := Set new.

	[ | explicitLinks |
	explicitLinks := monitor loadExplicitLinks.
	self updateExplicitLinksContainer: explicitLinks.

	[ self reloadExplicitLinks: explicitLinks ] 
		on: UnhandledError 
		fork: [ :ex | ex pass ].

	self updateAddedExplicitLinks.
	self removeDeletedLinks.

	] ensure:
			[ monitorIsRunning 
				ifTrue: [ monitor startMonitoring ]
				ifFalse: [ monitor loadCorruptPages ] ].
]

{ #category : #private }
LeDatabaseReload >> reloadPage: page [

	(loadedPageIDs includes: page uid) 
		ifTrue: [ 
			monitor signalDuplicatePage: page 
				reason: 'Duplicate page ID' 
				originalException: nil]
		ifFalse: [ 
			self database 
				pageWithID: page uid
				ifPresent: [ :existingPage | 
					reloadedPages add: page
					"existingPage reloadFromPage: page" ]
				ifAbsent: 
					[ self database setPage: page.
					addedPages add: page ].
			loadedPageIDs add: page uid ]
]

{ #category : #private }
LeDatabaseReload >> removeDeletedLinks [
	deletedLinksIDs := ((self database explicitLinks
		select: [ :aLink | aLink isAttachedLink ])
		collect: #linkUuid as: Set) difference: loadedLinkIDs.
	deletedLinksIDs do: [ :uuid |
		self database removeExplicitLinks: {self database explicitLinkWithUuid: uuid} ]
]

{ #category : #private }
LeDatabaseReload >> removeDeletedPages [
	deletedPageIDs := (self database pages collect: #uid as: Set) difference: loadedPageIDs.
	deletedPageIDs do: [ :uid |
		self database removePage: (self database pageWithID: uid) ]
]

{ #category : #initialization }
LeDatabaseReload >> resetData [
	loadedPageIDs := Set new.
	loadedLinkIDs := Set new.
	reloadedPages := Set new.
	addedPages := Set new.
	addedExplicitLinks := Set new
]

{ #category : #accessing }
LeDatabaseReload >> shouldDeletePages [
	^ shouldDeletePages ifNil: [ false ] 
]

{ #category : #accessing }
LeDatabaseReload >> storage [ 

	^ monitor storage
]

{ #category : #private }
LeDatabaseReload >> updateAddedExplicitLinks [

	addedExplicitLinks do: [ :anExplicitLink |
		anExplicitLink onAddedToDatabase: self database.
		self database basicAddLinkToContentCache: anExplicitLink ]
]

{ #category : #private }
LeDatabaseReload >> updateAddedPages [

	addedPages do: [ :page |
		self database setPageUpdate: page ]
]

{ #category : #private }
LeDatabaseReload >> updateExplicitLinksContainer: explicitLinks [
	"When reloading a database ensure that the uid of the container storing
	explicit links is not changed. If it changes than a new file will be created, 
	which we want to avoid."

	explicitLinks ifNil: [ ^ self ].
	[ self database explicitLinks uid
		ifNil: [ 
			self database explicitLinks uid: explicitLinks uid ]
		ifNotNil: [
			self 
				assert: [ self database explicitLinks uid = explicitLinks uid ]
				description: 'The uid of the explicit links container should not change.'  ] ] 
			on: UnhandledError 
			fork: [ :ex | ex pass ].
]

{ #category : #private }
LeDatabaseReload >> updateReloadedPages [
	"Tell all the existing pages to reload themselves from the on-disk version.
	This must be called after all new pages have been added (#setPage:)"

	reloadedPages do: [ :page |
		self database 
			pageWithID: page uid
			ifPresent: [ :existingPage | existingPage newReloadFromPage: page ]
			ifAbsent: [ self error: 'Unable to find existing page' ] ].
]
