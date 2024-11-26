"
I display a {{gtClass:LePage}} complete tool:

{{gtExample:LeUIExamples>>#pageToolElement_Hierarchy_Normal|previewExpanded}}

When maximized, I display a sidebar:

{{gtExample:LeUIExamples>>#pageToolElement_Hierarchy_Maximized|previewExpanded}}


"
Class {
	#name : #LePageToolElement,
	#superclass : #BlElement,
	#traits : 'TGtPhlowToolDetailAdjustable + TLeWithPageViewModel + TBrLayoutResizable + TGtPagerPageInstantiator',
	#classTraits : 'TGtPhlowToolDetailAdjustable classTrait + TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait + TGtPagerPageInstantiator classTrait',
	#instVars : [
		'sidebarElement',
		'contentElement',
		'titleNotifier'
	],
	#category : #'Lepiter-UI-! Tool - Page'
}

{ #category : #'private - accessing' }
LePageToolElement >> contentElement [
	^ contentElement
]

{ #category : #'private - updating' }
LePageToolElement >> hideContentElementWithOriginalDatabase: aLeDatabase [
	"See https://github.com/feenkcom/gtoolkit/issues/4186"

	contentElement parent == self ifFalse: [ ^ self ].
	self
		replaceChild: contentElement
		with: (self newEmptyPageWithOriginalDatabase: aLeDatabase)
		as: #content
]

{ #category : #initialization }
LePageToolElement >> initialize [
	super initialize.
	self initializeSidebarElement.
	self initializeContentElement.
	self initializeTitleNotifier.
	self layout: BlLinearLayout horizontal.
	
	self addChild: self sidebarElement as: #sidebar.
	self addChild: self contentElement as: #content.
	
	self addAptitude: (GtPhlowToolDetailAptitude new
		normal: [ :aStyle | aStyle do: [ self onNormalVolume ] ];
		detailed: [ :aStyle | aStyle do: [ self onDetailedVolume ] ]).

	self beFocusable.
	self when: BlClickEvent do: [ :anEvent | self requestFocus ].
	self phlow 
		accessTool: (GtPhlowToolClassType forClass: LePage) 
		viewModel: #pageViewModel 
		object: #pageModel.
]

{ #category : #initialization }
LePageToolElement >> initializeContentElement [
	contentElement := LePageToolContentTreeElement new
		padding: (BlInsets top: 0 right: 10 bottom: 0 left: 10)
]

{ #category : #initialization }
LePageToolElement >> initializeSidebarElement [
	sidebarElement := LeDatabaseSidebarElement new
		when: LeDatabaseSidebarChangePageWish 
		do: [ :aWish | self onSidebarChangePageWish: aWish ]
]

{ #category : #initialization }
LePageToolElement >> initializeTitleNotifier [
	titleNotifier := (GtPhlowTitleIconAndLabelNotifier new
		longLabel: [ self pageViewModel pageTitle ];
		icon: LeIcons lepiterPage).
	self addEventHandler: titleNotifier.
]

{ #category : #'private - updating' }
LePageToolElement >> newEmptyPageWithOriginalDatabase: aLeDatabase [
	| aText |
	aText := aLeDatabase hasChildren
			ifTrue: [ 'No page selected' ]
			ifFalse: [ 'Empty knowledgebase' ].
	^ BrFrame new
		matchParent;
		addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new foreground: self theme button disabledTextColor);
				text: aText;
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ])
]

{ #category : #'private - event handling' }
LePageToolElement >> onDetailedVolume [
	self sidebarElement show
]

{ #category : #'private - event handling' }
LePageToolElement >> onNormalVolume [
	self sidebarElement hide
]

{ #category : #'private - event handling' }
LePageToolElement >> onPageDatabaseChanged [
	self sidebarElement
		databaseViewModel: self pageViewModel databaseViewModel;
		selection: self pageViewModel.
]

{ #category : #'api - page view model' }
LePageToolElement >> onPageModelReplaced [
	self sidebarElement
		databaseViewModel: self pageViewModel databaseViewModel;
		selection: self pageViewModel.
]

{ #category : #'private - event handling' }
LePageToolElement >> onPageRemoved: anAnnouncement [
	BlTaskAction
		enqueueElement: self
		action: [ self hideContentElementWithOriginalDatabase: anAnnouncement originalDatabase ]
]

{ #category : #'private - event handling' }
LePageToolElement >> onPageTitleChanged [
	self updateWorldTitle
]

{ #category : #'api - page view model' }
LePageToolElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"

	self contentElement pageViewModel: self pageViewModel.

	self
		enqueueTask: (BlTaskAction new
				action: [ 
					self showContentElement.
					self sidebarElement
						databaseViewModel: self pageViewModel databaseViewModel;
						selection: self pageViewModel.

					self updateWorldTitle ])
]

{ #category : #'private - event handling' }
LePageToolElement >> onSidebarChangePageWish: aWish [
	self pageViewModel = aWish pageUIModel
		ifTrue: [ ^ self ].

	self pageViewModel: aWish pageUIModel
]

{ #category : #'api - page model' }
LePageToolElement >> pageModel [
	self hasPage ifFalse: [ ^ nil ].
	^ self pageViewModel pageModel
]

{ #category : #'api - accessing' }
LePageToolElement >> selectionTransformation: aBlock [
	self contentElement selectionTransformation: aBlock
]

{ #category : #'private - updating' }
LePageToolElement >> showContentElement [
	"See https://github.com/feenkcom/gtoolkit/issues/4186"

	| anId |
	contentElement parent == self ifTrue: [ ^ self ].
	anId := #content asBlocElementId.
	self children
		detect: [ :each | each id = anId ]
		ifFound: [ :anElement | anElement removeFromParent ]
		ifNone: [ "ignore" ].

	self addChild: contentElement as: anId
]

{ #category : #'private - accessing' }
LePageToolElement >> sidebarElement [
	^ sidebarElement
]

{ #category : #'api - page view model' }
LePageToolElement >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
	
	self pageViewModel weak 
		when: LePageViewModelTitleChanged send: #onPageTitleChanged to: self;
		when: LePageViewModelPageReplaced send: #onPageModelReplaced to: self;
		when: LePageViewModelDatabaseChanged send: #onPageDatabaseChanged to: self;
		when: LePageViewModelPageRemoved send: #onPageRemoved: to: self.
]

{ #category : #'private - accessing' }
LePageToolElement >> titleNotifier [
	<return: #GtPhlowTitleNotifier>
	^ titleNotifier
]

{ #category : #'api - page view model' }
LePageToolElement >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self
]

{ #category : #'private - updating' }
LePageToolElement >> updateWorldTitle [
	self titleNotifier notifyIfFocused
]
