Class {
	#name : #LeDatabaseSidebarGroupedListElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'listElement',
		'navigationModel',
		'groupedItems',
		'selectionUpdater'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> database [
	^ self navigationModel database
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> databaseViewModel [
	^ self navigationModel databaseViewModel
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> groupedItems [
	^ groupedItems
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> groupedItems: anObject [
	groupedItems := anObject.
	self updateListItems
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> hasSelection [
	^ navigationModel notNil and: [ navigationModel hasPage ]
]

{ #category : #initialization }
LeDatabaseSidebarGroupedListElement >> initialize [
	super initialize.

	groupedItems := {}.

	self initializeSelectionUpdater.
	self initializeListElement.
	self layout: BlLinearLayout vertical.

	self addChild: listElement as: #list.
	self addAptitude: (BrLayoutResizerAptitude new inherit: listElement)
]

{ #category : #initialization }
LeDatabaseSidebarGroupedListElement >> initializeListElement [
	listElement := BrGroupedList new
			margin: (BlInsets top: 5);
			when: BrSelectionChanged
				do: [ :anEvent | self onTreeSelectionChanged: anEvent ];
			when: BrItemsProviderItemsChangedEvent 
				do: [ :anEvent | self onItemsProviderItemsChanged: anEvent ];
			headerElementStencil: [ BrLabel new
					beSmallSize;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
					hMatchParent;
					vFitContent;
					margin: (BlInsets top: 10 left: 5) ];
			headerDataBinder: [ :aLabelElement :aGroup | aLabelElement text: aGroup domainObject asString ];
			matchParent
]

{ #category : #initialization }
LeDatabaseSidebarGroupedListElement >> initializeSelectionUpdater [
	selectionUpdater := BrElementUpdater new
			element: self
			selector: #updateSelection;
			postponedDuration: 300 milliSeconds.
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> items [
	self groupedItems ifNil: [ ^ {} asAsyncStream ].

	^ (self groupedItems
		collect: [ :aPair | 
			BrGroup new
				stream: aPair value asAsyncStream;
				domainObject: aPair key;
				itemStencil: [ :aNodeType | 
					LePageTitleAndSummaryElement new
						hMatchParent;
						vFitContent;
						addAptitude: BrGlamorousListItemAptitude;
						margin: (BlInsets left: 5) ];
				itemDataBinder: [ :anItemElement :aPage | anItemElement contentViewModel: aPage asContentUIModel ] ])
		asAsyncStream
]

{ #category : #'api - navigation model' }
LeDatabaseSidebarGroupedListElement >> navigationModel [
	^ navigationModel
]

{ #category : #'api - navigation model' }
LeDatabaseSidebarGroupedListElement >> navigationModel: anObject [
	navigationModel == anObject ifTrue: [ ^ self ].
	navigationModel ifNotNil: [ navigationModel unsubscribe: self ].
	navigationModel := anObject.
	navigationModel weak 
		when: LeUIDatabaseNavigationModelChanged send: #onNavigationModelChanged: to: self;
		when: LeUIPageSelected send: #onNavigationModelPageSelected: to: self
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> notifyListSelectionChangedTo: aPage [
	| aPageUIModel |
	aPageUIModel := aPage asContentUIModel.
	
	self selection = aPageUIModel ifTrue: [ ^ self ].
	(self selection notNil and: [ self selection pageModel = aPage ])
		ifTrue: [ ^ self ].

	self navigationModel
		announce: (LeUIPageSelectionRequest new page: aPageUIModel)
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	"selectionUpdater ifNotNil: #requestUpdate."
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateListItems.
]

{ #category : #'event handling' }
LeDatabaseSidebarGroupedListElement >> onItemsProviderItemsChanged: anEvent [
	self requestSelectionUpdate
]

{ #category : #'event handling' }
LeDatabaseSidebarGroupedListElement >> onNavigationModelChanged [
	self updateListItems.
]

{ #category : #'event handling' }
LeDatabaseSidebarGroupedListElement >> onNavigationModelChanged: anAnnouncement [
	BlTaskAction enqueueElement: self action: [ self onNavigationModelChanged ]
]

{ #category : #'event handling' }
LeDatabaseSidebarGroupedListElement >> onNavigationModelPageSelected: anAnnouncement [
	self requestSelectionUpdate
]

{ #category : #'event handling' }
LeDatabaseSidebarGroupedListElement >> onSelectionChanged [
	self requestSelectionUpdate
]

{ #category : #'event handling' }
LeDatabaseSidebarGroupedListElement >> onTreeSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged
		selectedDo: [ :anInterval | 
			listElement
				selectedEntityDo: [ :aNode | aNode isHeader ifFalse: [ self notifyListSelectionChangedTo: aNode itemObject ] ] ]
]

{ #category : #'event handling' }
LeDatabaseSidebarGroupedListElement >> requestSelectionUpdate [
	groupedItems ifNil: [ ^ self ].
	groupedItems ifEmpty: [ ^ self ].
	navigationModel ifNil: [ ^ self ].

	LeDatabaseSidebarGroupedListRequestUpdateSelectionSignal new
		navigationModel: navigationModel;
		groupedItems: groupedItems;
		emit.

	selectionUpdater ifNotNil: #requestUpdate
]

{ #category : #'api - navigation model' }
LeDatabaseSidebarGroupedListElement >> selection [
	^ navigationModel page
]

{ #category : #'api - navigation model' }
LeDatabaseSidebarGroupedListElement >> selection: aViewModel [
	"Set selected page"

	navigationModel announce: (LeUIPageSelectionRequest new page: aViewModel)
]

{ #category : #'private - updating' }
LeDatabaseSidebarGroupedListElement >> updateListItems [
	groupedItems ifNil: [ ^ self ].
	navigationModel ifNil: [ ^ self ].
	listElement stream: self items
]

{ #category : #'private - updating' }
LeDatabaseSidebarGroupedListElement >> updateSelection [
	| aPage aPageDate aNavigationModel |
	self hasSelection ifFalse: [ ^ self ].
	self selection class = LeContentViewModel ifTrue: [ ^ self ].

	aPage := self selection pageModel.
	aPageDate := aPage createTime ifNotNil: #asDate.
	aNavigationModel := navigationModel.
	LeDatabaseSidebarGroupedListUpdateSelectionSignal new
		page: aPage;
		groupDomainObject: aPageDate;
		navigationModel: aNavigationModel;
		groupedItems: groupedItems;
		emit.

	1
		to: listElement viewModel entityCount
		do: [ :anIndex | 
			(listElement viewModel entityAt: anIndex)
				ifNotNil: [ :eachEntity | 
					(eachEntity isItem and: [ eachEntity object == aPage ])
						ifTrue: [ 
							listElement scrollToIndex: anIndex.
							listElement selectOne: anIndex.
							LeDatabaseSidebarGroupedListScrolledToIndexSignal new
								page: aPage;
								groupDomainObject: aPageDate;
								navigationModel: aNavigationModel;
								groupedItems: groupedItems;
								pageIndex: anIndex.
							^ self ] ] ].
]
