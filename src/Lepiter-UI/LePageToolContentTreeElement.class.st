"
I display a {{gtClass:LePage}} complete tool:
{{gtExample:LeUIExamples>>#pageToolContentElement_Hierarchy|previewExpanded}}

My header (tittle and toolbar) is configurable using {{gtClass:LePageHeaderBuilder}}.

"
Class {
	#name : #LePageToolContentTreeElement,
	#superclass : #LePageToolContentElement,
	#traits : 'TLePageToolContentTreeElement + TLeWithFontSize + TBlAssertUIProcess',
	#classTraits : 'TLePageToolContentTreeElement classTrait + TLeWithFontSize classTrait + TBlAssertUIProcess classTrait',
	#instVars : [
		'footerToolbarElement'
	],
	#classInstVars : [
		'incomingLinksViewModelClass'
	],
	#category : #'Lepiter-UI-! Tool - Page'
}

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> defaultIncomingLinksViewModelClass [
	^ LeIncomingLinksCardsViewModel
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> incomingLinksViewModelClass [
	^ incomingLinksViewModelClass ifNil: [ self defaultIncomingLinksViewModelClass ]
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> incomingLinksViewModelClass: aSubclassOfLeIncomingLinksCollectionViewModel [
	incomingLinksViewModelClass := aSubclassOfLeIncomingLinksCollectionViewModel
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> showIncomingReferencesAsCards [
	self incomingLinksViewModelClass: LeIncomingLinksCardsViewModel
]

{ #category : #'api - incoming links' }
LePageToolContentTreeElement class >> showIncomingReferencesInlined [
	self incomingLinksViewModelClass: LeIncomingLinksInlinedViewModel
]

{ #category : #'private - tree element' }
LePageToolContentTreeElement >> bindTreeRowData: aTreeNode to: aTreeRowElement at: aRowIndex [
	| theLines |
	aTreeRowElement
		childNamed: #toggle
		ifFound: [ :aToggleElement | 
			aToggleElement viewModel model: aTreeNode.
			aToggleElement
				hide: aTreeNode canBeExpanded not;
				expanded: aTreeNode isExpanded;
				disabled: aTreeNode canBeExpanded not.
			aToggleElement
				margin: ((aToggleElement margin withLeft: aTreeNode depth * 15)
						withTop: (aTreeNode canBeExpanded ifTrue: [ 6 ] ifFalse: [ 0 ])) ].

	theLines := aTreeRowElement children
			select: [ :eachChild | eachChild userData at: #leTreeLine ifAbsent: [ false ] ].
	aTreeRowElement removeChildren: theLines.

	theLines := Array
			streamContents: [ :aStream | 
				1
					to: aTreeNode depth + aTreeNode isExpanded asBit
					do: [ :eachDepthLevel | 
						| eachLine |
						eachLine := BlElement new
								constraintsDo: [ :c | 
									c ignoreByLayout.
									c ignored vertical alignTop.
									c horizontal exact: 7.
									c vertical matchParent ];
								layout: BlFrameLayout new;
								relocate: (eachDepthLevel * 15 - 10.5) @ 0;
								padding: (BlInsets top: (aTreeNode depth < eachDepthLevel ifTrue: [ 15 ] ifFalse: [ 0 ]));
								addChild: (BlElement new
										background: BrGlamorousColors lightBorderColor;
										constraintsDo: [ :c | 
											c horizontal exact: 1.
											c vertical matchParent.
											c frame horizontal alignCenter ]).
						eachLine userData at: #leTreeLine put: true.
						eachLine zIndex: -10.
						aStream nextPut: eachLine ] ].

	aTreeRowElement addChildren: theLines.

	aRowIndex = 1 ifTrue: [ self selectOnEnter: aTreeRowElement ]
]

{ #category : #'private - tree element' }
LePageToolContentTreeElement >> createTreeElement [
	^ BrSimpleTree new
		matchParent;
		padding: (BlInsets
				top: 10
				left: 0
				bottom: 5
				right: 20);
		aptitudeDo: [ :aLook | aLook treeElement clipChildren: false ];
		nodeType: [ :anItemTypeFactory :aTreeNode :aNodeIndex | aTreeNode value snippetView ];
		nodeId: [ :aTreeNode :aNodeIndex | aTreeNode value uid ];
		nodeStencil: [ :aSnippetView | aSnippetView asElement ];
		nodeDataBinder: [ :aSnippetElement :aTreeNode | 
			aSnippetElement
				id: (LeSnippetId new uid: aTreeNode value uid);
				snippetViewModel: (aTreeNode value titleElement: self titleElement) ];
		rowStencil: [ :aNodeType :aNodeElement | self createTreeRowFor: aNodeElement ];
		rowDataBinder: [ :aRowElement :aTreeNode :aRowIndex | 
			self
				bindTreeRowData: aTreeNode
				to: aRowElement
				at: aRowIndex ]
]

{ #category : #initialization }
LePageToolContentTreeElement >> initialize [
	super initialize.
	self initializeFontSizeShortcuts.
	self initializeUndoShortcuts.
	self initializeElementUpdater.
	
	treeElement := self createTreeElement.
	self addChild: treeElement as: LePageSnippetsTreeElementId.
	"it will be initialized when #page is assigned"
	snippetsViewModel := nil.

	footerToolbarElement := LePageFooterToolbarElement new.
	self addChild: footerToolbarElement as: #footer.

	self addAptitude: (BrLayoutResizerAptitude new
		hInherit: self headerElement;
		vAnyToFitContent: self headerElement;
		inherit: treeElement)
]

{ #category : #initialization }
LePageToolContentTreeElement >> initializeUndoShortcuts [
	self addShortcut: (BlShortcutWithAction new
		name: 'Undo';
		combination: BlKeyCombination primaryZ;
		action: [ self undoCurrent ]).
		
	self addShortcut: (BlShortcutWithAction new
		name: 'Redo';
		combination: BlKeyCombination primaryShiftZ;
		action: [ self redoCurrent ]).
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> onPageDatabaseChanged [
	updater requestUpdate.
	footerToolbarElement updateContent.
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> onPageModelReplaced [
	snippetsViewModel content: self pageViewModel pageModel.
	updater requestUpdate.
	
	footerToolbarElement pageModel: self pageViewModel pageModel.
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> onPageViewModelChanged [
	| pageSnippetsTreeViewModel pageIncomingLinksViewModel |
	super onPageViewModelChanged.

	self pageViewModel ensurePageHasAtLeastOneSnippet.

	pageSnippetsTreeViewModel := LeSnippetsTreeViewModel new
		sharedSnippetContext: self pageViewModel sharedSnippetContext.

	pageIncomingLinksViewModel := self class incomingLinksViewModelClass new.

	snippetsViewModel := LeCompositeContentCollectionViewModel new
		addContentCollectionViewModel: pageSnippetsTreeViewModel;
		addContentCollectionViewModel: pageIncomingLinksViewModel;
		content: self pageViewModel pageModel.

	self primitiveUpdateTree.
	
	footerToolbarElement pageModel: self pageViewModel pageModel.

	self pageViewModel shouldFocusFirstSnippet
		ifTrue: [ pageSnippetsTreeViewModel focusFirstSnippet ]
]

{ #category : #'api - undo/redo' }
LePageToolContentTreeElement >> redoCurrent [
	self pageViewModel 
		redoCurrentUpdatingSnippetsViewModelFor: (self snippetsViewModel
			viewModelCollections detect: [ :aViewModel |
				aViewModel class = LeSnippetsTreeViewModel ]) 
]

{ #category : #'private - selection' }
LePageToolContentTreeElement >> selectOnEnter: anElement [ 
	self titleElement selectOnExit: anElement
]

{ #category : #'api - accessing' }
LePageToolContentTreeElement >> selectionTransformation: aBlock [
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> subscribeToPageViewModel [
	super subscribeToPageViewModel.

	self pageViewModel weak
		when: LePageViewModelSnippetsChanged send: #onSnippetsChanged: to: self;
		when: LePageViewModelDatabaseChanged send: #onPageDatabaseChanged to: self;
		when: LePageViewModelPageReplaced send: #onPageModelReplaced to: self.
		
	snippetsViewModel weak
		when: LeSnippetCollectionScrollToChanged send: #onContentTreeScrollTo to: self
]

{ #category : #'api - undo/redo' }
LePageToolContentTreeElement >> undoCurrent [
	self pageViewModel 
		undoCurrentUpdatingSnippetsViewModelFor: (self snippetsViewModel
			viewModelCollections detect: [ :aViewModel |
				aViewModel class = LeSnippetsTreeViewModel ]) 
]

{ #category : #'api - page view model' }
LePageToolContentTreeElement >> unsubscribeFromPageViewModel [
	super unsubscribeFromPageViewModel.
	
	self pageViewModel unsubscribe: self
]
