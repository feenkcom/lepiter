"
LeDatabaseReload updates a database to match the on-disk storage.

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
		'deletedLinksIDs'
	],
	#category : 'Lepiter-Store-Reload'
}

{ #category : #accessing }
LeDatabaseReload >> database [ 

	^ monitor database
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

	monitorIsRunning := monitor isRunning.
	monitorIsRunning ifTrue: [ monitor stopMonitoring ].
	loadedPageIDs := Set new.
	loadedLinkIDs := Set new.
	reloadedPages := Set new.
	addedPages := Set new.
	addedExplicitLinks := Set new.

	monitor storage updateDbStore: monitor.

	self reloadDatabaseProperties.

	self properties preloadScript ifNotNil: 
		[ :script | script fileIn ].

	[ 
		self updateExplicitLinksContainer.
	
		(self storage dbFilesIn: self localRoot) do: [ :file |
			"Errors while loading the page will be signalled as LeDBLoadError.
			Give callers a chance to handle errors first by catching UnhandledError.
			If there is no handler, fork the exception so the load can continue."
			[ self reloadFile: file ]
				on: UnhandledError 
				fork: [ :ex | ex pass ] ].

		self updateReloadedPages.
		self updateAddedPages.

		self storage withExplicitLinksFileIn: self localRoot do: [ :file |
			[ self reloadExplicitLinksFile: file ] 
				on: UnhandledError 
				fork: [ :ex | ex pass ] ].
		
		self updateAddedExplicitLinks.

		self removeDeletedPages.
		self removeDeletedLinks.
	
	] ensure:
			[ monitorIsRunning 
				ifTrue: [ monitor startMonitoring ]
				ifFalse: [ monitor loadCorruptFilenames ] ].
]

{ #category : #private }
LeDatabaseReload >> reloadDatabaseProperties [
	"Update attributes from lepiter.properties that affect the database"

	self database clearOption: self database userEmailOptionName ifAbsent: [].
	self monitor loadDatabasePropertiesIn: self database.
]

{ #category : #private }
LeDatabaseReload >> reloadExplicitLink: anExplicitLink fromFile: aFile [
	| corruptFileReference |

	(loadedLinkIDs includes: anExplicitLink linkUuid) 
		ifTrue: [ 
			corruptFileReference := (aFile withExtension: 'corrupt') nextVersion.
			UIManager default inform: 'Lepiter: Unable to load: ', corruptFileReference basename, ' in ', corruptFileReference parent fullName, ' due to a duplicate link ID'.
			aFile resolve renameTo: corruptFileReference basename.
			LeDBLoadError new 
				fileReference: corruptFileReference;
				reason: 'Duplicate link ID';
				originalException: nil;
				signal ]
		ifFalse: [ 
			self database
				explicitLinkWithUuid: anExplicitLink linkUuid
				ifPresent: [ :existingLink | existingLink reloadFromExternalLink: anExplicitLink ]
				ifAbsent: [ 
					anExplicitLink onAboutToAddToDatabase: self database.
					self database basicAddExplicitLink: anExplicitLink.
					addedExplicitLinks add: anExplicitLink ].
			
			loadedLinkIDs add: anExplicitLink linkUuid ]
]

{ #category : #private }
LeDatabaseReload >> reloadExplicitLinksFile: aFile [ 
	| explicitLinks  |
	explicitLinks := self storage loadFromFile: aFile.
	explicitLinks do: [ :anExplicitLink |
		self reloadExplicitLink: anExplicitLink fromFile: aFile ].
]

{ #category : #private }
LeDatabaseReload >> reloadFile: file [
	| page corruptFileReference |

	page := self storage loadFromFile: file.
	(loadedPageIDs includes: page uid) ifTrue: 
		[ corruptFileReference := (file withExtension: 'corrupt') nextVersion.
		UIManager default inform: 'Lepiter: Unable to load: ', corruptFileReference basename, ' in ', corruptFileReference parent fullName, ' due to a duplicate page ID'.
		file resolve renameTo: corruptFileReference basename.
		LeDBLoadError new 
			fileReference: corruptFileReference;
			reason: 'Duplicate page ID';
			originalException: nil;
			signal ]
	ifFalse:
		[ self database pageWithID: page uid
			ifPresent: [ :existingPage | reloadedPages add: page
				"existingPage reloadFromPage: page" ]
			ifAbsent: 
				[ self database setPage: page.
				addedPages add: page ].
		loadedPageIDs add: page uid ]
]

{ #category : #actions }
LeDatabaseReload >> reloadOnlyLinks [
	"Reload the receiver's explicit links."

	monitorIsRunning := monitor isRunning.
	monitorIsRunning ifTrue: [ monitor stopMonitoring ].
	
	loadedLinkIDs := Set new.
	addedExplicitLinks := Set new.
	deletedLinksIDs := Set new.

	[ 
		self updateExplicitLinksContainer.

		self storage withExplicitLinksFileIn: self localRoot do: [ :file |
			[ self reloadExplicitLinksFile: file ] 
				on: UnhandledError 
				fork: [ :ex | ex pass ] ].
		
		self updateAddedExplicitLinks.
		self removeDeletedLinks.
	
	] ensure:
			[ monitorIsRunning 
				ifTrue: [ monitor startMonitoring ]
				ifFalse: [ monitor loadCorruptFilenames ] ].
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
LeDatabaseReload >> updateExplicitLinksContainer [
	"When reloading a database ensure that the uid of the container storing
	explicit links is not changed. If it changes than a new file will be created, 
	which we want to avoid."
	
	self storage withExplicitLinksFileIn: self localRoot do: [ :aFile |
		[ 
			| explicitLinks |
			explicitLinks := self storage loadFromFile: aFile.
			
			self database explicitLinks uid
				ifNil: [ 
					self database explicitLinks uid: explicitLinks uid ]
				ifNotNil: [
					self 
						assert: [ self database explicitLinks uid = explicitLinks uid ]
						description: 'The uid of the explicit links container should not change.'  ].
		 ] 
				on: UnhandledError 
				fork: [ :ex | ex pass ] ].
]

{ #category : #private }
LeDatabaseReload >> updateReloadedPages [
	"Tell all the existing pages to reload themselves from the on-disk version.
	This must be called after all new pages have been added (#setPage:)"

	reloadedPages do: [ :page |
		self database pageWithID: page uid
			ifPresent: [ :existingPage | existingPage reloadFromPage: page ]
			ifAbsent: [ self error: 'Unable to find existing page' ] ].
]
