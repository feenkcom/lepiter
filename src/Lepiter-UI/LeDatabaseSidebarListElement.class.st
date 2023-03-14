Class {
	#name : #LeDatabaseSidebarListElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'navigationModel',
		'selectionBlock',
		'treeElement'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #accessing }
LeDatabaseSidebarListElement >> database [
	^ self navigationModel database
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> hasNavigationModel [
	^ self navigationModel notNil
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> hasSelection [
	^ navigationModel notNil and: [ navigationModel hasPage ]
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> hasSelectionBlock [
	^ self selectionBlock notNil
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> initialize [
	super initialize.
	
	selectionBlock := [:_ | {}].
	
	self initializeTreeElement.
	self layout: BlLinearLayout vertical.

	self addChild: self treeElement as: #tree.
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: self treeElement).
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> initializeTreeElement [
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
LeDatabaseSidebarListElement >> items [
	^ (self hasSelectionBlock and: [ self hasNavigationModel ])
		ifTrue: [ self selectionBlock value: self navigationModel ]
		ifFalse: [ {} ]
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> navigationModel: anObject [
	navigationModel := anObject.
	navigationModel
		when: LeUIDatabaseNavigationModelChanged
		send: #onNavigationModelChanged:
		to: self.
	self updateTreeItems
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> notifyListSelectionChangedTo: aTreeNode [
	| aPageUIModel |
	
	aTreeNode isForPage ifFalse: [ ^ self ].
	
	aPageUIModel := self databaseViewModel pageUIModelFor: aTreeNode page.
	self selection = aPageUIModel
		ifTrue: [ ^ self ].

	self fireEvent: (LeDatabaseSidebarChangePageWish new pageUIModel: aPageUIModel)
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateTreeItems.
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> onNavigationModelChanged: anAnnouncement [
	self updateTreeItems
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> onTreeSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged selectedDo: [ :anInterval | 
		self treeElement selectedNodeDo: [ :aNode | 
			self notifyListSelectionChangedTo: aNode value ] ]
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> selection [
	^ navigationModel page
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> selection: aViewModel [
	"Set selected page"

	navigationModel announce: (LeUIPageSelectionRequest new page: aViewModel)
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> selectionBlock [
	^ selectionBlock
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> selectionBlock: anObject [
	selectionBlock := anObject.
	self updateTreeItems
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> treeElement [
	^ treeElement
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> treeElement: anObject [
	treeElement := anObject
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> updateSelection [
	| pageTreeNode |
	self hasSelection ifFalse: [ ^ self ].

	self selection class = LeContentViewModel ifTrue: [ ^ self ].

	self hasSelection
		ifTrue: [ pageTreeNode := LePageTreeNodeModel forPage: self selection pageModel.
			self treeElement selectAndScrollTo: pageTreeNode ]
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> updateTreeItems [
	self treeElement
		items: self items
		immediate: [ :aTreeNode | 
			aTreeNode childPageNodes ].
	self updateSelection
]
