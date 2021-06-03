Class {
	#name : #LeDatabaseDailyNotesElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'selection',
		'treeElement'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #accessing }
LeDatabaseDailyNotesElement >> dailyNoteNodes [
	"Return pages to display"
	^ self database dailyNotesGroup collect: [ :aDailyNote |
		LeDailyNoteTreeNodeModel forDailyNote: aDailyNote ]
]

{ #category : #testing }
LeDatabaseDailyNotesElement >> hasSelection [
	^ selection notNil
]

{ #category : #initialization }
LeDatabaseDailyNotesElement >> initialize [
	super initialize.
	
	selection := nil.
	
	self initializeTreeElement.
	self layout: BlLinearLayout vertical.

	self addChild: self treeElement as: #tree.
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: self treeElement).
]

{ #category : #initialization }
LeDatabaseDailyNotesElement >> initializeTreeElement [
	treeElement := BrSimpleTree new
		margin: (BlInsets top: 5);
		rowStencil: BrGlamorousSimpleTreeSelectableRowElementStencilBuilder new;
		nodeType: [ :anItemTypeFactory :aTreeNode :anItemIndex | aTreeNode value class ];
		nodeStencil: [ :aNodeType |
			aNodeType treeNodeInfoElementClass new
				hMatchParent;
				vFitContent ];
		nodeDataBinder: [ :anItemElement :aTreeNode |
			anItemElement contentViewModel: aTreeNode asNodeViewModel ];
		when: BrSelectionChanged
			do: [ :anEvent | self onTreeSelectionChanged: anEvent ];
		matchParent.
]

{ #category : #accessing }
LeDatabaseDailyNotesElement >> items [
	^ self dailyNoteNodes 
]

{ #category : #'private - notifying' }
LeDatabaseDailyNotesElement >> notifyListSelectionChangedTo: aTreeNode [
	| aPageUIModel |
	
	aTreeNode isForPage ifFalse: [ ^ self ].
	
	aPageUIModel := self databaseViewModel pageUIModelFor: aTreeNode page.
	self selection = aPageUIModel
		ifTrue: [ ^ self ].

	self fireEvent: (LeDatabaseSidebarChangePageWish new pageUIModel: aPageUIModel)
]

{ #category : #'private - hooks' }
LeDatabaseDailyNotesElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateTreeItems.
]

{ #category : #hooks }
LeDatabaseDailyNotesElement >> onPageAdded: aLeDatabasePageAdded [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #hooks }
LeDatabaseDailyNotesElement >> onPageRemoved: aLeDatabasePageRemoved [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #updating }
LeDatabaseDailyNotesElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #'private - event handling' }
LeDatabaseDailyNotesElement >> onTreeSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged selectedDo: [ :anInterval | 
		self treeElement selectedNodeDo: [ :aNode | 
			self notifyListSelectionChangedTo: aNode value ] ]
]

{ #category : #accessing }
LeDatabaseDailyNotesElement >> selection [
	self
		assert: [ selection notNil ]
		description: [ 'Can not access selection that does not exist' ].

	^ selection
]

{ #category : #accessing }
LeDatabaseDailyNotesElement >> selection: aViewModel [
	"Set selected page"
	selection = aViewModel
		ifTrue: [ ^ self ].
	selection := aViewModel.
	self onSelectionChanged
]

{ #category : #'private - subscriptions' }
LeDatabaseDailyNotesElement >> subscribeToContent [
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
			to: self;
		when: LeDatabaseTableOfContentsUUIDChanged
			send: #onTableOfContentsUUIDChanged:
			to: self.
]

{ #category : #accessing }
LeDatabaseDailyNotesElement >> treeElement [
	^ treeElement
]

{ #category : #'private - subscriptions' }
LeDatabaseDailyNotesElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	
	self database unsubscribe: self.
]

{ #category : #'private - updating' }
LeDatabaseDailyNotesElement >> updateSelection [
	| pageTreeNode |
	self hasSelection
		ifFalse: [ ^ self ].
	
	self selection class = LeContentViewModel ifTrue: [^ self ].
	
	pageTreeNode := LePageTreeNodeModel forPage: self selection pageModel.
	self treeElement selectAndScrollTo: pageTreeNode.
]

{ #category : #'private - updating' }
LeDatabaseDailyNotesElement >> updateTreeItems [
	self treeElement 
		items: self dailyNoteNodes 
		immediate: [ :aTreeNode |
			aTreeNode childPageNodes ].
	self updateSelection.
]
