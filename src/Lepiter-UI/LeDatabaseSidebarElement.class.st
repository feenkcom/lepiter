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
		'selection',
		'tableOfContentsElement',
		'tableOfContentsTab',
		'navigationModel'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> beExact: aNumber [
	widthStrategy := BrResizerElementLength exact: aNumber
]

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> collapse [
	self width: self resizerElement width
]

{ #category : #defaults }
LeDatabaseSidebarElement >> defaultSelection [
	^ LePage null asContentUIModel
]

{ #category : #'private - visibility' }
LeDatabaseSidebarElement >> expand [
	widthStrategy adjustWidthFor: self.
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
	tabGroupElement := GtPhlowCompositeView new
			views: (GtPhlowViewsCollector new
					fromObject: navigationModel;
					pragmaName: #leDatabaseView;
					collect);
			asElementDo: [ :aTabGroup | aTabGroup padding: aTabGroup padding + (BlInsets right: 3) ]
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

{ #category : #'private - accessing' }
LeDatabaseSidebarElement >> tabGroupElement [
	^ tabGroupElement
]

{ #category : #'private - subscriptions' }
LeDatabaseSidebarElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	
	self database unsubscribe: self.
]

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> updateContent [
	self database = navigationModel database ifTrue: [ ^ self ].
	navigationModel database: self database.
	self updateTabGroupElement.
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

			anActionBar ]
]

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> updateSelection [
]

{ #category : #'private - updating' }
LeDatabaseSidebarElement >> updateTabGroupElement [
	self removeChildNamed: #content.
	tabGroupElement := nil.
	self initializeTabGroupElement.
	self addChild: self tabGroupElement as: #content
]
