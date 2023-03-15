"
I display a {{gtClass:LePage}} list of a {{gtClass:LeDatabase}}:

{{gtExample:LeUIExamples>>#databaseSidebarElement|previewExpanded}}


"
Class {
	#name : #LeDatabaseSidebarElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'resizerElement',
		'widthStrategy',
		'tabGroupElement',
		'pagesElement',
		'dailyNotesElement',
		'selection',
		'tableOfContentsElement',
		'tableOfContentsTab',
		'dailyNotesGroupElement',
		'navigationModel'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> addTableOfContentsTab [

	self tableOfContentsTab ifNil: [ 
		tableOfContentsElement := nil.
		tableOfContentsTab := BrTab new
			aptitude: BrGlamorousTabAptitude new;
			select;
			label: 'ToC';
			stencil: [ self tableOfContentsElement ] ].
	
	(tabGroupElement hasTab: self tableOfContentsTab) ifFalse: [ 	
		tabGroupElement addTab: self tableOfContentsTab at: 1 ].
]

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> beExact: aNumber [
	widthStrategy := BrResizerElementLength exact: aNumber
]

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> collapse [
	self width: self resizerElement width
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> dailyNotesElement [
	^ dailyNotesElement ifNil: [ dailyNotesElement := self newDailyNotesElement ].
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> dailyNotesElementDo: aBlock [
	dailyNotesElement ifNotNil: aBlock
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> dailyNotesGroupElement [
	^ dailyNotesGroupElement ifNil: [ 
		dailyNotesGroupElement := self newDailyNotesGroupElement ].
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> dailyNotesGroupElementDo: aBlock [
	dailyNotesGroupElement ifNotNil: aBlock
]

{ #category : #defaults }
LeDatabaseSidebarElement >> defaultSelection [
	^ LePage null asContentUIModel
]

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> expand [
	widthStrategy adjustWidthFor: self.
]

{ #category : #'private - testing' }
LeDatabaseSidebarElement >> hasTableOfContents [
	<return: #Boolean>
	^ self database tableOfContents isNotNil.
]

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> hide [
	self visibility: BlVisibility gone
]

{ #category : #initialization }
LeDatabaseSidebarElement >> initialize [
	super initialize.
	selection := self defaultSelection.
	widthStrategy := BrResizerElementLength weight: 0.5.
	self initializeNavigationModel.
	self initializeTabGroupElement.
	self initializeElement.

	self addChild: self tabGroupElement as: #content.
	self
		addAptitude: (BrGlamorousWithHorizontalResizerAptitude new 
		resizerDo: [ :theResizer | resizerElement := theResizer ]).

	self initializeListeners.
	self expand.
		
	self addAptitude: (GtPhlowToolDetailAptitude new
		normal: [ self onNormalVolume ];
		detailed: [ self onDetailedVolume ]).
	self addAptitude: (BrLayoutResizerAptitude new
		vInherit;
		vInherit: self tabGroupElement)
]

{ #category : #initialization }
LeDatabaseSidebarElement >> initializeElement [
	self
		layout: BlFrameLayout new;
		labeled: 'Sidebar';
		visibility: BlVisibility gone;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		background: BrGlamorousColors neutralBackgroundColor.
]

{ #category : #initialization }
LeDatabaseSidebarElement >> initializeListeners [
	self resizerElement
			when: BlResizerResizedEvent
				do: [ :anEvent | self onResizerResized: anEvent ];
			when: BlDoubleClickEvent
				do: [ :anEvent | self onResizerDoubleClick: anEvent ]
]

{ #category : #initialization }
LeDatabaseSidebarElement >> initializeNavigationModel [
	navigationModel := LeDatabaseNavigationModel new.
	navigationModel when: LeUIPageSelected send: #onPageSelection: to: self
]

{ #category : #initialization }
LeDatabaseSidebarElement >> initializeTabGroupElement [
	tabGroupElement := BrTabGroup new
			aptitude: BrGlamorousTabGroupAptitude;
			addTab: (BrTab new
					aptitude: BrGlamorousTabAptitude new;
					label: 'Pages';
					stencil: [ self pagesElement ]);
			addTab: (BrTab new
					aptitude: BrGlamorousTabAptitude new;
					label: 'By Day';
					stencil: [ self dailyNotesGroupElement ]).

	tabGroupElement padding: tabGroupElement padding + (BlInsets right: 3)
]

{ #category : #'private - testing' }
LeDatabaseSidebarElement >> isCollapsed [
	<return: #Boolean>
	^ self width <= self resizerElement width
]

{ #category : #accessing }
LeDatabaseSidebarElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarElement >> navigationModel: anObject [
	navigationModel := anObject
]

{ #category : #'private - instance creation' }
LeDatabaseSidebarElement >> newDailyNotesElement [
	| newDailyNotesElement |

	newDailyNotesElement := LeDatabaseSidebarListElement new navigationModel: self navigationModel.
	
	^ newDailyNotesElement
]

{ #category : #'private - instance creation' }
LeDatabaseSidebarElement >> newDailyNotesGroupElement [
	| newDailyNotesElement |
	newDailyNotesElement := LeDatabaseSidebarListElement new
			navigationModel: self navigationModel;
			selectionBlock: [ :aNavigationModel | 
				aNavigationModel database dailyNotesGroup
					collect: [ :aDailyNote | LeDailyNoteTreeNodeModel forDailyNote: aDailyNote ] ].

	^ newDailyNotesElement
]

{ #category : #'private - instance creation' }
LeDatabaseSidebarElement >> newPagesElement [
	| newPagesElement |
	newPagesElement := LeDatabaseSidebarListElement new
			navigationModel: self navigationModel;
			selectionBlock: [ :aNavigationModel | 
				aNavigationModel hasDatabase
					ifTrue: [ aNavigationModel database pagesByDateToShow
							collect: [ :aPage | LePageTreeNodeModel forPage: aPage ] ]
					ifFalse: [ {} ] ].

	^ newPagesElement
]

{ #category : #'private - instance creation' }
LeDatabaseSidebarElement >> newTableOfContentsElement [
	| newTableOfContentsElement |

	newTableOfContentsElement := LeDatabaseTableOfContentsTreeElement new
			navigationModel: self navigationModel.
	
	self hasDatabase
		ifTrue: [ newTableOfContentsElement databaseViewModel: self databaseViewModel ].

	^ newTableOfContentsElement
]

{ #category : #'private - hooks' }
LeDatabaseSidebarElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateContent.
]

{ #category : #'private - event handling' }
LeDatabaseSidebarElement >> onDetailedVolume [
	self show
]

{ #category : #'private - event handling' }
LeDatabaseSidebarElement >> onNormalVolume [
	self hide
]

{ #category : #initialization }
LeDatabaseSidebarElement >> onPageSelection: anAnnouncement [
	self
		fireEvent: (LeDatabaseSidebarChangePageWish new pageUIModel: anAnnouncement page)
]

{ #category : #'private - event handling' }
LeDatabaseSidebarElement >> onResizerDoubleClick: anEvent [
	anEvent consumed: true.
	self isCollapsed
		ifTrue: [ self expand ]
		ifFalse: [ self collapse ]
]

{ #category : #'private - event handling' }
LeDatabaseSidebarElement >> onResizerResized: anEvent [
	self beExact: anEvent extent x
]

{ #category : #'private - hooks' }
LeDatabaseSidebarElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #'private - announcement handling' }
LeDatabaseSidebarElement >> onTableOfContentsUUIDChanged: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [
		self updateTableOfContentTab ]).
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> pagesElement [
	^ pagesElement ifNil: [ pagesElement := self newPagesElement ]
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> pagesElementDo: aBlock [
	pagesElement ifNotNil: aBlock
]

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> removeTableOfContentsTab [
	self tableOfContentsTab ifNil: [ ^ self ].
	(tabGroupElement hasTab: self tableOfContentsTab)
		ifTrue: [ tabGroupElement removeTab: self tableOfContentsTab ].
	tableOfContentsElement := nil.
	tableOfContentsTab := nil.
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> resizerElement [
	^ resizerElement
]

{ #category : #'api - accessing' }
LeDatabaseSidebarElement >> selection [
	<return: #LePageViewModel>

	^ selection
]

{ #category : #'api - accessing' }
LeDatabaseSidebarElement >> selection: aLePageUIModel [
	"Set selected page"
	
	selection = aLePageUIModel
		ifTrue: [ ^ self ].
	selection := aLePageUIModel.
	self onSelectionChanged
]

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> show [
	self visibility: BlVisibility visible
]

{ #category : #'private - subscriptions' }
LeDatabaseSidebarElement >> subscribeToContent [
	super subscribeToContent.
	self database weak
		when: LeDatabaseTableOfContentsUUIDChanged
		send: #onTableOfContentsUUIDChanged:
		to: self.
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> tabGroupElement [
	^ tabGroupElement
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> tableOfContentsElement [
	^ tableOfContentsElement ifNil: [ tableOfContentsElement := self newTableOfContentsElement ].
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> tableOfContentsElementDo: aBlock [
	tableOfContentsElement ifNotNil: aBlock
]

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> tableOfContentsTab [
	<return: #BrTab>
	^ tableOfContentsTab
]

{ #category : #'private - subscriptions' }
LeDatabaseSidebarElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	
	self database unsubscribe: self.
]

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> updateContent [
	self updateTableOfContentTab.
	navigationModel database: self database.
	self tabGroupElement
		actionbarStencil: [ | anActionBar |
			anActionBar := BrToolbar new aptitude: BrGlamorousToolbarAptitude new.

			(GtPhlowActionsCollector new
				pragmaName: #leNavigationAction;
				fromObject: self navigationModel;
				collect)
				do: [ :each | 
					each
						asElement: [ :actionElement | anActionBar addItem: actionElement ]
						withHostElement: self ].

			anActionBar ].
	self
		tableOfContentsElementDo: [ :anElement | anElement databaseViewModel: self databaseViewModel ].
	self navigationModel databaseViewModel: self databaseViewModel
]

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> updateSelection [
	self tableOfContentsElementDo: [ :anElement | anElement selection: self selection ].
	self pagesElementDo: [ :anElement | anElement selection: self selection ].
	"self dailyNotesElementDo: [ :anElement | anElement selection: self selection ]."
	self dailyNotesGroupElementDo: [ :anElement | anElement selection: self selection ].
]

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> updateTableOfContentTab [
	self hasTableOfContents 
		ifFalse: [ self removeTableOfContentsTab ]
		ifTrue: [ self addTableOfContentsTab ].
]
