"
A LePage is a collection of snippets, that can mostly be considered analogous to a printed page.


 
## Internal Representation and Key Implementation Points.

### Instance Variables
	latestEditTime:		<LeTime>
	type:					<LePageType>
	uid:					<UUID>


### Implementation Points

- While the UID of the page is generated at instance creation, databases are free to change it if a conflict is found when adding the page to the database.  While in a database the UID may not be changed.
- The UID is used by LeLocalStore to generate the file name.

"
Class {
	#name : #LePage,
	#superclass : #LeContent,
	#instVars : [
		'type',
		'latestEditTime',
		'uid',
		'editHistory'
	],
	#category : #'Lepiter-Core-Model'
}

{ #category : #factory }
LePage class >> builder [
	^ LePageBuilder new
]

{ #category : #factory }
LePage class >> empty [
	"Return a page or empty title"
	^ self named: ''
]

{ #category : #'instance creation' }
LePage class >> named: aTitleString [

	^ self new initializeTitle: aTitleString
]

{ #category : #'instance creation' }
LePage class >> pharoClassName: aSymbol [

	^ self new initializePharoClassName: aSymbol
]

{ #category : #'instance creation' }
LePage class >> pharoCommentClassName: aSymbol [

	^ self new initializePharoCommentClassName: aSymbol
]

{ #category : #'instance creation' }
LePage class >> unnamedPage [

	^ self new initializeUnnamedPage
]

{ #category : #'instance creation' }
LePage class >> unnamedPageWithDefaultTitle: aString [
	| newPage |
	newPage := self new initializeUnnamedPage.
	newPage type defaultTitle: aString.
	^ newPage
]

{ #category : #visiting }
LePage >> acceptVisitor: aVisitor [

	^ aVisitor visitPage: self
]

{ #category : #'api - links' }
LePage >> addAllIncomingUnlinked: aCollection [
	"Add all the incoming unlinked references to the receiver"

	aCollection ifEmpty: [ ^ self ].
	(self optionAt: self incomingUnlinkedOptionName ifAbsentPut: [ OrderedCollection new ])
		addAll: aCollection
]

{ #category : #'api - links' }
LePage >> addExplicitLinkTo: aTargetReference [
	self assert: [ self database notNil ].
	self 
		assert: [ self database isDatabase ] 
		description: 'Explicit links shoud be attached this way only if the 
page is associated to a database. If not the link will be lost.'.
	
	self database addExplicitLink: (LeAttachedLink new
		originReference: (LeLinkPageUidReference forPage: self);
		targetReference: aTargetReference).
]

{ #category : #'private - accessing' }
LePage >> allOutgoingTargets [
	"Return the list of actual target pages linked to from this page.
	NB: a LeLinkExternalUrlReference does't have a content."

	^ (self allOutgoingExplicitLinks items
		collect: [ :link | [ link targetReference content ] onErrorDo: [ nil ] ])
		select: #notNil
]

{ #category : #accessing }
LePage >> asMarkdownPage [
	"Produce a markdown page with a YAML header suitable for use with GitHub pages, Pico, or other markdown-based websites."

	^ String
		streamContents: [ :stream | 
			stream
				<< '---';
				cr;
				<< 'Title: ';
				<< self title;
				cr;
				<< '---';
				cr.
			self markdownOn: stream ]
]

{ #category : #'api - converting' }
LePage >> asPagePhlowTool [
	"Inspect me to obtain a LePage tool view first."

	^ GtPhlowCompositeTool new
		addTool: (LePagePhlowTool new
				shouldFocusFirstSnippet: true;
				page: self)
]

{ #category : #'api - converting' }
LePage >> asRemoteLink [
	"Answer the string representing a remote link to the receiver"

	^ String streamContents: [ :stream |
		stream
			<< '{{gtPage:';
			<< type remoteLinkId;
			<< '|db=';
			<< self database uuidString;
			<< '}}' ].

]

{ #category : #'private - asserting' }
LePage >> assertTitle: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Title must be non-nil' ].
	self 
		assert: [ (self database
			pageNamed: aString
			ifAbsent: [ nil ]) isNil ]
		description: [ 'Title must not exist in a database: ', aString ].
]

{ #category : #private }
LePage >> assignNewUID [
	"Assign the receiver a new UID"

	uid := UUID new.
]

{ #category : #'api - attachments' }
LePage >> attachments [
	^ LeContentAttachmentsCollector new
		content: self;
		all
]

{ #category : #'private - accessing' }
LePage >> basicUid [ 

	^ uid
]

{ #category : #'private - accessing' }
LePage >> basicUid: aUUID [
	"Set the receiver's UID.
	Only for testing purposes."

	uid := aUUID
]

{ #category : #'api - testing' }
LePage >> canMoveToAnotherDatabase [
	"A page can be moved if all of its snippets can be moved.
	NB: new snippet types should override LeSnippet>>#canBeMoved"

	(self outgoingExplicitLinks anySatisfy: [ :aLink | aLink isAttachedLink ])
		ifTrue: [ ^ false ].
	(self incomingLinks anySatisfy: [ :aLink | aLink isAttachedLink ])
		ifTrue: [ ^ false ].
	self
		allChildrenBreadthFirstDo: [ :aSnippet | aSnippet canMoveToAnotherDatabase ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'api - testing' }
LePage >> canMoveToDatabase: aNewDatabase [
	(aNewDatabase hasPageNamed: self title) ifTrue: [ ^ false ].
	(aNewDatabase hasPageUID: self uid) ifTrue: [ ^ false ].
	
	self allChildrenBreadthFirstDo: [ :aSnippet | 
		(aNewDatabase hasBlockUID: aSnippet uid) 
			ifTrue: [ ^ false ] ].
	
	^ true
]

{ #category : #'api - updating' }
LePage >> clearStorageHash [
	self clearOption: #storageHash ifAbsent: [ "ignore" ]
]

{ #category : #'api - commands' }
LePage >> commandBuilder [
	^ LePageCommandBuilder forContent: self
]

{ #category : #'api - accessing' }
LePage >> contentAsString [
	^ self title
]

{ #category : #accessing }
LePage >> databaseKey [
	"Answer the value used to index a page of the receiver's type in the database."

	^ type databaseKey
]

{ #category : #history }
LePage >> editHistory [
	^ editHistory
]

{ #category : #'api - accessing' }
LePage >> editOrCreateTime [
	<return: #LeTime>
	
	self
		deprecated: 'Use #latestEditTime instead'
		transformWith: '`@receiver editOrCreateTime' -> '`@receiver latestEditTime'.

	^ self latestEditTime
]

{ #category : #'api - editing' }
LePage >> ensureOneSnippet [
	"Ensure the receiver has at least one LeSnippet child.
	Typically used so the user has somewhere to start inserting text."
	
	self hasChildren ifTrue: [ ^self ].
	self snippetBuilder empty; add.
]

{ #category : #accessing }
LePage >> explicitReferences [
	"This is meant to mimic the result of the 'explicit references' button at the bottom of each page with incoming references."

	^ (self database pages
		select: [ :page | 
			page allOutgoingExplicitLinks items
				detect: [ :link | link isTextualLink and: [ link targetPageTitle = self title ] ]
				ifFound: [ true ]
				ifNone: [ false ] ]) sort: [ :a :b | a title < b title ]
]

{ #category : #accessing }
LePage >> gtBindingsActionFor: anAction [
	<lePageAction>
	^ anAction dropdown
		tooltip: 'Inspect variable bindings';
		icon: BrGlamorousVectorIcons inspect;
		withDropdownIndicator;
		content: [ :aButton | 
			(aButton parent parent parent parent pageViewModel sharedSnippetContext
				gtViewSharedBindingsFor: GtPhlowView empty) asElement
				size: 300 @ 100;
				aptitude: BrGlamorousWithVerticalResizerAptitude
						+ BrGlamorousWithHorizontalResizerAptitude ]
]

{ #category : #accessing }
LePage >> gtCopyActionFor: anAction [
	<lePageAction>

	^ anAction button 
		tooltip: 'Copy as Remote Reference to the clipboard';
		icon: BrGlamorousVectorIcons clipboard;
		action: [ :aButton | Clipboard clipboardText: self asRemoteLink ]
]

{ #category : #search }
LePage >> gtSpotterForSnippetsFor: aSearch [
	"NB: We only search in text and code snippets."

	<gtSearch>
	^ aSearch list
		priority: 10;
		items: [  "self allChildrenTextSnippets ."self
				allChildrenSnippetsMatching: [ :aSnippet | aSnippet isTextSnippet or: [ aSnippet isCodeSnippet ] ] ];
		title: 'Text & Code Snippets';
		itemsLimit: Float infinity;
		itemName: #text;
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #testing }
LePage >> hasContent [
	"Page itself has no other content, only snippets. 
	See {{gtMethod:LeContent>>#hasContent}} for more details."

	^ false
]

{ #category : #'api - unlinked' }
LePage >> hasIncomingUnlinked [
	"Answer a boolean indicating whether the receiver has incoming unlinked references"

	^ self
		optionAt: self incomingUnlinkedOptionName  
		ifPresent: [ :links | links isNotEmpty ] 
		ifAbsent: [ false ]
]

{ #category : #testing }
LePage >> hasTagNamed: aString [
	^ (self tags collect: #title) includes: aString
]

{ #category : #'api - testing' }
LePage >> hasTitle [
	^ self type isUnnamedPageType not
		and: [ self title isNotNil and: [ self title isNotEmpty ] ]
]

{ #category : #'api - testing' }
LePage >> includesSnippetUid: aLeUID [
	"Answer a boolean indicating whether the supplied uid is present"

	^ self children includesSnippetUid: aLeUID
]

{ #category : #'api - unlinked' }
LePage >> incomingUnlinked [
	"Answer the collection of links that reference the receiver in plain text.
	Most pages won't have incoming unlinked references, so answer an array.
	An OrderedCollection will be added by LeUnlinkedReferenceMaintenace if necessary."

	^ self optionAt: self incomingUnlinkedOptionName ifAbsent: [ #() ]
]

{ #category : #'private - accessing' }
LePage >> incomingUnlinkedOptionName [
	^ #incomingUnlinkedReferences
]

{ #category : #initialization }
LePage >> initialize [ 
	super initialize.
	
	type := LeNamedPageType title: '' page: self.
	self assignNewUID.
	
	editHistory := LePageEditHistory forPage: self.
	
	self weak
		when: LeSnippetContentChanged, LePageTitleChanged, LeContentTreeChanged
		send: #clearStorageHash
		to: self
]

{ #category : #initialization }
LePage >> initializePharoClassName: aSymbol [

	type := LePharoClassPageType pageClassName: aSymbol page: self
]

{ #category : #initialization }
LePage >> initializePharoCommentClassName: aSymbol [

	type := LePharoClassCommentPageType pharoClassName: aSymbol page: self
]

{ #category : #initialization }
LePage >> initializeTitle: aTitleString [

	type := LeNamedPageType title: aTitleString page: self
]

{ #category : #initialization }
LePage >> initializeUnnamedPage [

	type := LeUnnamedPageType page: self
]

{ #category : #'api - testing' }
LePage >> isDailyNote [
	^ self type isDailyNote
]

{ #category : #'api - testing' }
LePage >> isNamedPage [
	^ self type isNamedPageType
]

{ #category : #'api - testing' }
LePage >> isPage [
	^ true
]

{ #category : #'api - testing' }
LePage >> isTableOfContents [
	^ self database tableOfContents == self
]

{ #category : #accessing }
LePage >> isTag [
	^ self title substrings size = 1
]

{ #category : #'api - testing' }
LePage >> isTodayDailyNote [
	^ self type isTodayDailyNote
]

{ #category : #'api - testing' }
LePage >> isUnnamedPage [
	^ self type isUnnamedPageType
]

{ #category : #'api - accessing' }
LePage >> latestEditTime [
	"Answer the most recent time the page or one of its blocks was changed in some way"

	^ latestEditTime ifNil: [ latestEditTime := self getLatestEditTime ]
]

{ #category : #accessing }
LePage >> leSnippetsInPage [
	^ LeSearchPageSnippetFilter forPage: self
]

{ #category : #accessing }
LePage >> linkedPages [
	"Return just the array of pages that this page links to."
	^ (self allOutgoingExplicitLinks items
		select: [ :l | l isTextualLink and: [ l isExistingPage ] ])
		collect: [ :l | l targetReference content ]
]

{ #category : #'private - exporting' }
LePage >> markdownOn: stream [
	"Write the receiver as an HTML string on the supplied stream"

	self hasTitle ifTrue:
		[ stream 
			<< '#';
			<< self title;
			cr; cr ].

	self childrenDo: [ :child |
		child markdownOn: stream level: 0.
		stream cr ].

]

{ #category : #'api - editing' }
LePage >> moveDownSnippet: aLeSnippet [
	"Try to move the supplied snippet down one item in the receiver's children.
	If that isn't possible, do nothing"

	^ (self children moveDownSnippet: aLeSnippet) 
		ifTrue: [ 
			self announceContentMovedDownFor: aLeSnippet.
			true ]
		ifFalse: [ false ]
]

{ #category : #'api - editing' }
LePage >> moveToDatabase: aNewDatabase [
	self assert: [ aNewDatabase notNil ].
	self database = aNewDatabase ifTrue: [ 
		Error signal: 'Can only be moved to a different database.' ].
	self allChildrenBreadthFirstDo: [ :aSnippet |
		self assert: (aNewDatabase hasBlockUID: aSnippet uid) not ].

	
	self database movePage: self toDatabase: aNewDatabase.
]

{ #category : #'api - editing' }
LePage >> moveUpSnippet: aLeSnippet [
	"Try to move the supplied snippet up one item in the receiver's children.
	If that isn't possible, do nothing"

	^ (self children moveUpSnippet: aLeSnippet) ifTrue: [ 
		self announceContentMovedUpFor: aLeSnippet.
		true ]
]

{ #category : #'api - notifications' }
LePage >> notifier [
	^ LeNotifier new
		content: self
]

{ #category : #'private - hooks' }
LePage >> onAddedToDatabase [
	super onAddedToDatabase.
	self database updateUnresolvedReferencesForPage: self.
]

{ #category : #'private - hooks' }
LePage >> onRemovedFromDatabase: aDatabase [
	super onRemovedFromDatabase: aDatabase.
	
	aDatabase removeExplicitOutgoingLinksForContent: self.
	aDatabase removeIncomingExplicitLinksForContent: self.
]

{ #category : #'api - accessing' }
LePage >> page [
	^ self
]

{ #category : #accessing }
LePage >> pageTypeClass [
	"Answer the class used to store the pages in ${class:name=LeDatabase}$."

	^ type pageTypeClass
]

{ #category : #printing }
LePage >> printOn: aStream [

	type ifNil: [ ^ super printOn: aStream ].
	type printOn: aStream.
]

{ #category : #'api - accessing' }
LePage >> printPageTabLabel [
	"Return a short title that fits nicely in ${class:LeWorldElement}$'s tab label"
	<return: #String>
	| aTitle |

	aTitle := self title.

	^ aTitle size < 21
		ifTrue: [ aTitle ]
		ifFalse: [ (aTitle first: (aTitle size min: 21)), '...' ]
]

{ #category : #'private - updating' }
LePage >> reloadAttributesFromContent: aLeContent [
	^ self reloadCommonMetadataFromContent: aLeContent.
]

{ #category : #'private - updating' }
LePage >> reloadFromPage: aLePage [
	"Update the receiver to match the supplied page"
	| changed |
	self deprecated: 'Use #newReloadFromPage:'.
	
	changed := self reloadFromContent: aLePage.
	latestEditTime := nil.
	
	type = aLePage type ifFalse: [
		type := aLePage type.
		changed := true ].

	changed ifTrue: [ self announceTreeChanged: self ]
]

{ #category : #'api - unlinked' }
LePage >> removeAllIncomingUnlinkedSuchThat: aBlock [
	"Remove all the incoming unlinked references that match aBlock"

	self hasIncomingUnlinked ifFalse: [ ^ self ].
	self incomingUnlinked removeAllSuchThat: aBlock.
]

{ #category : #'api - editing' }
LePage >> removeSelf [
	"Remove the page from a database"
	
	self database removePage: self
]

{ #category : #'api - editing' }
LePage >> removeSelfIfEmpty [
	"Remove the receiver if it is empty"

	self isEmpty ifTrue: [ self removeSelf ]
]

{ #category : #'api - editing' }
LePage >> renameTo: aString [
	self updateTitle: aString
]

{ #category : #accessing }
LePage >> shouldAppearInIndexOrDailyNotes [
	^ self type shouldAppearInIndexOrDailyNotes
]

{ #category : #'api - updating' }
LePage >> storageHash [
	^ self optionAt: #storageHash ifAbsent: [ nil ]
]

{ #category : #'api - updating' }
LePage >> storageHash: aLeBinaryContentsHash [
	^ self optionAt: #storageHash put: aLeBinaryContentsHash
]

{ #category : #printing }
LePage >> storeOn: aStream [
	"If type can be nil, then we need to adapt the logic below."
	self assert: self type notNil.
	aStream nextPut: $(.
	self type isUnnamedPageType
		ifTrue: [ aStream
				nextPutAll: self className;
				nextPutAll: ' unnamedPage ' ]
		ifFalse: [ aStream
				nextPut: $(;
				nextPutAll: self className;
				nextPutAll: ' named: ';
				print: self title;
				nextPut: $) ].
	self
		childrenDo: [ :snippet | 
			aStream nextPutAll: 'addSnippet: '.
			snippet storeOn: aStream.
			aStream nextPutAll: '; ' ].
	aStream
		nextPutAll: ' yourself';
		nextPut: $)
]

{ #category : #accessing }
LePage >> tags [
	"Outgoing links to pages with single-word titles, i.e., pages that could be interpreted as tags."

	^ self allOutgoingTargets select: [ :page | page isTag ]
]

{ #category : #'api - accessing' }
LePage >> title [
	"Answer the page's title"
	<return: #String>

	^ type title
]

{ #category : #'api - accessing' }
LePage >> title: aString [
	"Set the receiver's title.
	As the title can currently change the page type, also update the type.
	To update title, use ${method:LePage>>#updateTitle:}$."

	^ type := type title: aString.
]

{ #category : #'private - accessing' }
LePage >> type [
	<return: #LePageType>
	^ type
]

{ #category : #'private - accessing' }
LePage >> type: aType [
	type := aType
]

{ #category : #'api - accessing' }
LePage >> uid [
	<return: #UUID>

	^ uid
]

{ #category : #'api - accessing' }
LePage >> uidString [
	<return: #String>

	^ uid asString36
]

{ #category : #'api - editing' }
LePage >> unindentSnippet: aLeSnippet [
	"Pages can't unindent a snippet, there's no where to go.  Do nothing."

]

{ #category : #'api - updating' }
LePage >> unlinkedBy: aLink [
	"Remove the incoming link aLink.
	If the receiver is empty and there are no incoming links, remove the receiver."

	super unlinkedBy: aLink.
	(self incomingLinks isEmpty and: [ self isEmpty ]) ifTrue: 
		[ self database removePage: self ].
]

{ #category : #installing }
LePage >> unload [ 

	self allChildrenDepthFirstDo: [ :child | child unload ].
	self notifier
		bubble; database;
		announce: (LePageUnloadAnnouncement new content: self).
]

{ #category : #'api - editing' }
LePage >> updateTitle: aTitle [
	"Update a page title if allowed.
	Notice that it is allowed only if a page of the same title does not exist in a database."
	| aString anOldTitle anOldType oldDatabaseKey |
	aString := aTitle asString.
	self title = aString ifTrue: [ ^ self ].
	anOldTitle := self title.
	anOldType := self type.
	oldDatabaseKey := anOldType databaseKey.
	self updater 
		title: aString; 
		callback: [
			self notifier local; database; announce: (LePageTitleChanged new
				page: self;
				oldTitle: anOldTitle;
				newTitle: self title;
				oldType: anOldType;
				newType: self type;
				oldDatabaseKey: oldDatabaseKey;
				newDatabaseKey: self type databaseKey 
			) ];
		update.
]

{ #category : #'api - editing' }
LePage >> updater [
	^ LeDatabasePageUpdater new
		page: self;
		database: self database.
]

{ #category : #accessing }
LePage >> wordCount [
	"Inspired by:  Optimizing the links in the book for first time readers"

	^ self allChildrenBreadthFirst
		sumNumbers: [ :each | each contentAsString substrings size ]
]
