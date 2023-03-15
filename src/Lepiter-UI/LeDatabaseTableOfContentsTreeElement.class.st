"
I display a Table of Contents that is defined in a {{gtClass:LePage}}.
## Collaborators
I use {{gtClass:LeTableOfContentsVisitor}} to extract Table of Contents items, see {{gtMethod:LeDatabase>>#tableOfContentsNodes}}.
I am used by {{gtClass:LeDatabaseSidebarElement}}, see {{gtMethod:LeDatabaseSidebarElement>>#newTableOfContentsElement}}.
## Examples
{{gtExample:LeUIExamples>>#databaseTableOfContentsElement|previewExpanded}}


"
Class {
	#name : #LeDatabaseTableOfContentsTreeElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'treeElement',
		'navigationModel'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsTreeElement >> hasSelection [
	^ navigationModel notNil and: [ navigationModel hasPage ]
]

{ #category : #initialization }
LeDatabaseTableOfContentsTreeElement >> initialize [
	super initialize.
	
	self initializeTreeElement.
	self layout: BlLinearLayout vertical.

	self addChild: self treeElement as: #tree.
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: self treeElement).
]

{ #category : #initialization }
LeDatabaseTableOfContentsTreeElement >> initializeTreeElement [

	treeElement := BrSimpleTree new
		               margin: (BlInsets top: 5);
		               rowStencil:
			               BrGlamorousSimpleTreeSelectableRowElementStencilBuilder
				               new;
		               nodeType: [ :anItemTypeFactory :aTreeNode :anItemIndex | 
			               aTreeNode value page class ];
		               nodeStencil: [ :aNodeType | 
			               LePageTitleAndSummaryElement new
				               hMatchParent;
				               vFitContent ];
		               nodeDataBinder: [ 
			               :anItemElement 
			               :eachLeTableOfContentsNode | 
			               anItemElement pageViewModel:
				               eachLeTableOfContentsNode page asContentUIModel ];
		               when: BrSelectionChanged
		               do: [ :anEvent | 
		               self onTreeSelectionChanged: anEvent ];
		               matchParent
]

{ #category : #'private - accessing' }
LeDatabaseTableOfContentsTreeElement >> items [
	"Return pages to display"
	^ self database tableOfContentsNodes
]

{ #category : #accessing }
LeDatabaseTableOfContentsTreeElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseTableOfContentsTreeElement >> navigationModel: anObject [
	navigationModel := anObject.
	navigationModel
		when: LeUIPageSelected
		send: #onSelectionChanged
		to: self
]

{ #category : #'private - notifying' }
LeDatabaseTableOfContentsTreeElement >> notifyListSelectionChangedTo: aPage [
	| aPageUIModel |
	
	aPageUIModel := self databaseViewModel pageUIModelFor: aPage.
	
	self selection = aPageUIModel
		ifTrue: [ ^ self ].

	self fireEvent: (LeDatabaseSidebarChangePageWish new pageUIModel: aPageUIModel)
]

{ #category : #'hooks - children' }
LeDatabaseTableOfContentsTreeElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self updateSelection.
]

{ #category : #'private - hooks' }
LeDatabaseTableOfContentsTreeElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateTreeItems.
]

{ #category : #'private - announcement handling' }
LeDatabaseTableOfContentsTreeElement >> onPageAdded: aLeDatabasePageAdded [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #'private - announcement handling' }
LeDatabaseTableOfContentsTreeElement >> onPageRemoved: aLeDatabasePageRemoved [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #'private - hooks' }
LeDatabaseTableOfContentsTreeElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #'private - announcement handling' }
LeDatabaseTableOfContentsTreeElement >> onTableOfContentsTextChanged: aLeContentTreeChanged [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #'private - announcement handling' }
LeDatabaseTableOfContentsTreeElement >> onTableOfContentsTreeChanged: aLeContentTreeChanged [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #'private - announcement handling' }
LeDatabaseTableOfContentsTreeElement >> onTableOfContentsUUIDChanged: aLeDatabaseTableOfContentsUUIDChanged [

	aLeDatabaseTableOfContentsUUIDChanged 
		oldPageDo: [ :aPage | aPage unsubscribe: self ];
		newPageDo: [ :aPage | 
			self subscribeToTableOfContentsPage ].

	self enqueueTask: (BlTaskAction new action: [ 
		self updateTreeItems ]).
]

{ #category : #'private - event handling' }
LeDatabaseTableOfContentsTreeElement >> onTreeSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged selectedDo: [ :anInterval | 
		self treeElement selectedNodeDo: [ :aNode | 
			| aToCNode |
			aToCNode := aNode value.
			aToCNode selectedPageDo: [ :aPage |
				self notifyListSelectionChangedTo: aPage ] ] ]
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsTreeElement >> selection [
	<return: #LePageViewModel>

	^ navigationModel page
]

{ #category : #'api - accessing' }
LeDatabaseTableOfContentsTreeElement >> selection: aPageViewModel [
	"Set selected page view model"

	navigationModel announce: (LeUIPageSelectionRequest new page: aPageViewModel)
]

{ #category : #'private - subscriptions' }
LeDatabaseTableOfContentsTreeElement >> subscribeToContent [
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
	self subscribeToTableOfContentsPage.
]

{ #category : #'private - subscriptions' }
LeDatabaseTableOfContentsTreeElement >> subscribeToTableOfContentsPage [
	self tableOfContentsDo: [ :aPage |
		aPage weak
			when: LeContentTreeChanged send: #onTableOfContentsTreeChanged: to: self;
			when: LeSnippetTextChanged send: #onTableOfContentsTextChanged: to: self ]
]

{ #category : #'private - accessing' }
LeDatabaseTableOfContentsTreeElement >> treeElement [
	^ treeElement
]

{ #category : #'private - subscriptions' }
LeDatabaseTableOfContentsTreeElement >> unsubscribeFromContent [
	super unsubscribeFromContent.
	
	self unsubscribeFromTableOfContentsPage.
	self database unsubscribe: self.
]

{ #category : #'private - subscriptions' }
LeDatabaseTableOfContentsTreeElement >> unsubscribeFromTableOfContentsPage [
	self tableOfContentsDo: [ :aPage |
		aPage unsubscribe: self ]
]

{ #category : #'private - updating' }
LeDatabaseTableOfContentsTreeElement >> updateSelection [
	| aToCNode |
	
	self hasSelection
		ifFalse: [ ^ self ].
	
	aToCNode := LeTableOfContentsNode new page: self selection pageModel.
	self treeElement selectAndScrollTo: aToCNode.
	self treeElement
		selectedNodeDo: [ :eachToCNode | 
			eachToCNode value page = self selection pageModel
				ifFalse: [ self treeElement deselectAll ] ]
]

{ #category : #'private - updating' }
LeDatabaseTableOfContentsTreeElement >> updateTreeItems [
	self treeElement items: self items immediate: #children.
	self treeElement expandSuchThat: [ :eachNode | eachNode value isToCNode ].
	self updateSelection.
]
