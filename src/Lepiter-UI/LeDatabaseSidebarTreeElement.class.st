Class {
	#name : #LeDatabaseSidebarTreeElement,
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
LeDatabaseSidebarTreeElement >> applyExpandSuchThat [
	self expandSuchThat
		ifNotNil: [ :aBlock | self treeElement expandSuchThat: aBlock ]
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> childrenBlock [
	^ childrenBlock
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> childrenBlock: anObject [
	childrenBlock := anObject
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> database [
	^ self navigationModel database
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> databaseViewModel [
	^ self navigationModel databaseViewModel
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> expandSuchThat [
	^ expandSuchThat
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> expandSuchThat: aBlock [
	expandSuchThat := aBlock.
	self applyExpandSuchThat
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> hasSelection [
	^ navigationModel notNil and: [ navigationModel hasPage ]
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> hasSelectionBlock [
	^ self selectionBlock notNil
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> initialize [
	super initialize.
	
	selectionBlock := [:_ | {}].
	childrenBlock := #children.
	
	self initializeTreeElement.
	self layout: BlLinearLayout vertical.

	self addChild: self treeElement as: #tree.
	self addAptitude: (BrLayoutResizerAptitude new inherit: self treeElement).
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> initializeTreeElement [
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
LeDatabaseSidebarTreeElement >> items [
	^ self hasSelectionBlock ifTrue: [ self selectionBlock value ] ifFalse: [ {} ]
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> navigationModel: anObject [
	navigationModel := anObject.
	navigationModel weak when: LeUIDatabaseNavigationModelChanged send: #onNavigationModelChanged to: self.
	navigationModel weak when: LeUIPageSelected send: #updateSelection to: self
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> notifyListSelectionChangedTo: aTreeNode [
	| aPageUIModel |
	aPageUIModel := aTreeNode page asContentUIModel.
	self selection pageModel = aPageUIModel pageModel ifTrue: [ ^ self ].

	aTreeNode isForPage
		ifTrue: [ self navigationModel
				announce: (LeUIPageSelectionRequest new page: aPageUIModel) ]
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self updateSelection.
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateTreeItems.
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> onNavigationModelChanged [
	self updateTreeItems.
	self updateSelection
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> onTreeSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged selectedDo: [ :anInterval | 
		self treeElement selectedNodeDo: [ :aNode | 
			self notifyListSelectionChangedTo: aNode value ] ]
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> selection [
	^ navigationModel page
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> selection: aViewModel [
	"Set selected page"

	navigationModel announce: (LeUIPageSelectionRequest new page: aViewModel)
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> selectionBlock [
	^ selectionBlock
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> selectionBlock: anObject [
	selectionBlock := anObject.
	self updateTreeItems
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> treeElement [
	^ treeElement
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> treeElement: anObject [
	treeElement := anObject
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> updateSelection [
	| pageTreeNode |
	self hasSelection ifFalse: [ ^ self ].

	self selection class = LeContentViewModel ifTrue: [ ^ self ].

	pageTreeNode := LeTableOfContentsNode new page: self selection pageModel.
	self treeElement selectAndScrollTo: pageTreeNode
]

{ #category : #accessing }
LeDatabaseSidebarTreeElement >> updateTreeItems [
	self treeElement
		items: self items
		immediate: [ :aTreeNode | 
			self childrenBlock value: aTreeNode ].
	self applyExpandSuchThat.
	self updateSelection.
]
