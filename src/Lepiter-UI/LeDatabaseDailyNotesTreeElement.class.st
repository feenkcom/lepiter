Class {
	#name : #LeDatabaseDailyNotesTreeElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'selection',
		'treeElement',
		'navigationModel'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #accessing }
LeDatabaseDailyNotesTreeElement >> dailyNoteNodes [
	"Return pages to display"
	^ self database dailyNotesGroup collect: [ :aDailyNote |
		LeDailyNoteTreeNodeModel forDailyNote: aDailyNote ]
]

{ #category : #testing }
LeDatabaseDailyNotesTreeElement >> hasSelection [
	^ selection notNil
]

{ #category : #initialization }
LeDatabaseDailyNotesTreeElement >> initialize [
	super initialize.
	
	selection := nil.
	
	self initializeTreeElement.
	self layout: BlLinearLayout vertical.

	self addChild: self treeElement as: #tree.
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: self treeElement).
]

{ #category : #initialization }
LeDatabaseDailyNotesTreeElement >> initializeTreeElement [
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
LeDatabaseDailyNotesTreeElement >> items [
	^ self dailyNoteNodes 
]

{ #category : #accessing }
LeDatabaseDailyNotesTreeElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseDailyNotesTreeElement >> navigationModel: anObject [
	navigationModel := anObject.
	navigationModel
		when: LeUIPageSelected
		send: #onSelectionChanged
		to: self
]

{ #category : #'private - notifying' }
LeDatabaseDailyNotesTreeElement >> notifyListSelectionChangedTo: aTreeNode [
	| aPageUIModel |
	
	aTreeNode isForPage ifFalse: [ ^ self ].
	
	aPageUIModel := self databaseViewModel pageUIModelFor: aTreeNode page.
	self selection = aPageUIModel
		ifTrue: [ ^ self ].

	self fireEvent: (LeDatabaseSidebarChangePageWish new pageUIModel: aPageUIModel)
]

{ #category : #'private - hooks' }
LeDatabaseDailyNotesTreeElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateTreeItems.
]

{ #category : #hooks }
LeDatabaseDailyNotesTreeElement >> onPageAdded: aLeDatabasePageAdded [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #hooks }
LeDatabaseDailyNotesTreeElement >> onPageRemoved: aLeDatabasePageRemoved [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #updating }
LeDatabaseDailyNotesTreeElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #'private - event handling' }
LeDatabaseDailyNotesTreeElement >> onTreeSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged selectedDo: [ :anInterval | 
		self treeElement selectedNodeDo: [ :aNode | 
			self notifyListSelectionChangedTo: aNode value ] ]
]

{ #category : #accessing }
LeDatabaseDailyNotesTreeElement >> selection [
	^ navigationModel page
]

{ #category : #accessing }
LeDatabaseDailyNotesTreeElement >> selection: aViewModel [
	"Set selected page"

	navigationModel announce: (LeUIPageSelectionRequest new page: aViewModel)
]

{ #category : #'private - subscriptions' }
LeDatabaseDailyNotesTreeElement >> subscribeToContent [
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
LeDatabaseDailyNotesTreeElement >> treeElement [
	^ treeElement
]

{ #category : #'private - subscriptions' }
LeDatabaseDailyNotesTreeElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	
	self database unsubscribe: self.
]

{ #category : #'private - updating' }
LeDatabaseDailyNotesTreeElement >> updateSelection [
	| pageTreeNode |
	self hasSelection
		ifFalse: [ ^ self ].
	
	self selection class = LeContentViewModel ifTrue: [^ self ].
	
	pageTreeNode := LePageTreeNodeModel forPage: self selection pageModel.
	self treeElement selectAndScrollTo: pageTreeNode.
]

{ #category : #'private - updating' }
LeDatabaseDailyNotesTreeElement >> updateTreeItems [
	self treeElement 
		items: self dailyNoteNodes 
		immediate: [ :aTreeNode |
			aTreeNode childPageNodes ].
	self updateSelection.
]
