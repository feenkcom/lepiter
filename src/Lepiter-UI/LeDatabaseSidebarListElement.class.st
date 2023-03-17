Class {
	#name : #LeDatabaseSidebarListElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'selectionBlock',
		'treeElement',
		'childrenBlock',
		'navigationModel',
		'expandSuchThat'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #accessing }
LeDatabaseSidebarListElement >> applyExpandSuchThat [
	self expandSuchThat
		ifNotNil: [ :aBlock | self treeElement expandSuchThat: aBlock ]
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> childrenBlock [
	^ childrenBlock
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> childrenBlock: anObject [
	childrenBlock := anObject
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> database [
	^ self navigationModel database
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> databaseViewModel [
	^ self navigationModel databaseViewModel
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> expandSuchThat [
	^ expandSuchThat
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> expandSuchThat: aBlock [
	expandSuchThat := aBlock.
	self applyExpandSuchThat
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
	childrenBlock := #children.
	
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
	^ self hasSelectionBlock ifTrue: [ self selectionBlock value ] ifFalse: [ {} ]
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> navigationModel: anObject [
	navigationModel := anObject.
	navigationModel when: LeUIDatabaseNavigationModelChanged send: #onNavigationModelChanged to: self
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> notifyListSelectionChangedTo: aTreeNode [
	| aPageUIModel |
	aPageUIModel := aTreeNode page asContentUIModel.
	self selection = aPageUIModel ifTrue: [ ^ self ].

	aTreeNode isForPage
		ifTrue: [ self navigationModel
				announce: (LeUIPageSelectionRequest new page: aPageUIModel) ]
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self updateSelection.
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateTreeItems.
]

{ #category : #accessing }
LeDatabaseSidebarListElement >> onNavigationModelChanged [
	self updateTreeItems.
	self updateSelection
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
			self childrenBlock value: aTreeNode ].
	self applyExpandSuchThat.
	self updateSelection.
]
