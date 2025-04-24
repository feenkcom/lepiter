"
{{gtClass:LeLocalStoreMonitor}} listens to its {{gtClass:LeDatabase}} and saves pages back to disk whenever the page is updated (added, content modified, title changed, removed).

The monitor subscribes to announcements from the database and adds them to a queue of pages to be saved.   After each saveDelay has elapsed it saves all the pages back to the store.  See {{gtMethod:name=LeDatabaseStore>>#defaultDelay}} for the default value.

The monitor can be in one of two states:

- running - it is listening to the database for changes and saving them.
- stopped - it isn't listening.

 
## Internal Representation and Key Implementation Points.

### Instance Variables
	saveDelay:		<Duration>
	state: 			<Symbol>


### Implementation Points

"
Class {
	#name : #LeLocalStoreMonitor,
	#superclass : #LeLocalStore,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'saveDelay',
		'saveQueue',
		'removeQueue',
		'state',
		'corruptFiles',
		'announcer',
		'updatePromise'
	],
	#classVars : [
		'SessionAnnouncer',
		'ShutdownMonitor'
	],
	#category : #'Lepiter-Store-LocalJSON-Store'
}

{ #category : #'api - accessing' }
LeLocalStoreMonitor class >> database: aLeDatabase root: aFileReference [

	^ self new 
		database: aLeDatabase;
		localRoot: aFileReference;
		yourself
]

{ #category : #'class initialization' }
LeLocalStoreMonitor class >> initialize [ 
	"Get notified on session starts so the knowledgebase can be reloaded.
	GtGemStoneSessionRegistry has its priority set to be notified after LeLocalStoreMonitor"

	SessionManager default 
		registerUserClassNamed: self name.

]

{ #category : #accessing }
LeLocalStoreMonitor class >> sessionAnnouncer [

	^ SessionAnnouncer ifNil: [ SessionAnnouncer := Announcer new ]
]

{ #category : #'system startup' }
LeLocalStoreMonitor class >> shutDown: quitting [
	"Announce the shutdown, giving monitors a chance to flush their queues"
	
	"If there is a reloading in the process, we will be waiting all the way until reload is complete,
	then we trigger the shutdown announcement. Since reloading stops the monitor, pausing until
	reloading is finished allows the monitor to handle the shutdown announcement correctly"
	self shutdownMonitor critical: [ self sessionAnnouncer announce: LeLocalJSONStoreShutdown new ]
]

{ #category : #accessing }
LeLocalStoreMonitor class >> shutdownMonitor [

	^ ShutdownMonitor ifNil: [ ShutdownMonitor := Mutex new ]
]

{ #category : #'system startup' }
LeLocalStoreMonitor class >> startUp: resuming [

	(resuming and: [ self noLepiterReload not ]) ifTrue: 
		[ self sessionAnnouncer announce: LeLocalJSONStoreStartup new ]

]

{ #category : #accessing }
LeLocalStoreMonitor >> announcer [ 

	^ announcer
]

{ #category : #accessing }
LeLocalStoreMonitor >> corruptFiles [
	"Answer the receiver's collection of corrupt files"

	^ corruptFiles
]

{ #category : #'schema updating' }
LeLocalStoreMonitor >> forceSchemaUpgradeFrom: aString [ 
	"Run the receiver's db files through an update from the supplied version number, e.g. '3.0'"

	self dbSchema: (LeDbVersion fromString: aString).
	storage updateDbStore: self.
	self reload.
]

{ #category : #'gt-extensions' }
LeLocalStoreMonitor >> gtAttachmentsFor: aView [
	<gtView>
	self attachmentsDirectory ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Attachments';
		priority: 15;
		items: [ self attachmentsDirectory directories ];
		column: 'ID' text: #basename;
		column: 'Name' text: [ :aDirectory | 
			| allFiles |
			allFiles := aDirectory files select: [ :aFile | 
				aFile basename ~= LeAttachment basename ].
			allFiles size = 1
				ifTrue: [ allFiles first basename ]
				ifFalse: [ allFiles size asString, ' attachments' ] ];
		send: [ :aDirectory |
			LeAttachmentWithDiskStorageData 
				fromDirectory: aDirectory
				inDatabase: self database ]
]

{ #category : #'gt-extensions' }
LeLocalStoreMonitor >> gtViewCorruptFilesFor: aView [
	<gtView>
	(corruptFiles isNil or: [
		corruptFiles isEmpty]) ifTrue: [ ^ aView empty ].
	^ aView list
		title: 'Corrupt files';
		priority: 4;
		items: [ self corruptFiles]
]

{ #category : #accessing }
LeLocalStoreMonitor >> gtViewDiskFilesFor: aView [
	"Show the page files as they are on disk"
	<gtView>

	storage ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Files on disk';
		priority: 11;
		items: [ self pagesFromStore
			collect: [ :page | page title -> (self pageFileReference: page) ] ];
		column: 'Title' text: [ :each | each key ];
		column: 'File' text: [ :each | each value basename ];
		send: [ :each | each value ]
]

{ #category : #'gt-extensions' }
LeLocalStoreMonitor >> gtViewStatusDetailsFor: aView [
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

{ #category : #testing }
LeLocalStoreMonitor >> hasChanges [
	^ self isEmpty not
]

{ #category : #testing }
LeLocalStoreMonitor >> hasCorruptPages [
	"Answer a boolean indicating whether the receiver is aware of any corrupt files"

	^ corruptFiles isNotEmpty 
]

{ #category : #initialization }
LeLocalStoreMonitor >> initialize [

	super initialize.
	announcer := Announcer new.
	state := #stopped.
	saveDelay := self defaultDelay.
	saveQueue := WaitfreeQueue new.
	removeQueue := WaitfreeQueue new.
	corruptFiles := #().
]

{ #category : #testing }
LeLocalStoreMonitor >> isEmpty [ 
	"Answer a boolean indicating if the receiver's queues are empty.
	This is approximate as it uses a non-locking test"
	
	^ saveQueue isEmpty and: [ removeQueue isEmpty ]
]

{ #category : #testing }
LeLocalStoreMonitor >> isRunning [ 
	"Answer a boolean indicating whether the receiver is running"

	^ state = #running
]

{ #category : #testing }
LeLocalStoreMonitor >> isRunningCleanly [
	"Answer a boolean indicating whether the receiver is running without any known issues"

	^ state = #running and: [ self hasCorruptPages not ]
]

{ #category : #testing }
LeLocalStoreMonitor >> isVolatileMonitor [
	^ false
]

{ #category : #private }
LeLocalStoreMonitor >> loadCorruptPages [
	"Load the list of corrupt files (which should of course be empty)"

	"Two images sharing a lepiter directory can cause a race condition if one of the images removes the directory.
	While this is bad practice, guard against it by ensuring the directory exists."
	localRoot ensureCreateDirectory.
	corruptFiles := #('*.corrupt' '*.duplicate') flatCollect: [ :pattern |
		localRoot childrenMatching: pattern ]
]

{ #category : #'startup-shutdown' }
LeLocalStoreMonitor >> primitiveReloadWithErrorStrategy: aContentReloadErrorStrategy [
	"Reload the receiver's database."

	self clearDatabaseProperties.
	LeDatabaseReload new
		monitor: self;
		contentReloadErrorStrategy:  aContentReloadErrorStrategy;
		reload
]

{ #category : #'startup-shutdown' }
LeLocalStoreMonitor >> primitiveReloadWithPageDeletion [
	"Reload the receiver's database."

	self clearDatabaseProperties.
	LeDatabaseReload new
		enablePageDeletion;
		monitor: self;
		reload
]

{ #category : #'private - announcements' }
LeLocalStoreMonitor >> processContentTreeChanged: anAnnouncement [
	| page |

	page := anAnnouncement page.
	(page isNil or: [ page isPage not ]) ifTrue: [ ^ self ].

	"If empty pages should be saved, always save the page,
	otherwise save it if it has content."
	(page type saveEmptyPages or: [ page isNotEmpty ]) ifTrue: 
		[ ^ self savePage: page ].

	"If we got here, the page is empty and empty pages shouldn't be saved.
	Remove it from the DB if it exists."
	(self pageFileReference: page) exists ifTrue: 
		[ self removePage: page ].

]

{ #category : #'private - announcements' }
LeLocalStoreMonitor >> processExplicitLinksChanged: anAnnouncement [
	anAnnouncement requiresSavingOfLinks ifTrue: [
		self savePage: anAnnouncement explicitLinks copyForSavingOnlyWithAttachedLinks ]
]

{ #category : #'private - announcements' }
LeLocalStoreMonitor >> processPageAdded: anAnnouncement [
	"Save added pages that aren't empty"

	| page |
	page := anAnnouncement page.
	(page type saveEmptyPages or: [ page isNotEmpty ]) ifTrue: 
		[ self savePage: anAnnouncement page ]
]

{ #category : #'private - announcements' }
LeLocalStoreMonitor >> processPageRemoved: anAnnouncement [

	self removePage: anAnnouncement page.
]

{ #category : #'private - announcements' }
LeLocalStoreMonitor >> processPageTitleChanged: anAnnouncement [

	self savePage: anAnnouncement page.

]

{ #category : #'private - announcements' }
LeLocalStoreMonitor >> processSnippetContentChanged: anAnnouncement [
	self savePage: anAnnouncement snippet page
]

{ #category : #private }
LeLocalStoreMonitor >> queueRemove: aString [
	"Add the supplied page title to the queue of pages to be removed"

	removeQueue nextPut: aString.
	"LeLocalJSONStoreSignal new
		pageTitle: aString;
		operation: #queueRemove;
		emit."
]

{ #category : #private }
LeLocalStoreMonitor >> queueSave: aPage [
	"Add the supplied page to the queue of pages to be saved"

	saveQueue nextPut: aPage.
	"LeLocalJSONStoreSignal new
		pageTitle: aPage title;
		operation: #queueSave;
		emit."
]

{ #category : #'startup-shutdown' }
LeLocalStoreMonitor >> reload [
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy forkDebuggerOnErrorStrategy
]

{ #category : #'startup-shutdown' }
LeLocalStoreMonitor >> reloadWithErrorStrategy: aContentReloadErrorStrategy [
	"Reload the receiver's database.
	If the receiver is part of a logical database, defer to the logical database to coordinate reloads across all concrete databases."

	(database hasParentDatabase and: [ database parent hasProperties ]) ifTrue: 
		[ ^ database parent 
				reloadRequestFrom: database
				withErrorStrategy: aContentReloadErrorStrategy ].
	
	self primitiveReloadWithErrorStrategy: aContentReloadErrorStrategy.
]

{ #category : #'startup-shutdown' }
LeLocalStoreMonitor >> reloadWithNotificationOnError [
	self reloadWithErrorStrategy: LeDatabaseContentReloadErrorStrategy singleNotificationOnErrorStrategy
]

{ #category : #private }
LeLocalStoreMonitor >> removePage: aPage [
	"Remove the supplied page from the local store"

	self removePageFile: (self pageFilename: aPage)

]

{ #category : #private }
LeLocalStoreMonitor >> removePageFile: aString [
	"Remove the supplied page file named aString from the local store"

	saveDelay isZero
		ifTrue: [ self removePageNowNamed: aString ]
		ifFalse: [ self queueRemove: aString ]

]

{ #category : #private }
LeLocalStoreMonitor >> removePageNowNamed: aString [
	"Remove the supplied page file named aString from the local store"
	| pageFile |

	pageFile := localRoot / aString.
	pageFile ensureDelete.
	LeLocalStoreSignal new
		pageTitle: aString;
		operation: #remove;
		emit.
]

{ #category : #private }
LeLocalStoreMonitor >> runTimedUpdate [
	"Perform all the queued updates"

	[ [ self updateEntries ]
		on: UnhandledError fork: [ :ex | ex pass ] ]
			ensure: [ self scheduleNextUpdate ]
]

{ #category : #accessing }
LeLocalStoreMonitor >> saveDelay [
	^ saveDelay
]

{ #category : #accessing }
LeLocalStoreMonitor >> saveDelay: aDuration [
	"Set the duration to wait between updates.
	A duration of 0 means that updates are saved immediately and no further timed updates are scheduled.
	Note that the new duration only takes affect after the next update."

	saveDelay := aDuration
]

{ #category : #private }
LeLocalStoreMonitor >> savePage: aPage [
	"Write the supplied page back to the local store.
	If the saveDelay is 0, write the page immediately, otherwise queue for the next timed update."

	saveDelay isZero
		ifTrue: [ self savePageNow: aPage ]
		ifFalse: [ self queueSave: aPage ]

]

{ #category : #private }
LeLocalStoreMonitor >> scheduleNextUpdate [

	"Queue the next update to be run after the saveDelay duration"

	saveDelay isZero ifTrue: [ ^ self ].

	updatePromise ifNotNil: [ updatePromise cancelSoft ].

	updatePromise := ([ self runTimedUpdate ] asAsyncFuture 
		delayed: saveDelay) await: (AsyncFutureExecutionConfiguration new 
			customGroup: #Lepiter;
			errorHandler: AsyncPassExceptionHandler new)
]

{ #category : #notifications }
LeLocalStoreMonitor >> showNotificationForException: anException withMessage: aMessage [ 
	^ GtObjectNotificationMessage new
		message: aMessage;
		tooltip: 'Inspect loading error';
		object: anException;
		showNotifications;
		registerNotifications
]

{ #category : #'system startup' }
LeLocalStoreMonitor >> shutDown [
	self updateEntries
]

{ #category : #'startup-shutdown' }
LeLocalStoreMonitor >> startMonitoring [
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
	self scheduleNextUpdate.
	self loadCorruptPages.
]

{ #category : #'system startup' }
LeLocalStoreMonitor >> startUp [
	"The system is starting up, reload the databases"

	self submitReload.
]

{ #category : #'startup-shutdown' }
LeLocalStoreMonitor >> stopMonitoring [

	database unsubscribe: self.
	self class sessionAnnouncer unsubscribe: self.
	state := #stopped.

	self announce: (LeLocalStoreMonitorStopped new monitor: self).

	self updateEntries
]

{ #category : #private }
LeLocalStoreMonitor >> submitReload [

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

{ #category : #accessing }
LeLocalStoreMonitor >> uidsInStore [
	"Answer the Set of page UIDs in the receiver"

	^ (storage dbFilesIn: self localRoot)
		collect: [ :fr | fr basenameWithoutExtension ]
		as: Set.
]

{ #category : #private }
LeLocalStoreMonitor >> updateEntries [
	"Perform all the queued updates"
	| oldSaveQueue oldRemoveQueue newSaveQueue newRemoveQueue savePages removePageFiles page sendChanged |
	
	sendChanged := self hasChanges.

	newSaveQueue := WaitfreeQueue new.
	newRemoveQueue := WaitfreeQueue new.

	"Save the old queues and insert the new queues.
	Assignment operations can't be interrupted, so this is atomic and thread safe"
	oldSaveQueue := saveQueue.
	oldRemoveQueue := removeQueue.
	saveQueue := newSaveQueue.
	removeQueue := newRemoveQueue.

	savePages := Set new.
	[ (page := oldSaveQueue nextOrNil) isNotNil ] whileTrue:
		[ savePages add: page ].
	savePages do: [ :each |
		self savePageNow: each ].

	removePageFiles := Set new.
	[ (page := oldRemoveQueue nextOrNil) isNotNil ] whileTrue:
		[ removePageFiles add: page ].
	removePageFiles do: [ :each |
		self removePageNowNamed: each ].

	self announce: (LeStoreMonitorSaved new monitor: self).
	
	sendChanged ifTrue: [
		self announce: (LeStoreMonitorSavedChanges new monitor: self) ]
]

{ #category : #'private - accessing' }
LeLocalStoreMonitor >> updatePromise [
	"Answer the promise that saves queued changes.
	This is internal state, for debugging only."

	^ updatePromise
]

{ #category : #accessing }
LeLocalStoreMonitor >> userEmail: aString [
	"Update the DB properties with the supplied user email.
	It is assumed that the value has already been validated by the database."

	self updateProperty: #userEmail value: aString
]
