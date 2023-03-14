"
I display a {{gtClass:LePage}} list of a {{gtClass:LeDatabase}}.

I can display all pages and daily notes:

{{gtExample:LePageListByScripterExamples>>#databasePageListElement_Pages|previewExpanded}}

I can also display any subset of pages, e.g., just daily notes:
{{gtExample:LePageListByScripterExamples>>#databasePageListElement_DailyNotes|previewExpanded}}

"
Class {
	#name : #LeDatabasePageListElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'filter',
		'listElement',
		'selection',
		'navigationModel'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #defaults }
LeDatabasePageListElement >> defaultFilter [
	^ [ :aDatabase | aDatabase pagesByDateToShow ]
]

{ #category : #defaults }
LeDatabasePageListElement >> defaultSelection [
	^ LePage null asContentUIModel
]

{ #category : #'private - accessing' }
LeDatabasePageListElement >> filter [
	"Return a block that receives ${class:LeDatabase}$ and returns pages to display"

	^ filter
]

{ #category : #'api - accessing' }
LeDatabasePageListElement >> filter: aBlock [
	"Set a block that receives ${class:LeDatabase}$ and returns pages to display"
	filter := aBlock.
	self onFilterChanged.
]

{ #category : #initialization }
LeDatabasePageListElement >> initialize [
	super initialize.

	filter := self defaultFilter.
	selection := self defaultSelection.

	self layout: BlLinearLayout vertical.
	
	self initializeListElement.

	self addChild: self listElement as: #list.
	self addAptitude: (BrLayoutResizerAptitude inherit 
		inherit: self listElement).
]

{ #category : #initialization }
LeDatabasePageListElement >> initializeListElement [
	listElement := BrSimpleList new
		margin: (BlInsets top: 5);
		itemStencil: [ :anItemType |
			LePageTitleAndSummaryElement new
				hMatchParent;
				vFitContent;
				padding: (BlInsets top: 3 left: 12 bottom: 3 right: 12);
				addAptitude: BrGlamorousListItemAptitude ];
		itemDataBinder: [ :anItemElement :eachPageViewModel | anItemElement pageViewModel: eachPageViewModel ];
		when: BrSelectionChanged
		do: [ :anEvent | self onListSelectionChanged: anEvent ];
		matchParent.
]

{ #category : #'private - accessing' }
LeDatabasePageListElement >> items [
	"Return pages to display"

	^ self filter cull: self database
]

{ #category : #'private - accessing' }
LeDatabasePageListElement >> listElement [
	^ listElement
]

{ #category : #accessing }
LeDatabasePageListElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabasePageListElement >> navigationModel: anObject [
	navigationModel := anObject.
	navigationModel
		when: LeUIPageSelected
		send: #onSelectionChanged
		to: self
]

{ #category : #'private - notifying' }
LeDatabasePageListElement >> notifyListSelectionChangedTo: aPageUIModel [
	self selection = aPageUIModel
		ifTrue: [ ^ self ].
	
	aPageUIModel shouldFocusFirstSnippet: true.
	
	self fireEvent: (LeDatabaseSidebarChangePageWish new pageUIModel: aPageUIModel)
]

{ #category : #'hooks - children' }
LeDatabasePageListElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.

	self updateSelection.
]

{ #category : #'api - ui model' }
LeDatabasePageListElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateListItems
]

{ #category : #'private - hooks' }
LeDatabasePageListElement >> onFilterChanged [
	self updateListItems.
]

{ #category : #'private - event handling' }
LeDatabasePageListElement >> onListSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged selectedDo: [ :anInterval | 
		anInterval do: [ :anIndex | 
			(anIndex isNotNil and: [ anIndex > 0 and: [ anIndex <= self listElement maxSelectionIndex ]])
				ifTrue: [ 
					| aPage |
					aPage := self listElement items at: anIndex ifAbsent: [ ^ self ].
					self notifyListSelectionChangedTo: aPage.
					^ self ] ] ].
]

{ #category : #'private - event handling' }
LeDatabasePageListElement >> onPageAdded: aLeDatabasePageAdded [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateListItems ]).
]

{ #category : #'private - event handling' }
LeDatabasePageListElement >> onPageRemoved: aLeDatabasePageRemoved [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateListItems ]).
]

{ #category : #'private - hooks' }
LeDatabasePageListElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #'api - accessing' }
LeDatabasePageListElement >> selection [
	<return: #LePageViewModel>

	^ navigationModel page
]

{ #category : #'api - accessing' }
LeDatabasePageListElement >> selection: aLePageUIModel [
	"Set selected page"

	navigationModel announce: (LeUIPageSelectionRequest new page: aLePageUIModel)
]

{ #category : #'api - accessing' }
LeDatabasePageListElement >> showDailyNotes [
	self filter: [ :aDatabase | aDatabase dailyNotes  ]
]

{ #category : #'api - accessing' }
LeDatabasePageListElement >> showPagesAndDailyNotes [
	self filter: [ :aDatabase | aDatabase pagesByDateToShow ]
]

{ #category : #'private - subscriptions' }
LeDatabasePageListElement >> subscribeToContent [
	super subscribeToContent.

	self database weak
		when: LeDatabasePageAdded
		send: #onPageAdded:
		to: self;
		when: LeDatabasePageRemoved
		send: #onPageRemoved:
		to: self;
		when: LePageUnloadAnnouncement
		send: #onPageRemoved:
		to: self
]

{ #category : #'private - subscriptions' }
LeDatabasePageListElement >> unsubscribeFromContent [
	super unsubscribeFromContent.

	self database unsubscribe: self
]

{ #category : #'private - updating' }
LeDatabasePageListElement >> updateListItems [
	| theFilteredPages |
	
	self hasDatabase
		ifFalse: [ ^ self ].
	
	theFilteredPages := self items.
	self listElement items: (self databaseViewModel pageUIModelsFor: theFilteredPages).
	self updateSelection
]

{ #category : #'private - updating' }
LeDatabasePageListElement >> updateSelection [
	| anIndex |
	
	anIndex := self listElement items 
		indexOf: self selection 
		ifAbsent: [ self listElement deselectAll. ^ self ].

	(self listElement isSelectedAt: anIndex)
		ifTrue: [ ^ self ].

	self listElement selectOne: anIndex
]
