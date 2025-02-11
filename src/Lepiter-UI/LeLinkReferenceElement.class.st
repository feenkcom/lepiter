Class {
	#name : #LeLinkReferenceElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable + TLeWithLinkReferenceViewModel + TLeWithFontSize + TLePageToolContentTreeElement + TBlAssertUIProcess',
	#classTraits : 'TBrLayoutResizable classTrait + TLeWithLinkReferenceViewModel classTrait + TLeWithFontSize classTrait + TLePageToolContentTreeElement classTrait + TBlAssertUIProcess classTrait',
	#instVars : [
		'treeElement',
		'snippetsViewModel',
		'updateRequester'
	],
	#category : #'Lepiter-UI-! Link Reference'
}

{ #category : #'private - tree element' }
LeLinkReferenceElement >> createTreeElement [
	^ BrSimpleTree new
		matchParent;
		padding: (BlInsets top: 10 left: 0 bottom: 5 right: 20);
		aptitudeDo: [ :aLook | aLook treeElement clipChildren: false ];
		nodeType: [ :anItemTypeFactory :aTreeNode :aNodeIndex | aTreeNode value snippetView ];
		nodeId: [ :aTreeNode :aNodeIndex | aTreeNode value uid ];
		nodeStencil: [ :aSnippetView | aSnippetView asElement ];
		nodeDataBinder: [ :aSnippetElement :aTreeNode |
			aSnippetElement snippetViewModel: aTreeNode value ];
		rowStencil: [ :aNodeType :aNodeElement | self createTreeRowFor: aNodeElement ];
		rowDataBinder: [ :aRowElement :aTreeNode :aRowIndex | self bindTreeRowData: aTreeNode to: aRowElement at: aRowIndex ]
]

{ #category : #'private - tree element' }
LeLinkReferenceElement >> createTreeRowFor: aSnippetElement [
	^ BlElement new
		layout: BlLinearLayout horizontal;
		clipChildren: false;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ];
		addChild: (BrInlineExpanderElement new
			beSmallSize;
			aptitude: BrGlamorousTriangleInCircleExpanderAptitude;
			toggleAction: [ :aToggleElement :aToggleModel |
				aToggleModel model toggle.
				aSnippetElement snippetViewModel expanded: aToggleModel model isExpanded ]) as: #toggle;
		addChild: aSnippetElement
]

{ #category : #initialization }
LeLinkReferenceElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #initialization }
LeLinkReferenceElement >> initialize [
	super initialize.
	self initializeFontSizeShortcuts.
	self initializeElementUpdater.

	treeElement := self createTreeElement.
	self addChild: treeElement as: #snippetsTree.
	"it will be initialized when #page is assigned"
	snippetsViewModel := nil.

	self addAptitude: (BrLayoutResizerAptitude new
		inherit: treeElement).

	self matchParent.
]

{ #category : #'api - link reference view model' }
LeLinkReferenceElement >> onLinkReferenceViewModelChanged [
	"Is sent when a new linkReference view model is assigned to the element"
	| linkReferenceSnippetViewModel pageSnippetsTreeViewModel |

	self page ensureOneSnippet.
	
	linkReferenceSnippetViewModel := LeLinkReferenceCollectionViewModel new
		linkReferencePreviewViewModel: self linkReferenceViewModel previewViewModel.

	pageSnippetsTreeViewModel := LeSnippetsTreeViewModel new
		sharedSnippetContext: self pageViewModel sharedSnippetContext.

	"pageIncomingLinksViewModel := self class incomingLinksViewModelClass new."

	snippetsViewModel := LeCompositeContentCollectionViewModel new
		addContentCollectionViewModel: linkReferenceSnippetViewModel;
		addContentCollectionViewModel: pageSnippetsTreeViewModel;
		"addContentCollectionViewModel: pageIncomingLinksViewModel;"
		content: self page.

	self primitiveUpdateTree.

	self pageViewModel shouldFocusFirstSnippet
		ifTrue: [ pageSnippetsTreeViewModel focusFirstSnippet ]
]

{ #category : #'api - link reference view model' }
LeLinkReferenceElement >> page [
	<return: #LePage>
	^ self linkReferenceViewModel page
]

{ #category : #'private - accessing' }
LeLinkReferenceElement >> pageViewModel [
	^ self linkReferenceViewModel pageViewModel
]

{ #category : #'api - link reference view model' }
LeLinkReferenceElement >> subscribeToLinkReferenceViewModel [
	"Is sent after a new linkReference view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromLinkReferenceViewModel if elements subscribe to them"
	
	self pageViewModel weak
		when: LePageViewModelSnippetsChanged send: #onSnippetsChanged: to: self.
		
	snippetsViewModel weak
		when: LeSnippetCollectionScrollToChanged send: #onContentTreeScrollTo to: self.
]

{ #category : #'api - link reference view model' }
LeLinkReferenceElement >> unsubscribeFromLinkReferenceViewModel [
	"Is sent before a new linkReference view model is assigned to the element.
	Elements that subscribe to linkReference view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self.
	snippetsViewModel unsubscribe: self
]
