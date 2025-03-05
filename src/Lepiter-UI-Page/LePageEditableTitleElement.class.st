"
I display a {{gtClass:LePage}} title: {{gtExample: LePageEditableTitleElementExamples>>#pageEditableTitleElement_TitledPage | previewExpanded=true | codeExpanded=false}}


"
Class {
	#name : #LePageEditableTitleElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement',
		'selectOnExit',
		'addButton',
		'acceptButton',
		'cancelButton'
	],
	#category : #'Lepiter-UI-Page-! Views'
}

{ #category : #initialization }
LePageEditableTitleElement >> acceptPageTitle [
	self acceptPageTitleWith: titleElement text asString
]

{ #category : #initialization }
LePageEditableTitleElement >> acceptPageTitleWith: aString [
	self pageViewModel pageTitle: aString
]

{ #category : #initialization }
LePageEditableTitleElement >> createAddButton [
	| aButton |
	aButton := self plusButton
		elevation: (BlRelativeElevation elevation: 20);
		constraintsDo: [ :c | 
			c ignoreByLayout.
			c ignored horizontal alignCenter.
			c ignored vertical alignBottom ];
		visibility: BlVisibility hidden;
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
				handle: [ self plusButton
						aptitude: BrIconAptitude;
						background: BrGlamorousColors secondaryHeaderBackgroundColor ]
				content: [ GtSpotterDropdownButtonStencil new
						valuable: (LeContextMenuSpotterStart new database: pageViewModel database);
						extent: [ 300 @ 400 ];
						spotterModelDo: [ :aSpotter | 
							aSpotter hidePreview.
							aSpotter announcer weak
								when: GtSpotterExitAnnouncement
								send: #onSpotterExitAnnouncement:
								to: self ];
						objectActOn: [ :anActOnEvent :aMenuItem :theButton | 
							self pageViewModel pageModel addSnippet: aMenuItem asSnippet beforeIndex: 1.
							self titleElement requestFocus.	"ideally the new snippet would gain focus here"
							anActOnEvent beActed ];
						spotterElementFor: aButton ]
				containerDo: [ :aMenuContainer | 
					aMenuContainer background: BrGlamorousColors secondaryHeaderBackgroundColor ])
				doNotHideWidget.
				
	^ aButton
]

{ #category : #initialization }
LePageEditableTitleElement >> createTitleElement [
	| anEditor |
	anEditor := BrEditor new
			aptitude: ((BrGlamorousEditableLabelAptitude basicNew
					setDefaultBorderColor: Color transparent;
					setFocusedBorderColor: Color transparent;
					initialize)
					fontSize: 25;
					defaultBackground: Color transparent;
					glamorousRegularFont;
					bold);
			margin: (BlInsets
					top: 8
					left: LeSnippetView contentPaddingLeft + 3
					bottom: 8
					right: 0);
			padding: (BlInsets
					top: 5
					left: 5
					bottom: 5
					right: 5);
			hMatchParent;
			vFitContent;
			background: Color white;
			when: BrEditorAcceptWish do: [ :aWish | self onAcceptTitleWish: aWish ];
			when: BlFocusOutEvent do: [ :anEvent | self acceptPageTitle ];
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination enter;
					action: [ :aShortcutEvent | 
						self acceptPageTitle.
						self pageViewModel pageModel
							addSnippet: (LeTextSnippet string: '')
							beforeIndex: 1 ]);
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination primaryG;
					action: [ :aShortcutEvent | 
						self hasPage
							ifTrue: [ aShortcutEvent currentTarget phlow spawnTool: self pageViewModel asPhlowTool ] ]);
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination primaryB;
					action: [ :aShortcutEvent | 
						self hasPage
							ifTrue: [ aShortcutEvent currentTarget phlow spawnTool: self pageViewModel asPhlowTool ] ]);
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination primaryR;
					action: [ :aShortcutEvent | aShortcutEvent currentTarget switchToEditor ]);
			addShortcut: (BlShortcutWithAction new
					combination: BlKeyCombination primaryR;
					action: [ :aShortcutEvent | 
						self hasPage
							ifTrue: [ Clipboard clipboardText: self pageViewModel pageTitle asString ] ]).

	^ anEditor
]

