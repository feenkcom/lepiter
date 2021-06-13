Class {
	#name : #LePageViewModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TLeWithPageModel',
	#classTraits : 'TGtAnnouncer classTrait + TLeWithPageModel classTrait',
	#instVars : [
		'announcer',
		'databaseViewModel',
		'snippetBindings',
		'shouldFocusFirstSnippet'
	],
	#category : #'Lepiter-UI-Page-! View Models'
}

{ #category : #announcer }
LePageViewModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
LePageViewModel >> clearDatabaseViewModel [
	databaseViewModel := nil
]

{ #category : #accessing }
LePageViewModel >> content [
	<return: #LePage>

	self
		deprecated: 'Use #pageModel instead.'
		transformWith: '`@receiver content' -> '`@receiver pageModel'.

	^ self pageModel
]

{ #category : #accessing }
LePageViewModel >> content: aLePage [
	self
		deprecated: 'Use #pageModel: instead.'
		transformWith: '`@receiver content: `@arg' -> '`@receiver pageModel: `@arg'.

	self pageModel: aLePage
]

{ #category : #accessing }
LePageViewModel >> database [
	^ self databaseViewModel database
]

{ #category : #accessing }
LePageViewModel >> databaseViewModel [
	^ databaseViewModel
		ifNil: [ databaseViewModel := self pageModel database asContentUIModel
				registerPageViewModel: self ]
]

{ #category : #accessing }
LePageViewModel >> databaseViewModel: anObject [
	databaseViewModel := anObject
]

{ #category : #'api - page' }
LePageViewModel >> ensurePageHasAtLeastOneSnippet [
	self pageModel ensureOneBlock
]

{ #category : #initialization }
LePageViewModel >> initialize [
	super initialize.
	
	snippetBindings := GtSnippetBindings new.
	shouldFocusFirstSnippet := false
]

{ #category : #'api - page' }
LePageViewModel >> isPageTableOfContents [
	"Return true if the page plays a role of the table of contents, false otherwise"
	<return: #Boolean>

	^ self pageModel isTableOfContents
]

{ #category : #'private - notifying' }
LePageViewModel >> notifyPageReplaced [
	self announce: (LePageViewModelPageReplaced new pageViewModel: self)
]

{ #category : #'private - notifying' }
LePageViewModel >> notifyPageSnippetsChanged [
	self announce: (LePageViewModelSnippetsChanged new pageViewModel: self)
]

{ #category : #'private - notifying' }
LePageViewModel >> notifyPageTitleChanged [
	self announce: (LePageViewModelTitleChanged new pageViewModel: self)
]

{ #category : #'api - page model' }
LePageViewModel >> onPageModelChanged [
	"Is sent when a new page model is assigned to the view model"
	
	self notifyPageReplaced.
	self notifyPageTitleChanged
]

{ #category : #'private - event handling' }
LePageViewModel >> onPageMoved: aPageDatabaseMovedAnnouncement [
	self clearDatabaseViewModel.
	
	self announce: (LePageViewModelDatabaseChanged new pageViewModel: self)
]

{ #category : #'private - event handling' }
LePageViewModel >> onPageRemoved: aPageRemovedAnnouncement [
	| aRemovedPage anOriginalDatabase anotherPage |

	aRemovedPage := aPageRemovedAnnouncement page.
	self pageModel = aRemovedPage
		ifFalse: [ ^ self ].
	
	anOriginalDatabase := aPageRemovedAnnouncement database.
	
	"I display another page or create a new one, if there is no other page to display."
	anotherPage := anOriginalDatabase hasChildren 
		ifTrue: [ anOriginalDatabase anyOne ]
		ifFalse: [ (anOriginalDatabase pageBuilder uniqueTitle; add) ].

	self pageModel: anotherPage
]

{ #category : #'private - event handling' }
LePageViewModel >> onPageTitleChanged: aTitleChangedAnnouncement [
	self announce: (LePageViewModelTitleChanged new pageViewModel: self)
]

{ #category : #'private - event handling' }
LePageViewModel >> onSnippetAdded: anAnnouncement [
	"Is sent after a new #snippet is added to the #parent snippet at an #index.
	Can be sent from a non-UI thread"
	
	self notifyPageSnippetsChanged
]

{ #category : #'private - event handling' }
LePageViewModel >> onSnippetMoved: anAnnouncement [
	"Is sent after a snippet is moved within its parent or from one parent to another.
	Can be sent from a non-UI thread"
	
	self notifyPageSnippetsChanged
]

{ #category : #'private - event handling' }
LePageViewModel >> onSnippetRemoved: anAnnouncement [
	"Is sent after a snippet is removed.
	Can be sent from a non-UI thread"
	
	self notifyPageSnippetsChanged
]

{ #category : #accessing }
LePageViewModel >> page [
	<return: #LePage>

	self
		deprecated: 'Use #pageModel instead.'
		transformWith: '`@receiver page' -> '`@receiver pageModel'.

	^ self pageModel
]

{ #category : #accessing }
LePageViewModel >> page: aLePage [
	self
		deprecated: 'Use #pageModel: instead.'
		transformWith: '`@receiver page: `@arg' -> '`@receiver pageModel: `@arg'.

	self pageModel: aLePage
]

{ #category : #'api - page' }
LePageViewModel >> pageEditOrCreateEmail [
	<return: #LeEmail>

	^ self pageModel editOrCreateEmail
]

{ #category : #'api - page' }
LePageViewModel >> pageLatestEditTime [
	<return: #LeTime>

	^ self pageModel latestEditTime
]

{ #category : #'api - page' }
LePageViewModel >> pageTitle [
	<return: #String>
	
	^ self pageModel title
]

{ #category : #'api - page' }
LePageViewModel >> pageTitle: aString [
	"Change the page's title to a given one"
	
	self pageModel updateTitle: aString
]

{ #category : #'api - page' }
LePageViewModel >> pageUid [
	^ self pageModel uid
]

{ #category : #'api - page' }
LePageViewModel >> printPageEditOrCreateEmail [
	"Return a string representation of the last user that edited or created a page.
	If there is no email set, return empty string"
	<return: #String>

	^ self pageEditOrCreateEmail
		ifNil: [ '' ]
		ifNotNil: [ :aLeEmail|  aLeEmail email ]
]

{ #category : #'api - page' }
LePageViewModel >> printPageLatestEditTime [
	"Return a string representation of the last edit time to be dispalyed in the UI.
	If there is no last edit time set, return empty string"
	<return: #String>

	^ self pageLatestEditTime 
		ifNil: [ '' ] 
		ifNotNil: [ :aLeTime | aLeTime asDate asString ]
]

{ #category : #'api - page' }
LePageViewModel >> printPageSummary [
	"Return a short textual representation of the content of the page"
	<return: #String>

	^ self printPageSummaryLimitedTo: 300
]

{ #category : #'api - page' }
LePageViewModel >> printPageSummaryLimitedTo: aNumber [
	"Return a short textual representation of the content of the page"
	<return: #String>
	^ String 
		streamContents: [ :aStream | 
			self pageModel
				allChildrenDepthFirstDo: [ :eachChild | 
					eachChild contentAsString asString
						do: [ :eachCharacter | 
							eachCharacter isLineSeparator
								ifTrue: [ aStream space ]
								ifFalse: [ aStream nextPut: eachCharacter ] ] ] ]
		limitedTo: aNumber
]

{ #category : #'api - page' }
LePageViewModel >> printPageTabLabel [
	"Return a short title that fits nicely in ${class:LeWorldElement}$'s tab label"
	<return: #String>
	| aTitle |

	aTitle := self pageTitle.

	^ aTitle size < 21
		ifTrue: [ aTitle ]
		ifFalse: [ (aTitle first: (aTitle size min: 21)), '...' ]
]

{ #category : #accessing }
LePageViewModel >> receiver: anObject [
	self snippetBindings receiver: anObject.
]

{ #category : #'api - page' }
LePageViewModel >> removePage [
	self pageModel removeSelf
]

{ #category : #accessing }
LePageViewModel >> shouldFocusFirstSnippet [
	^ shouldFocusFirstSnippet
]

{ #category : #accessing }
LePageViewModel >> shouldFocusFirstSnippet: aBoolean [
	shouldFocusFirstSnippet := aBoolean
]

{ #category : #accessing }
LePageViewModel >> snippetBindings [
	<return: #GtSnippetBindings>

	^ snippetBindings
]

{ #category : #'api - page model' }
LePageViewModel >> subscribeToPageModel [
	"Is sent after a new page model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPageModel if view model subscribes to them"
	
	self pageModel weak
		when: LePageTitleChanged send: #onPageTitleChanged: to: self;
		when: LeContentTreeAdded send: #onSnippetAdded: to: self;
		when: LeContentTreeRemoved send: #onSnippetRemoved: to: self;
		when: LeContentTreeMoved send: #onSnippetMoved: to: self;
		when: LePageRemovedFromDatabase send: #onPageRemoved: to: self;
		when: LePageUnloadAnnouncement send: #onPageRemoved: to: self;
		when: LePageDatabaseChanged send: #onPageMoved: to: self.
]

{ #category : #'api - page model' }
LePageViewModel >> unsubscribeFromPageModel [
	"Is sent before a new page model is assigned to the view model.
	View models that subscribe to page model are required to implement this methods"
	
	self pageModel unsubscribe: self.
]
