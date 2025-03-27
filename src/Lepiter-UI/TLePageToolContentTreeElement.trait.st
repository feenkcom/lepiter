Trait {
	#name : #TLePageToolContentTreeElement,
	#instVars : [
		'treeElement',
		'snippetsViewModel',
		'updater'
	],
	#category : #'Lepiter-UI-! Tool - Page'
}

{ #category : #asserting }
TLePageToolContentTreeElement >> assertUIProcess [
	self explicitRequirement
]

{ #category : #'private - tree element' }
TLePageToolContentTreeElement >> bindTreeRowData: aTreeNode to: aTreeRowElement at: aRowIndex [
	| theLines |
	aTreeRowElement
		childNamed: #toggle
		ifFound: [ :aToggleElement | 
			aToggleElement viewModel model: aTreeNode.
			aToggleElement
				hide: aTreeNode canBeExpanded not;
				expanded: aTreeNode isExpanded;
				disabled: aTreeNode canBeExpanded not.
			aToggleElement margin: ((aToggleElement margin withLeft: aTreeNode depth * 15) withTop: (aTreeNode canBeExpanded ifTrue: [ 6 ] ifFalse: [ 0 ])) ].
	
	theLines := aTreeRowElement children select: [ :eachChild | eachChild userData at: #leTreeLine ifAbsent: [ false ] ].
	aTreeRowElement removeChildren: theLines.

	theLines := Array streamContents: [ :aStream |
		1 to: (aTreeNode depth + aTreeNode isExpanded asBit) do: [ :eachDepthLevel |
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

	aTreeRowElement addChildren: theLines
]

{ #category : #'private - tree element' }
TLePageToolContentTreeElement >> createTreeElement [
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
TLePageToolContentTreeElement >> createTreeRowFor: aSnippetElement [
	^ BlElement new
		layout: BlLinearLayout horizontal;
		clipChildren: false;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContentLimited ];
		addChild: (BrInlineExpanderElement new
			beSmallSize;
			aptitude: BrGlamorousTriangleInCircleExpanderAptitude;
			toggleAction: [ :aToggleElement :aToggleModel |
				aToggleModel model toggle.
				aSnippetElement snippetViewModel expanded: aToggleModel model isExpanded ]) as: #toggle;
		addChild: aSnippetElement
]

{ #category : #initialization }
TLePageToolContentTreeElement >> initializeElementUpdater [
	updater := BrElementUpdater new element: self.
	updater action: [ self primitiveUpdateSnippetsAndTree ]
]

{ #category : #'private - event handling' }
TLePageToolContentTreeElement >> onContentTreeScrollTo [
	self assertUIProcess.
	
	snippetsViewModel takeViewModelToScrollToIf: [ :aViewModelToScrollTo | self treeElement scrollToItem: aViewModelToScrollTo ]
]

{ #category : #'private - event handling' }
TLePageToolContentTreeElement >> onSnippetsChanged: anAnnouncement [

	updater requestUpdate
]

{ #category : #'private - tree element' }
TLePageToolContentTreeElement >> primitiveUpdateSnippetsAndTree [
	self assertUIProcess.

	self snippetsViewModel ifNil: [ ^ self ].

	self snippetsViewModel updateChildren.

	self primitiveUpdateTree.

	self snippetsViewModel takeViewModelToScrollToIf: [ :aViewModelToScrollTo |
		self treeElement scrollToItem: aViewModelToScrollTo ]
]

{ #category : #'private - tree element' }
TLePageToolContentTreeElement >> primitiveUpdateTree [
	self assertUIProcess.

	self treeElement
		items: self snippetsViewModel children lazy: [ :eachSnippetUIModel | eachSnippetUIModel snippetChildren ]; 
		expandSuchThat: [ :eachTreeNode | eachTreeNode value expanded ].
]

{ #category : #'private - accessing' }
TLePageToolContentTreeElement >> snippetsViewModel [
	<return: #LeContentCollectionViewModel or: nil>
	^ snippetsViewModel
]

{ #category : #'private - accessing' }
TLePageToolContentTreeElement >> treeElement [
	<return: #BrSimpleTree>
	^ treeElement
]
