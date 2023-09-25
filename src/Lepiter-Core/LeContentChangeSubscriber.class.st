Class {
	#name : #LeContentChangeSubscriber,
	#superclass : #Object,
	#category : #'Lepiter-Core-Announcements'
}

{ #category : #'instance creation' }
LeContentChangeSubscriber class >> forDefaultLogicalDatabase [
	^ self forLogicalDatabase: LeDatabasesRegistry defaultLogicalDatabase
]

{ #category : #'instance creation' }
LeContentChangeSubscriber class >> forLogicalDatabase: aLogicalDatabase [
	^ self new 
		initializeForLogicalDatabase: LeDatabasesRegistry defaultLogicalDatabase
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnDatabaseAddedAnnouncement: anAnnouncement [
	anAnnouncement database do: [ :aDatabase |
		aDatabase pagesDo: [ :aPage |
			self processPageAdditionFor: aPage ] ]
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnDatabaseUnloadedAnnouncement: anAnnouncement [
	anAnnouncement database do: [ :aDatabase |
		aDatabase pagesDo: [ :aPage |
			self processPageRemovalFor: aPage ] ]
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnPageAddedAnnouncement: anAnnouncement [
	self processPageAdditionFor: anAnnouncement page
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnPageRemovedAnnouncement: anAnnouncement [
	self processPageRemovalFor: anAnnouncement page
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnPageRenamedAnnouncement: anAnnouncement [
	self onPageRenamed: anAnnouncement page
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnSnippetAddedAnnouncement: anAnnouncement [
	anAnnouncement content 
		withAllChildrenBreadthFirstDo: [ :aSnippet |
			self onSnippetAdded: aSnippet ]
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnSnippetContentChangedAnnouncement: anAnnouncement [
	self onSnippetChanged: anAnnouncement snippet
]

{ #category : #callbacks }
LeContentChangeSubscriber >> actOnSnippetRemovedAnnouncement: anAnnouncement [
	anAnnouncement content 
		withAllChildrenBreadthFirstDo: [ :aSnippet |
			self onSnippetRemoved: aSnippet ]
]

{ #category : #initialization }
LeContentChangeSubscriber >> initializeForLogicalDatabase:  aLogicalDatabase [
	self subscribeForSnippetContentChangesWith: aLogicalDatabase.
	self subscribeForPageChangesWith: aLogicalDatabase.
	self subscribeForSnippetContentChangesWith: aLogicalDatabase.
]

{ #category : #'content changes' }
LeContentChangeSubscriber >> onPageAdded: aPage [
]

{ #category : #'content changes' }
LeContentChangeSubscriber >> onPageRemoved: aPage [
]

{ #category : #'content changes' }
LeContentChangeSubscriber >> onPageRenamed: aPage [
]

{ #category : #'content changes' }
LeContentChangeSubscriber >> onSnippetAdded: aSnippet [
]

{ #category : #'content changes' }
LeContentChangeSubscriber >> onSnippetChanged: aSnippet [
]

{ #category : #'content changes' }
LeContentChangeSubscriber >> onSnippetRemoved: aSnippet [
]

{ #category : #utils }
LeContentChangeSubscriber >> processPageAdditionFor: aPage [ 
	self onPageAdded: aPage .
	
	aPage
		withAllChildrenBreadthFirstDo: [ :aSnippet |
			self onSnippetAdded: aSnippet ]
]

{ #category : #utils }
LeContentChangeSubscriber >> processPageRemovalFor: aPage [ 
	self onPageRemoved: aPage .
	
	aPage
		withAllChildrenBreadthFirstDo: [ :aSnippet |
			self onSnippetRemoved: aSnippet ]
]

{ #category : #subscription }
LeContentChangeSubscriber >> subscribeForDatabaseChangesWith: aLogicalDatabase [
	aLogicalDatabase weak
		when: LeDatabasesAddedAnnouncement send: #actOnDatabaseAddedAnnouncement: to: self;
		when: LeDatabaseUnloadAnnouncement send: #actOnDatabaseUnloadedAnnouncement: to: self.
]

{ #category : #subscription }
LeContentChangeSubscriber >> subscribeForPageChangesWith: aContent [
	aContent weak
		when: LeDatabasePageAdded send: #actOnPageAddedAnnouncement: to: self;
		when: LeDatabasePageRemoved send: #actOnPageRemovedAnnouncement: to: self;
		when: LePageTitleChanged send: #actOnPageRenamedAnnouncement: to: self
]

{ #category : #subscription }
LeContentChangeSubscriber >> subscribeForSnippetContentChangesWith: aContent [
	aContent weak
		when: LeSnippetContentChanged send: #actOnSnippetContentChangedAnnouncement: to: self;
		when: LeContentTreeAdded send: #actOnSnippetAddedAnnouncement: to: self;
		when: LeContentTreeRemoved send: #actOnSnippetRemovedAnnouncement: to: self
]

{ #category : #accessing }
LeContentChangeSubscriber >> unsubscribeFrom: aContent [
	aContent unsubscribe: self
]
