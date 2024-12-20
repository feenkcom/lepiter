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
	^ self asLepiterPagePhlowToolFocusStatus: true
]

{ #category : #'*Lepiter-UI' }
LePage >> asLepiterPagePhlowToolFocusStatus: aBoolean [
	^ GtPhlowCompositeTool new
		addTool: (LePagePhlowTool new
			shouldFocusFirstSnippet: aBoolean;
			page: self);
		addTool: (GtPhlowTool default object: self)";
		addTool: (GtConnectorTool new object: self)"
]

{ #category : #'*Lepiter-UI' }
LePage >> asLepiterPagePhlowToolWithoutFocus [
	^ self asLepiterPagePhlowToolFocusStatus: false
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
	^ self asLepiterPagePhlowTool
]

{ #category : #'*Lepiter-UI' }
LePage >> asPreviewElement [

	^ LePageToolContentTreeElement new
		  withTitleOnly;
		  pageViewModel: self asContentUIModel;
		  matchParent
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
		icon: BrGlamorousIcons folder;
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
		painting: [:m |
		| all |
all := {self} asSet, (self incomingLinks collect: [:x | x originReference ifNotNil: [ :aReference | aReference isPageReference ifTrue: [ aReference page ] ifFalse: [ nil ] ] ]), (self allChildOutgoingTextualLinks collect: [:x | x targetReference ifNotNil: [ :aReference | aReference isPageReference ifTrue: [ aReference page ] ifFalse: [ nil ] ]]) reject: #isNil.
m nodes 
	stencil: [:each | 
		| element |
		element := BlElement new 
		size: (each = self ifTrue: [10@10] ifFalse: [5@5]);
		border: (each = self ifTrue: [ BlBorder paint: Color black] ifFalse: [BlBorder empty]);
		when: BlClickEvent do: [:e | e target phlow spawnObject: each];
		aptitude: ((BrGlamorousWithTooltipAptitude2 content: [
			| aContainer |
			aContainer := BlElement new
				layout: BlFrameLayout new;
				constraintsDo: [ :c |
					c horizontal fitContent.
					c vertical fitContent ];
				when: GtPhlowObjectToSpawn do: [ :anEvent | 
					element fireEvent: (GtPhlowObjectToSpawn new 
						fromPreviousSpawnEvent: anEvent) ].
			(each gtViewsFor: GtPhlowEmptyView new) asElementDo: [ :anInspectorElement |
				aContainer addChild: ((anInspectorElement exact: 400@400) asScalableElement size: 200@200)
			] ]) showDelay: 100 milliSeconds);
		geometry: BlCircleGeometry new;
		background: (each isDailyNote ifTrue: [Color blue] ifFalse: [Color red]) ];
	with: all.
m edges 
	fromNearestTightCircle;
		toNearestTightCircle;
	stencil: [:each | BlLineElement new  
		zIndex: -1;
		border: (BlBorder paint: (Color lightGray alpha: 0.5) width: 1);
		toHead: (BlArrowheadSimpleArrow new
			border: (BlBorder paint: (Color lightGray) width: 1))];
	connect: all 
	toAll: [:each | each allChildOutgoingTextualLinks collectAsSet: [:x | x target ifNotNil: #page]].
m layout force.
m ]
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
LePage >> gtOpenInNewTabActionFor: anAction [
	<lePageAction>
	^ anAction button
		id: LeOpenPageInNewWorldTabElementId;
		tooltip: 'Open page in a new world tab';
		icon: BrGlamorousVectorIcons spawn;
		action: [ :aButton | 
			BlSpace new
				pageInPager: self;
				withSceneDriller;
				showFrom: aButton ]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtRemoveActionFor: anAction [
	<lePageAction>

	^ anAction dropdown 
		id: LePageRemoveActionId;
		tooltip: 'Remove Page';
		icon: BrGlamorousVectorIcons remove;
		content: [:aButton | (LePageRemoveDropdownContentStencil new
						page: self;
						anchor: aButton)]
]

{ #category : #'*Lepiter-UI' }
LePage >> gtSpotterActDefaultFrom: aSpotterElement [
	| pageTool toolElement |

	pageTool := self asLepiterPagePhlowTool.
	toolElement := pageTool asElementDo: [ :e | e ].
	(GtPager 
		openWrappedOn: toolElement 
		title: self tabLabel 
		from: aSpotterElement) maximized
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
LePage >> tabLabel [
	"Return a short title that first nicely in ${class:LeWorldElement}$'s tab label"
	<return: #String>
	| aTitle |
	aTitle := self title.
	^ aTitle size < 21
		ifTrue: [ aTitle ]
		ifFalse: [ (aTitle first: (aTitle size min: 21)), '...' ]
]
