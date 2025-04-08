Extension { #name : #LeDatabase }

{ #category : #'*Lepiter-ToC' }
LeDatabase >> gtViewCommentPagesFor: aView [
	<gtView>
	self hasCommentPages ifFalse: [ ^ aView empty ].
	^ aView tree
		title: 'Comment pages';
		priority: 52;
		items: [ self commentPages ];
		children: #children
]

{ #category : #'*Lepiter-ToC' }
LeDatabase >> gtViewTableOfContentsNodesFor: aView [
	<gtView>
	^ aView tree
		title: 'Table of content nodes';
		priority: 50;
		items: [ self tableOfContentsNodes  ];
		children: #children
]

{ #category : #'*Lepiter-ToC' }
LeDatabase >> notifyTableOfContensPageIdChangedFrom: anOldUUID to: aNewUUID [

	| anOldPage |
	anOldPage := anOldUUID ifNotNil: [
		self pageWithID: anOldUUID ifAbsent: [ nil ] ].

	self announce: (LeDatabaseTableOfContentsUUIDChanged new
		database: self;
		oldId: anOldUUID;
		oldPage: anOldPage;
		newId: aNewUUID;
		newPage: self tableOfContents)
]

{ #category : #'*Lepiter-ToC' }
LeDatabase >> tableOfContents [ 
	<return: #LePage or: nil>
	^ self tableOfContentsPageID
		ifNotNil: [ :pageID | 
			self 
				pageWithID: pageID
				ifAbsent: [ nil ] ]
]

{ #category : #'*Lepiter-ToC' }
LeDatabase >> tableOfContentsPageID [
	"Answer the page UUID for the Table Of Contents, or nil if not set"

	^ monitor ifNotNil: [ :aMonitor | aMonitor tableOfContentsPageID ] 
]

{ #category : #'*Lepiter-ToC' }
LeDatabase >> tableOfContentsPageID: aNewUUID [
	"Set the page UUID for the Table Of Contents.  nil to clear the ToC"

	| anOldUUID |
	anOldUUID := self tableOfContentsPageID.

	(anOldUUID = aNewUUID) ifTrue: [ ^ self ].

	monitor tableOfContentsPageID: aNewUUID.
	
	self notifyTableOfContensPageIdChangedFrom: anOldUUID to: aNewUUID.
	
]