{ #category : #private }
LePageEditableTitleElement >> hideAddButton [
	addButton visibility: BlVisibility hidden
]

{ #category : #initialization }
LePageEditableTitleElement >> initialize [
	super initialize.

	self layout: BlLinearLayout horizontal alignCenter.	"we can not add elements without widget models to toolbar. To be fixed"
	self addViewModel: BrWidgetModel new.

	titleElement := self createTitleElement.
	self addChild: titleElement as: #title.

	addButton := self createAddButton.
	self addChild: addButton as: #addButton.

	self
		addAptitude: (BrLazyStyleCommonAptitude new
				when: BlElementState focused | BlElementState hovered
					style: [ :aStyle | aStyle do: [ self showAddButton ] after: [ self hideAddButton ] ];
				when: BlElementState focused & BlElementState hovered
					style: [ :aStyle | aStyle do: [ self visuallyFocus ] after: [ self visuallyUnfocusAndUnhover ] ];
				when: BlElementState focused & BlElementState hovered not
					style: [ :aStyle | aStyle do: [ self visuallyFocus ] after: [ self visuallyUnfocusAndUnhover ] ];
				when: BlElementState hovered & BlElementState focused not
					style: [ :aStyle | aStyle do: [ self visuallyHover ] after: [ self visuallyUnfocusAndUnhover ] ]).

	self
		vFitContent;
		hMatchParent.

	self padding: (BlInsets right: 10).
	self clipChildren: false.

	self initializeShortcuts
]

{ #category : #initialization }
LePageEditableTitleElement >> initializeShortcuts [
	self
		addShortcut: (BlShortcutWithAction new
				combination: BlKeyCombination arrowDown;
				overrideChildren: true;
				action: [ self loseFocus.
					self selectOnExit
						ifNotNil: [ ((self selectOnExit childAt: 2) childAt: 1) snippetViewModel focused: true ] ]);
		addShortcut: (BlShortcutWithAction new
				combination: (BlKeyCombination builder
						shift;
						primary;
						key: BlKeyboardKey return;
						build);
				action: [ :anEvent :aShortcut | addButton dispatchEvent: BrDropdownShowWish new ])
]

{ #category : #'private - event handling' }
LePageEditableTitleElement >> onAcceptTitleWish: aWish [
	"Is sent by the editable title when users `accept` a new page title"

	self pageViewModel pageTitle: aWish text asString.
	self updatePageTitle
]

{ #category : #'private - event handling' }
LePageEditableTitleElement >> onPageTitleChanged [
	self titleElement enqueueTask: (BlTaskAction new action: [ self updatePageTitle ])
]

{ #category : #'api - page view model' }
LePageEditableTitleElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"

	self titleElement
		styler: (LePageTitleStyler new pageViewModel: self pageViewModel).
	self enqueueTask: (BlTaskAction new action: [ self updatePageTitle ])
]

{ #category : #'private - event handling' }
LePageEditableTitleElement >> onSpotterExitAnnouncement: anAnnouncement [
	self titleElement requestFocus
]

{ #category : #initialization }
LePageEditableTitleElement >> plusButton [
	^ GtInspectorRoundButtonStencil small asElement
		icon: (GtInspectorPlusIconStencil add
				thickness: 1;
				radius: 4;
				asElement)
]

{ #category : #focus }
LePageEditableTitleElement >> requestFocus [
	titleElement requestFocus
]

{ #category : #focus }
LePageEditableTitleElement >> selectOnExit [
	^ selectOnExit
]

{ #category : #focus }
LePageEditableTitleElement >> selectOnExit: anElement [
	selectOnExit := anElement
]

{ #category : #private }
LePageEditableTitleElement >> showAddButton [
	addButton visibility: BlVisibility visible
]

{ #category : #'api - page view model' }
LePageEditableTitleElement >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
	
	self pageViewModel weak when: LePageViewModelTitleChanged send: #onPageTitleChanged to: self
]

{ #category : #'private - accessing' }
LePageEditableTitleElement >> titleElement [
	^ titleElement
]

{ #category : #'api - page view model' }
LePageEditableTitleElement >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
	
	self pageViewModel unsubscribe: self
]

{ #category : #'private - updating' }
LePageEditableTitleElement >> updatePageTitle [
	| page |
	"I must be called from a UI process."
	page := self pageViewModel pageModel.
	page isUnnamedPage
		ifTrue: [ self titleElement
				text: ('' asRopedText
						attribute: (BrGhostTextAttribute
								for: (page type defaultTitle asRopedText glamorousRegularFontAndSize
										foreground: Color lightGray))) ]
		ifFalse: [ self titleElement text: self pageViewModel pageTitle ]
]

{ #category : #initialization }
LePageEditableTitleElement >> visuallyFocus [
	titleElement effect: (BlGaussianShadowEffect
		color: (BrGlamorousColors primaryBorderColor)
		width: 2
		offset: 0 @ 1)
]

{ #category : #initialization }
LePageEditableTitleElement >> visuallyHover [
	titleElement
		effect: (BlGaussianShadowEffect
				color: BrGlamorousColors defaultShadowColor
				width: 2
				offset: 0 @ 1).
]

{ #category : #initialization }
LePageEditableTitleElement >> visuallyUnfocusAndUnhover [
	titleElement effect: BlNullEffect new
]
