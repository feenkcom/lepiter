Extension { #name : #LePage }

{ #category : #'*Lepiter-UI' }
LePage >> asClickableLabel [
	"For building Sceneries and Mondrian maps with clickable labels for Lepiter pages."
	
	^ (LePageTitleLabelBuilder forPage: self) build
]

{ #category : #'*Lepiter-UI' }
LePage >> asContentUIModel [
	<return: #LeContentViewModel>
	^ LePageViewModel new pageModel: self
]

{ #category : #'*Lepiter-UI' }
LePage >> asLepiterPagePhlowTool [
	^ self type 
		ifNil: [ GtPhlowTool default object: self]
		ifNotNil: [ :aPageType |
			aPageType asLepiterPagePhlowToolFocusStatus: true ]
]

{ #category : #'*Lepiter-UI' }
LePage >> asLepiterPagePhlowToolWithoutFocus [
	^ self type 
		ifNil: [ GtPhlowTool default object: self]
		ifNotNil: [ :aPageType |
			aPageType asLepiterPagePhlowToolFocusStatus: false ]
]

{ #category : #'*Lepiter-UI' }
LePage >> asLepiterReferencedPagePhlowTool: aReferencedPage [
	^ GtPhlowCompositeTool new
		addTool: ((LeReferencedPagePhlowTool page: self) referencedPage: aReferencedPage);
		addTool: (GtPhlowTool default object: self);
		addTool: (GtConnectorTool new object: self)
]

{ #category : #'*Lepiter-UI' }
LePage >> asPhlowTool [
	<return: #LePhlowTool>
	^ self type asLepiterPagePhlowTool
]

{ #category : #'*Lepiter-UI' }
LePage >> asPreviewElement [
	^ self type asPreviewElement
]

{ #category : #'*Lepiter-UI' }
LePage >> dependenciesMapFor: aMondrian [
	| all |
	all := {self} asSet
			, (self incomingLinks
					collect: [ :x | 
						x originReference
							ifNotNil: [ :aReference | aReference isPageReference ifTrue: [ aReference page ] ifFalse: [ nil ] ] ])
			, (self allChildOutgoingTextualLinks
					collect: [ :x | 
						x targetReference
							ifNotNil: [ :aReference | aReference isPageReference ifTrue: [ aReference page ] ifFalse: [ nil ] ] ])
			reject: #isNil.
	aMondrian nodes
		stencil: [ :each | 
			| element |
			element := BlElement new
					size: (each = self ifTrue: [ 10 @ 10 ] ifFalse: [ 5 @ 5 ]);
					border: (each = self ifTrue: [ BlBorder paint: Color black ] ifFalse: [ BlBorder empty ]);
					when: BlClickEvent do: [ :e | e target phlow spawnObject: each ];
					aptitude: (self hoverPage: each forNodeElement: element);
					geometry: BlCircleGeometry new;
					background: (each isDailyNote ifTrue: [ Color blue ] ifFalse: [ Color red ]) ];
		with: all.
	aMondrian edges
		fromNearestTightCircle;
		toNearestTightCircle;
		stencil: [ :each | 
			BlLineElement new
				zIndex: -1;
				border: (BlBorder paint: (Color lightGray alpha: 0.5) width: 1);
				toHead: (BlArrowheadSimpleArrow new border: (BlBorder paint: Color lightGray width: 1)) ];
		connect: all
			toAll: [ :each | 
				each allChildOutgoingTextualLinks
					collectAsSet: [ :x | x target ifNotNil: #page ] ].
	aMondrian layout force.
	^ aMondrian
]

{ #category : #'*Lepiter-UI' }
LePage >> gtConnectionsFor: aView [
	<gtView>
	^ aView explicit
		title: 'Connections';
		stencil: [	
			| gtconnector searchButton |

			gtconnector := GtConnector new.

			gtconnector layout: (BlZoomableLayout new
				animationDuration: 250 milliSeconds;
				addLayout: (GtGradHorizontalTreeLayout new levelDistance: 150; nodeDistance: 20)).

			gtconnector
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ].
			
			"Mark connector as a normal tool that does not expand the contained pages."
			gtconnector beNormalLevel.
			
			gtconnector stencil: [ :lePage |
				| pageContainer |
				pageContainer := LeConnectorPageContainerElement new.
				pageContainer 
					page: lePage;
					connectorElement: gtconnector.
				pageContainer connector 
					beLayoutSource; 
					beLayoutTarget;
					beVisualTarget;
					model: lePage.
				pageContainer
			].
			gtconnector referencedEntities: [ :aPage | 
				(aPage allChildOutgoingTextualLinks select: #isTextualPageLink) collect: #target ].
			searchButton := GtSpotterDropdownButtonStencil new
				icon: BrGlamorousVectorIcons add;
				valuable: [ self database ];
				tooltip: 'Add existing page';
				objectActOn: [ :anActOnEvent :aPage |
					| shortestPath |
					shortestPath := LePathFinder new 
						betweenPage: self and: aPage.
					(shortestPath 
						ifNil: [ gtconnector addEntity: aPage ] 
						ifNotNil: [ shortestPath do: [ :aPathPage |
							gtconnector addEntity: aPathPage ] ] ).
					anActOnEvent beActed ];
				asElement.
			searchButton constraintsDo: [ :c | 
				c ignoreByLayout.
				c padding: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
				c ignored horizontal alignRight.
				c ignored vertical alignTop ].
				
			gtconnector addEntity: self.
			
			BrFrame new 
				matchParent;
				addChild: (gtconnector constraintsDo: [ :c |
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]);
				addChild: searchButton;
				constraintsDo: [ :c |  
					c margin: (BlInsets all: 10 )] ]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtCopyPageFilePathActionFor: anAction [
	<gtAction>
	
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].
	
	^ anAction button
		tooltip: 'Inspect the page''s file';
		priority: 5;
		icon: BrGlamorousVectorIcons folder;
		action: [ :aButton |
			Clipboard clipboardText: (self database monitor pageFilename: self).
			aButton phlow spawnObject: (self database monitor pageFileReference: self) ]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtDatabaseActionFor: anAction [
	<todo: 'We need a database icon!'>
	<gtAction>
	self database ifNil: [ ^ anAction noAction ].
	self database isDatabase ifFalse: [ ^ anAction noAction ].

	^ anAction button
		tooltip: 'Inspect the page''s database';
		priority: 8;
		icon: LeIcons lepiterDatabase;
		id: LePageDatabaseActionId;
		action: [ :aButton | aButton phlow spawnObject: self database ]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtDependenciesMapFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Dependencies map';
		painting: [ :m | self dependenciesMapFor: m ]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtMarkdownPageFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Markdown';
		priority: 50;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ self asMarkdownPage ];
		actionUpdateButton
]

{ #category : #'*Lepiter-UI' }
LePage >> gtPageActionsDropdownMenuFor: anAction [
	"To automatically add actions as menu items, define an action as 
	an extension method, with LePageActionTarget as the `target:`
	I am modeled after the class actions dropdown: Behavior>>#gtClassActionsDropdownFor:"

	<lePageAction>
	(LePageActionTarget actionsForObject: self) ifEmpty: [ ^ anAction empty ].
	^ anAction dropdown
		tooltip: 'Page actions';
		icon: BrGlamorousVectorIcons hamburger;
		id: LePageActionTargetDropdownButtonId;
		priority: 100;
		menuItemsForObject: self fromTarget: LePageActionTarget
]

{ #category : #'*Lepiter-UI' }
LePage >> gtPageInspectorActionsDropdownMenuFor: anAction [
	"This dropdown is for the Inspector view of a LePage, rather than the main page view."

	<gtAction>
	"This is too slow to be useful."
	"(#gtAction gtPragmas & LePage gtMethodsInClass & #target: gtSenders
		& LePageInspectorActionTarget gtReferences) isEmpty
		ifTrue: [ ^ anAction empty ]."

	^ anAction dropdown
		tooltip: 'Page actions';
		icon: BrGlamorousVectorIcons hamburger;
		id: LePageActionTargetDropdownButtonId;
		priority: 40;
		menuItemsForObject: self fromTarget: LePageInspectorActionTarget;
		yourself
]

{ #category : #'*Lepiter-UI' }
LePage >> gtReachablePagesMapFor: aView [
	"Inspired by: Optimizing the links in the book for first time readers
	The map shows the current page in blue, reachable pages in dark green, and unreachable pages in red. To avoid clutter, the ToC page is not included, but is considered for reachability. Nodes are scaled according to their word count.
	Only named pages are included."

	<gtView>
	^ aView mondrian
		title: 'Reachability Map';
		painting: [ :m | self reachablePagesMapFor: m from: self ]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtRemoveActionFor: anAction [
	<gtAction>

	^ anAction dropdown 
		id: LePageRemoveActionId;
		tooltip: 'Remove page';
		priority: 10;
		icon: BrGlamorousVectorIcons bin;
		target: LePageActionTarget;
		menuItemGroup: BrMenuItemGroupConfiguration editing;
		content: [:aButton | (LePageRemoveDropdownContentStencil new
						page: self;
						anchor: aButton)]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtSpotterActDefaultFrom: aSpotterElement [
	BlSpace showTool: self asPhlowTool from: aSpotterElement
]

{ #category : #'*Lepiter-UI' }
LePage >> gtSpotterDatabaseFor: aSearch [
	<gtSearch>
	self database ifNil: [ ^ aSearch empty ].
	^ aSearch list
		priority: 20;
		title: 'Pages';
		wantsToDisplayOnEmptyQuery: true;
		previewElement: [ :aLePage | 
			| aPageViewModel |
			aPageViewModel := aLePage asContentUIModel.
			LePageToolElement new pageViewModel: aPageViewModel ];
		filterBySubstring;
		items: [ self database children ]
]

{ #category : #'*Lepiter-UI' }
LePage >> hoverPage: aPage forNodeElement: aMondrianNodeElement [
	^ (BrGlamorousWithExplicitTooltipAptitude
		content: [ | aContainer |
			aContainer := BlElement new
					layout: BlFrameLayout new;
					constraintsDo: [ :c | 
						c horizontal fitContent.
						c vertical fitContent ];
					when: GtPhlowObjectToSpawn
						do: [ :anEvent | aMondrianNodeElement fireEvent: (GtPhlowObjectToSpawn new fromPreviousSpawnEvent: anEvent) ].
			(aPage gtViewsFor: GtPhlowEmptyView new)
				asElementDo: [ :anInspectorElement | 
					aContainer
						addChild: ((anInspectorElement exact: 400 @ 400) asScalableElement size: 200 @ 200) ] ])
		showDelay: 100 milliSeconds
]

{ #category : #'*Lepiter-UI' }
LePage >> reachablePagesMap [
	"Inspired by GT Book page: Optimizing the links in the book for first time readers"
	^ self reachablePagesMapFor: GtMondrian new from: self
]

{ #category : #'*Lepiter-UI' }
LePage >> reachablePagesMapFor: aMondrian from: aStartPage [
	"Inspired by: Optimizing the links in the book for first time readers
	The map shows the current page in blue, reachable pages in dark green, and unreachable pages in red. To avoid clutter, the ToC page is not included, but is considered for reachability. Nodes are scaled according to their word count.
	Only named pages are included."

	| nonTocPages allReachedPages minSize maxSize maxWordVal |
	nonTocPages := self database pagesByName reject: #isTableOfContents.

	allReachedPages := aStartPage
			deepCollect: [ :each | 
				each allChildOutgoingTextualLinks
					collectAsSet: [ :x | x target ifNotNil: #page ] ].
	maxWordVal := (self database pages collect: #wordCount) max sqrt.
	minSize := 5.
	maxSize := 25.

	aMondrian nodes
		stencil: [ :each | 
			| element color size scaledSize |
			color := (allReachedPages includes: each)
					ifTrue: [ Color green muchDarker ]
					ifFalse: [ Color red  ].
			scaledSize := ((maxSize - minSize) * each wordCount sqrt / maxWordVal)
					truncated + minSize.
			size := scaledSize @ scaledSize.
			each = aStartPage
				ifTrue: [ color := Color blue.
					size := 30 @ 30 ].
			element := BlElement new
				background: color;
				size: size;
				geometry: BlCircleGeometry new;
				when: BlClickEvent
					do: [ :e | e currentTarget phlow spawnTool: each asPhlowTool ];
				aptitude: (self hoverPage: each forNodeElement: element) ];
		with: nonTocPages.
	aMondrian edges
		stencil: [ BlLineElement new
				border: Color veryLightGray;
				toHead: (BlArrowheadSimpleArrow new border: Color veryLightGray);
				zIndex: -1 ];
		connectToAll: [ :page | page allOutgoingTextualLinks collectAsSet: #target ].
	aMondrian layout force
		nbIterations: 30;
		charge: -50.
	^ aMondrian
]

{ #category : #'*Lepiter-UI' }
LePage >> tabLabel [
	"Return a short title that first nicely in ${class:LeWorldElement}$'s tab label"
	<return: #String>
	| aTitle |
	aTitle := self title.
	^ aTitle size < 21
		ifTrue: [ aTitle ]
		ifFalse: [ (aTitle first: (aTitle size min: 21)), '...' ]
]
