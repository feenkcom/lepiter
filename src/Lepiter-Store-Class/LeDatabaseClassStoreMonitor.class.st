"
This version uses a single queue for page saves and removes, and adds a reload operation.  The intention is that it will listen to system notifications about the store class and reload when a page is changed externally, e.g. by updating from the code repository, e.g. git, or manual changes through Coder (even though that shouldn't normally be done).
"
Class {
	#name : #LeDatabaseClassStoreMonitor,
	#superclass : #LeDatabaseClassStore,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'saveDelay',
		'queue',
		'state',
		'announcer',
		'updatePromise',
		'corruptSelectors',
		'currentEntry'
	],
	#classVars : [
		'SessionAnnouncer',
		'ShutdownMonitor'
	],
	#category : #'Lepiter-Store-Class-Model'
}

{ #category : #'api - accessing' }
LeDatabaseClassStoreMonitor class >> database: aLeDatabase root: aFileReference [

	^ self new 
		database: aLeDatabase;
		localRoot: aFileReference;
		yourself
]

{ #category : #'class initialization' }
LeDatabaseClassStoreMonitor class >> initialize [ 
	"Get notified on session starts so the knowledgebase can be reloaded.
	GtGemStoneSessionRegistry has its priority set to be notified after LeLocalStoreMonitor"

	SessionManager default 
		registerUserClassNamed: self name.

]

{ #category : #accessing }
LeDatabaseClassStoreMonitor class >> sessionAnnouncer [

	^ SessionAnnouncer ifNil: [ SessionAnnouncer := Announcer new ]
]

{ #category : #'system startup' }
LeDatabaseClassStoreMonitor class >> shutDown: quitting [
	"Announce the shutdown, giving monitors a chance to flush their queues"
	
	"If there is a reloading in the process, we will be waiting all the way until reload is complete,
	then we trigger the shutdown announcement. Since reloading stops the monitor, pausing until
	reloading is finished allows the monitor to handle the shutdown announcement correctly"
	self shutdownMonitor critical: [ self sessionAnnouncer announce: LeLocalJSONStoreShutdown new ]
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor class >> shutdownMonitor [

	^ ShutdownMonitor ifNil: [ ShutdownMonitor := Mutex new ]
]

{ #category : #'system startup' }
LeDatabaseClassStoreMonitor class >> startUp: resuming [

	(resuming and: [ self noLepiterReload not ]) ifTrue: 
		[ self sessionAnnouncer announce: LeLocalJSONStoreStartup new ]

]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> announcer [ 

	^ announcer
]

{ #category : #attachments }
LeDatabaseClassStoreMonitor >> attachmentProperties: attachmentPath [
	"Answer the properties of the specified attachment"

	^ dbClass perform: ('attachment_', attachmentPath) asSymbol.
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> corruptSelectors [
	"Answer the receiver's collection of corrupt selectors"

	^ corruptSelectors
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> explicitLinksOrNil [

	^ storage explicitLinksOrNilFor: dbClass
]

{ #category : #'schema updating' }
LeDatabaseClassStoreMonitor >> forceSchemaUpgradeFrom: aString [ 
	"Run the receiver's db files through an update from the supplied version number, e.g. '3.0'"

	self error: 'Not yet migrated'.
	self dbSchema: (LeDbVersion fromString: aString).
	storage updateDbStore: self.
	self reload.
]

{ #category : #'gt-extensions' }
LeDatabaseClassStoreMonitor >> gtAttachmentsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Attachments';
		priority: 15;
		items: [ self attachmentIds ];
		column: 'ID' text: #yourself;
		column: 'Name' text: [ :id | 
			| selector properties |
			selector := storage attachmentSelectorFor: id.
			properties := dbClass perform: selector.
			properties fileNameDescription ];
		send: [ :anAttachmentId |
			self attachmentWithDataForId: (UUID 
				fromString36: anAttachmentId) ];
		actionUpdateButton
]

{ #category : #'gt-extensions' }
LeDatabaseClassStoreMonitor >> gtViewCorruptFilesFor: aView [
	<gtView>

	(corruptSelectors isNil or: [
		corruptSelectors isEmpty]) ifTrue: [ ^ aView empty ].
	^ aView list
		title: 'Corrupt files';
		priority: 4;
		items: [ self corruptSelectors];
		send: [ :selector | self dbClass >> selector ]
]

{ #category : #'gt-extensions' }
LeDatabaseClassStoreMonitor >> gtViewStatusDetailsFor: aView [
	<gtView>

	^ aView columnedList
		title: 'Details';
		priority: 5;
		items: [ {
			'Has pending change' -> self hasChanges.
			'Has corrupt files' -> self hasCorruptPages .
			'Is monitor stopped' -> self isRunning not}];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		send: #value
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> handleDbClassRemoved [
	"Handle the dbClass being removed.
	Empty the database and stop monitoring."

	self stopMonitoring.
	database pages do: [ :page |
		database removePage: page ].
]

{ #category : #testing }
LeDatabaseClassStoreMonitor >> hasChanges [
	^ self isEmpty not
]

{ #category : #testing }
LeDatabaseClassStoreMonitor >> hasCorruptPages [
	"Answer a boolean indicating whether the receiver is aware of any corrupt pages"

	^ corruptSelectors isNotEmpty 
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> hasPageStored: aPage [
	"Answer a boolean indicating whether the supplied page is in storage"

	^ storage hasPageStored: aPage inClass: dbClass
]

{ #category : #initialization }
LeDatabaseClassStoreMonitor >> initialize [

	super initialize.
	announcer := Announcer new.
	state := #stopped.
	saveDelay := self defaultDelay.
	queue := WaitfreeQueue new.
	corruptSelectors := #().
]

{ #category : #testing }
LeDatabaseClassStoreMonitor >> isEmpty [ 
	"Answer a boolean indicating if the receiver's queue is empty.
	This is approximate as it uses a non-locking test"
	
	^ queue isEmpty
]

{ #category : #testing }
LeDatabaseClassStoreMonitor >> isRunning [ 
	"Answer a boolean indicating whether the receiver is running"

	^ state = #running
]

{ #category : #testing }
LeDatabaseClassStoreMonitor >> isRunningCleanly [
	"Answer a boolean indicating whether the receiver is running without any known issues"

	^ state = #running and: [ self hasCorruptPages not ]
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> loadCorruptPages [
	"Load the list of corrupt files (which should of course be empty)"

	corruptSelectors := dbClass class selectors select: [ :selector |
		(selector beginsWith: 'corrupted_') or:
		[ selector beginsWith: 'duplicate_' ] ].
	^ corruptSelectors.
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> onClassCommented: anAnnouncement [
	"No action required"
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> onClassRemoved: anAnnouncement [

	({ dbClass name. 'AnObsolete', dbClass name. } includes: anAnnouncement classRemoved name) ifFalse: [ ^ self ].
	saveDelay isZero ifTrue: [ self stopMonitoring ].
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> onClassRenamed: anAnnouncement [
	"No action required"
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> onMethodAdded: anAnnouncement [

	self onMethodModified: anAnnouncement
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> onMethodModified: anAnnouncement [

	(self shouldProcessMethodAnnouncement: anAnnouncement) ifFalse: [ ^ self ].
	self reloadPageSelector: anAnnouncement selector.
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> onMethodRemoved: anAnnouncement [

	(self shouldProcessMethodAnnouncement: anAnnouncement) ifFalse: [ ^ self ].
	self removePageSelector: anAnnouncement method selector.
]

{ #category : #'startup-shutdown' }
LeDatabaseClassStoreMonitor >> primitiveReloadWithErrorStrategy: aContentReloadErrorStrategy [
	"Reload the receiver's database."

	self clearDatabaseProperties.
	LeDatabaseReload new
		monitor: self;
		contentReloadErrorStrategy:  aContentReloadErrorStrategy;
		reload
]

{ #category : #'startup-shutdown' }
LeDatabaseClassStoreMonitor >> primitiveReloadWithPageDeletion [
	"Reload the receiver's database."

	self clearDatabaseProperties.
	LeDatabaseReload new
		enablePageDeletion;
		monitor: self;
		reload
]

{ #category : #'private - announcements' }
LeDatabaseClassStoreMonitor >> processContentTreeChanged: anAnnouncement [
	| page |

	page := anAnnouncement page.
	(page isNil or: [ page isPage not ]) ifTrue: [ ^ self ].

	"If empty pages should be saved, always save the page,
	otherwise save it if it has content."
	(page type saveEmptyPages or: [ page isNotEmpty ]) ifTrue: 
		[ ^ self saveIfReloadingSelectorIsDifferentThenPage: page ].

	"If we got here, the page is empty and empty pages shouldn't be saved.
	Remove it from the DB if it exists."
	dbClass class methodDict
		at: (storage pageSelectorFor: page)
		ifPresent: [ :method | method removeFromSystem ].
]

{ #category : #'private - announcements' }
LeDatabaseClassStoreMonitor >> processExplicitLinksChanged: anAnnouncement [
	anAnnouncement requiresSavingOfLinks ifTrue: [
		self savePage: anAnnouncement explicitLinks copyForSavingOnlyWithAttachedLinks ]
]

{ #category : #'private - announcements' }
LeDatabaseClassStoreMonitor >> processPageAdded: anAnnouncement [
	"Save added pages that aren't empty"
	| page |

	page := anAnnouncement page.
	(page type saveEmptyPages or: [ page isNotEmpty ]) ifTrue: 
		[ self saveIfReloadingSelectorIsDifferentThenPage: anAnnouncement page ]
]

{ #category : #'private - announcements' }
LeDatabaseClassStoreMonitor >> processPageRemoved: anAnnouncement [

	self removePage: anAnnouncement page.
]

{ #category : #'private - announcements' }
LeDatabaseClassStoreMonitor >> processPageTitleChanged: anAnnouncement [
	anAnnouncement page ifNil: [ ^ self ].
	
	self saveIfReloadingSelectorIsDifferentThenPage: anAnnouncement page
]

{ #category : #'private - announcements' }
LeDatabaseClassStoreMonitor >> processSnippetContentChanged: anAnnouncement [
	anAnnouncement snippet page ifNil: [ ^ self ].
	
	self saveIfReloadingSelectorIsDifferentThenPage: anAnnouncement snippet page
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> queueReload: aSymbol [
	"Add the supplied page selector to the queue of pages to be reloaded"

	queue nextPut: (LeDatabaseClassStoreQueueReloadPageEntry new
		monitor: self;
		pageSelector: aSymbol).
	self announce: (LeStoreMonitorEntryQueued new monitor: self).
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> queueRemove: aSymbol [
	"Add the supplied page selector to the queue of pages to be removed"

	queue nextPut: (LeDatabaseClassStoreQueueRemovePageEntry new
		monitor: self;
		pageSelector: aSymbol).
	self announce: (LeStoreMonitorEntryQueued new monitor: self).
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> queueSave: aPage [
	"Add the supplied page to the queue of pages to be saved"

	queue nextPut: (LeDatabaseClassStoreQueueStorePageEntry new
		monitor: self;
		page: aPage).
	self announce: (LeStoreMonitorEntryQueued new monitor: self).
]

{ #category : #'startup-shutdown' }
LeDatabaseClassStoreMonitor >> reload [
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy forkDebuggerOnErrorStrategy
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> reloadPageSelector: aSymbol [ 

	saveDelay isZero
		ifTrue: [ self reloadPageSelectorNow: aSymbol ]
		ifFalse: [ self queueReload: aSymbol ]
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> reloadPageSelectorNow: aSymbol [
	"Reload the supplied page file named aString from the local store"
	| page reloader |

	page := [ storage loadFromClass: dbClass selector: aSymbol ]
		on: LeDBLoadError
		do: [ :ex |
			corruptSelectors := corruptSelectors copyWith: aSymbol.
			ex pass ].
	reloader := LeDatabaseReload new.
	reloader monitor: self.
	page isExplicitLinks 
		ifTrue: [ reloader reloadExplicitLinks: page ]
		ifFalse: [ reloader reloadPage: page ].
	reloader
		updateReloadedPages;
		updateAddedPages;
		updateAddedExplicitLinks.
	LeLocalStoreSignal new
		pageTitle: aSymbol;
		operation: #remove;
		emit.
]

{ #category : #'startup-shutdown' }
LeDatabaseClassStoreMonitor >> reloadWithErrorStrategy: aContentReloadErrorStrategy [
	"Reload the receiver's database.
	If the receiver is part of a logical database, defer to the logical database to coordinate reloads across all concrete databases."

	(database hasParentDatabase and: [ database parent hasProperties ]) ifTrue: 
		[ ^ database parent 
				reloadRequestFrom: database
				withErrorStrategy: aContentReloadErrorStrategy ].
	
	self primitiveReloadWithErrorStrategy: aContentReloadErrorStrategy.
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> reloadWithNotificationOnError [
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy singleNotificationOnErrorStrategy
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> removePage: aPage [
	"Remove the supplied page from the local store"

	self removePageSelector: (storage pageSelectorFor: aPage)
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> removePageSelector: aSymbol [
	"Remove the supplied page selector from the store"

	saveDelay isZero
		ifTrue: [ self removePageSelectorNow: aSymbol ]
		ifFalse: [ self queueRemove: aSymbol ]
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> removePageSelectorNow: aSymbol [
	"Remove the supplied page file named aString from the local store"

	dbClass class methodDict
		at: aSymbol
		ifPresent: [ :method | method removeFromSystem ].
	database
		pageByUuid: (storage pageUidForSelector: aSymbol)
		ifPresent: [ :page | database removePage: page ].
	LeLocalStoreSignal new
		pageTitle: aSymbol;
		operation: #remove;
		emit.
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> runTimedUpdate [
	"Perform all the queued updates"

	[ [ self updateEntries ]
		on: UnhandledError fork: [ :ex | ex pass ] ]
			ensure: [ self scheduleNextUpdate ]
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> saveDelay [
	^ saveDelay
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> saveDelay: aDuration [
	"Set the duration to wait between updates.
	A duration of 0 means that updates are saved immediately and no further timed updates are scheduled.
	Note that the new duration only takes affect after the next update."

	saveDelay := aDuration
]

{ #category : #'private - announcements' }
LeDatabaseClassStoreMonitor >> saveIfReloadingSelectorIsDifferentThenPage: aPage [
	| reloadingSelector |
	
	reloadingSelector := LeDatabaseClassStoreReloadPageId value.
	(storage pageSelectorForUid: aPage uid) = reloadingSelector ifTrue: [ ^ self ].
	
	self savePage: aPage.
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> savePage: aPage [
	"Write the supplied page back to the local store.
	If the saveDelay is 0, write the page immediately, otherwise queue for the next timed update."

	saveDelay isZero
		ifTrue: [ self savePageNow: aPage ]
		ifFalse: [ self queueSave: aPage ]

]

{ #category : #private }
LeDatabaseClassStoreMonitor >> scheduleNextUpdate [

	"Queue the next update to be run after the saveDelay duration"

	saveDelay isZero ifTrue: [ ^ self ].

	updatePromise ifNotNil: [ updatePromise cancelSoft ].

	updatePromise := ([ self runTimedUpdate ] asAsyncFuture 
		delayed: saveDelay) 
			await: (AsyncFutureExecutionConfiguration new 
				customGroup: #Lepiter;
				errorHandler: AsyncPassExceptionHandler new)
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> shouldProcessMethodAnnouncement: anAnnouncement [ 
	| selector |
	
	anAnnouncement methodClass = dbClass class ifFalse: [ ^ false ].
	selector := anAnnouncement selector.
	(currentEntry isNotNil and: [ selector = currentEntry pageSelector ]) ifTrue:
		[ ^ false ].
	^ (selector beginsWith: 'page_') or: [ selector = #explicitLinks ]
]

{ #category : #notifications }
LeDatabaseClassStoreMonitor >> showNotificationForException: anException withMessage: aMessage [ 
	^ GtObjectNotificationMessage new
		message: aMessage;
		tooltip: 'Inspect loading error';
		object: anException;
		showNotifications;
		registerNotifications
]

{ #category : #'system startup' }
LeDatabaseClassStoreMonitor >> shutDown [
	self updateEntries
]

{ #category : #'startup-shutdown' }
LeDatabaseClassStoreMonitor >> startMonitoring [
	state = #running ifTrue: [ ^ self ].
	state := #running.
	
	self announce: (LeLocalStoreMonitorStarted new monitor: self).
	
	database weak when: LeSnippetContentChanged send: #processSnippetContentChanged: to: self.
	database weak when: LeContentTreeChanged send: #processContentTreeChanged: to: self.
	database weak when: LeDatabasePageAdded send: #processPageAdded: to: self.
	database weak when: LeDatabasePageRemoved send: #processPageRemoved: to: self.
	database weak when: LePageTitleChanged send: #processPageTitleChanged: to: self.
	database weak when: LeExplicitLinksChange send: #processExplicitLinksChanged: to: self.
	
	self class sessionAnnouncer weak when: LeLocalJSONStoreShutdown send: #shutDown to: self.
	self class sessionAnnouncer weak when: LeLocalJSONStoreStartup send: #startUp to: self.
	self subscribeToSystemAnnouncer.
	self scheduleNextUpdate.
	self loadCorruptPages.
]

{ #category : #'system startup' }
LeDatabaseClassStoreMonitor >> startUp [
	"The system is starting up, reload the databases"

	self submitReload.
]

{ #category : #'startup-shutdown' }
LeDatabaseClassStoreMonitor >> stopMonitoring [

	state = #stopped ifTrue: [ ^ self ].
	database unsubscribe: self.
	self class sessionAnnouncer unsubscribe: self.
	SystemAnnouncer uniqueInstance unsubscribe: self.
	state := #stopped.
	self updateEntries.

	self announce: (LeLocalStoreMonitorStopped new monitor: self).
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> submitReload [

	([ self class shutdownMonitor 
		critical: [ self reloadWithNotificationOnError ] ]
			asAsyncFuture await: (AsyncFutureExecutionConfiguration new 
				customGroup: #Lepiter))
					then: [ ]
					otherwise: [ :anException |
						anException freeze.
						self 
							showNotificationForException: anException
							withMessage:(String streamContents: [ :aStream |
								aStream 
									<< 'Fatal error during Lepiter reload: ';
									<< anException description;
									cr; cr;
									<< 'The database can be in an inconsistent state. ';
									<< 'Resolve this problem before continuing to use the image! See "How to fix Lepiter loading errors".' ]) ]
]

{ #category : #'system announcements' }
LeDatabaseClassStoreMonitor >> subscribeToSystemAnnouncer [

	{   ClassRemoved->#onClassRemoved:.
		MethodAdded -> #onMethodAdded:.
		MethodRemoved -> #onMethodRemoved:.
		MethodModified -> #onMethodModified:.
		ClassRenamed -> #onClassRenamed:.
		ClassCommented -> #onClassCommented:.
	} do: [ :pair |
		SystemAnnouncer uniqueInstance weak
			when: pair key 
			send: pair value 
			to: self ].
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> uidsInStore [

	^ (storage pageSelectorsIn: dbClass) 
		collect: [ :selector | selector asString copyFrom: 6 to: selector size ]
		as: Set
]

{ #category : #private }
LeDatabaseClassStoreMonitor >> updateEntries [
	"Perform all the queued updates"
	| oldQueue newQueue entries entry sendChanged |

	sendChanged := self hasChanges.

	newQueue := WaitfreeQueue new.

	"Save the old queues and insert the new queues.
	Assignment operations can't be interrupted, so this is atomic and thread safe"
	oldQueue := queue.
	queue := newQueue.

	"If the receiver's dbClass is obsolete shut down."
	dbClass isObsolete ifTrue: [ ^ self handleDbClassRemoved ].

	entries := OrderedCollection new.
	[ (entry := oldQueue nextOrNil) isNotNil ] whileTrue:
		[ entries add: entry ].
	entries do: [ :each | 
		currentEntry := each.
		each apply ].
	currentEntry := nil.

	self announce: (LeStoreMonitorSaved new monitor: self).
	
	sendChanged ifTrue: [
		self announce: (LeStoreMonitorSavedChanges new monitor: self) ]
]

{ #category : #'private - accessing' }
LeDatabaseClassStoreMonitor >> updatePromise [
	"Answer the promise that saves queued changes.
	This is internal state, for debugging only."

	^ updatePromise
]

{ #category : #accessing }
LeDatabaseClassStoreMonitor >> userEmail: aString [
	"Update the DB properties with the supplied user email.
	It is assumed that the value has already been validated by the database."

	self updateProperty: #userEmail value: aString
]
