Class {
	#name : #LeSlideshowSnippetElement,
	#superclass : #LeTextualSnippetElement,
	#traits : 'TBlElementError',
	#classTraits : 'TBlElementError classTrait',
	#instVars : [
		'maximizerLook',
		'showCoderToggle',
		'coderResizer',
		'coderContainer',
		'coderDecorationBar',
		'coderToolbar',
		'coderElement',
		'elementContainer',
		'sceneContainer',
		'maximizerAptitude',
		'coderSlideActionsToolbar',
		'dropdownMenuButton',
		'slidesPreviewsContainer',
		'addSlideButton',
		'arrowsAreVisible',
		'slideElement',
		'nextArrow',
		'previousArrow',
		'snippetResizer',
		'slidePreviewEventHandler'
	],
	#category : 'Lepiter-Snippet-Slideshow-Snippet'
}

{ #category : #private }
LeSlideshowSnippetElement >> changeSnippetCode: aString [
	self snippetViewModel coderViewModel coder 
		sourceCode: (GtCoderExplicitSourceCode new source: aString)
		withStrategy: (GtCoderUpdateStrategy new 
			makeSynchronous;
			source: self).
]

{ #category : #accessing }
LeSlideshowSnippetElement >> collectSlides [
	^ self snippetViewModel collectSlides.
]

{ #category : #accessing }
LeSlideshowSnippetElement >> createAddSlideButton [
	^ BrButton new
		beSmallSize;
		margin: (BlInsets top: 0 right: 0 bottom: 10 left: 10);
		padding: (BlInsets all: 10);
		zIndex: 10;
		aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
		icon: BrGlamorousIcons add asElement;
		label: 'Add Slide' asString;
		action: [
			self snippetViewModel addSlide.
			self nextSlide ];
		yourself
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createCoderContainer [
	^ BlElement new
		layout: (BlGridLayout horizontal columnCount: 3);
		padding: (BlInsets all: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createCoderDecorationBar [
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: 8.
			c vertical matchParent ];
		geometry: (BlRoundedRectangleGeometry cornerRadii: (BlCornerRadii new topLeft: 4; topRight: 0; bottomRight: 0; bottomLeft: 4))
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createCoderElement [
	^ GtSourceCoderEditorElement new
		padding: (BlInsets top: 5 left: 7 bottom: 5 right: 0);
		margin: BlInsets empty;
		vExact: 100;
		hMatchParent
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createCoderSlideActionsToolbar [
	^ BrToolbar new
		constraintsDo: [ :c |
			c frame horizontal alignRight.
			c frame vertical alignTop ];
		margin: (BlInsets top: 0 right: 0 bottom: 5 left: 5);
		aptitude: BrGlamorousToolbarAptitude;
		addItem: self createAddSlideButton;
		addItem: self createRemoveSlideButton.
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createCoderToolbar [
	^ GtCoderActionsElement new
		margin: (BlInsets left: 5)
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createDropdownMenuButton [
	| aToolbar |
	slidesPreviewsContainer := self createSlidesPreviewsContainer.
	^ BrButton new
		beSmallSize;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ];
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 10);
		zIndex: 10;
		icon: BrGlamorousIcons hamburger asElement;
		label: 'Slides';
		action: [ self updateSlidesPreviewsContainer ];
		aptitude: 
			BrGlamorousButtonWithIconAptitude
			+ (BrGlamorousWithDropdownAptitude
				handle: [ BrButton new
						aptitude: BrGlamorousButtonWithIconAptitude 
							- BrGlamorousButtonWithLabelTooltipAptitude
							- BrGlamorousButtonExteriorAptitude;
						icon: BrGlamorousIcons hamburger asElement;
						yourself ]
				content: [ | dropdownMenu dropdownContainer |
					aToolbar := BrToolbar new
						aptitude: BrGlamorousToolbarAptitude;
						margin: (BlInsets bottom: 5).
					aToolbar
						addItem:
							(BrToggle new
								beSmallSize;
								activated: true;
								aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
								icon: BrGlamorousIcons edit asElement;
								label: 'Update arrows' asString;
								when: BrToggleActivatedEvent
									do: [ :anEvent |
										arrowsAreVisible := true.
										self updateArrows ];
								when: BrToggleDeactivatedEvent
									do: [ :anEvent |
										arrowsAreVisible := false.
										self updateArrows ]);
						addItem:
							(BrToggle new
								beSmallSize;
								activated: self snippetViewModel shouldShowCode;
								aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
								icon: BrGlamorousIcons browse asElement;
								label: 'Browse Code' asString;
								when: BrToggleActivatedEvent
									do: [ :anEvent | self snippetViewModel showCode ];
								when: BrToggleDeactivatedEvent
									do: [ :anEvent | self snippetViewModel hideCode ]).
					dropdownContainer := BlElement new
						size: 700 @ 320;
						layout: BlLinearLayout vertical;
						addChild: slidesPreviewsContainer asScrollableElement;
						addChild: aToolbar.
					dropdownMenu := BlElement new
						size: 700 @ 320;
						layout: BlLinearLayout vertical;
						addChild: dropdownContainer;
						addChild: (BrResizer new
							aptitude: BrGlamorousResizerAptitude;
							elevation: (BlRelativeElevation elevation: 1000);
							beBottom;
							constraintsDo: [ :c | c ignoreByLayout ];
							target: dropdownContainer;
							when: BlResizerResizedEvent do: [ :anEvent |
								dropdownMenu height: anEvent extent y ]).
					dropdownMenu ]);
			constraintsDo: [ :c | c linear horizontal alignRight ];
			padding: (BlInsets all: 10);
			yourself.
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createElementContainer [
	^ BrHorizontalPane new
		hMatchParent;
		vExact: 100;
		padding: (BlInsets all: 5)
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createNextArrow [
	nextArrow := BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beRight.
	^ BrHorizontalPane new
		hExact: 24;
		vMatchParent;
		alignCenter;
		when: BlClickEvent do: [:e |
			self nextSlide ];
		addChild: nextArrow;
		addAptitude: (BrStyleCommonAptitude new
			@ nextArrow;
			default: [ :aStyle | aStyle background: (BrGlamorousColors defaultButtonBorderColor) ];
			hovered: [ :aStyle | aStyle background: (BrGlamorousColors hoveredButtonBorderColor) ]).
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createPreviousArrow [
	previousArrow := BlElement new
		size: 12 @ 24;
		geometry: BlTriangleGeometry new beLeft.
	^ BrHorizontalPane new
		hExact: 24;
		vMatchParent;
		alignCenter;
		when: BlClickEvent do: [:e |
			self previousSlide ];
		addChild: previousArrow;
		addAptitude: (BrStyleCommonAptitude new
			@ previousArrow;
			default: [ :aStyle | aStyle background: (BrGlamorousColors defaultButtonBorderColor) ];
			hovered: [ :aStyle | aStyle background: (BrGlamorousColors hoveredButtonBorderColor) ]).
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createRemoveSlideButton [
	^ BrButton new
		beSmallSize;
		margin: (BlInsets bottom: 10);
		padding: (BlInsets all: 10);
		zIndex: 10;
		aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
		icon: BrGlamorousIcons remove asElement;
		label: 'Remove Slide' asString;
		action: [
			| slideCode |
			slideCode := self snippetViewModel removeSlide.
			self changeSnippetCode: slideCode.
			self setElementFromCoder.
			self updateArrows ];
		yourself
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createSceneContainer [
	^ BrVerticalPane new
		hMatchParent;
		vFitContent;
		clipChildren: false
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createShowCodeToggleButton [
	^ BrToggle new
		beSmallSize;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ];
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 10);
		zIndex: 10;
		aptitude: BrGlamorousButtonWithIconAptitude + BrGlamorousToggleBackgroundAptitude;
		icon: BrGlamorousIcons browse asElement;
		label: 'Browse Code' asString;
		when: BrToggleActivatedEvent
			do: [ :anEvent | self snippetViewModel showCode ];
		when: BrToggleDeactivatedEvent
			do: [ :anEvent | self snippetViewModel hideCode ];
		yourself
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createSlideElement [
	^ BrHorizontalPane new matchParent.
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createSlidesPreviewsContainer [
	^ BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ];
		padding: (BlInsets all: 10).
]

{ #category : #initialization }
LeSlideshowSnippetElement >> createVerticalResizer [
	^ BrResizer new
		aptitude: BrGlamorousResizerAptitude;
		elevation: (BlRelativeElevation elevation: 1000);
		beBottom;
		constraintsDo: [ :c | c ignoreByLayout ]
]

{ #category : #private }
LeSlideshowSnippetElement >> defaultErrorStencil [

	^ BrValuableStencil new valuable: [ :anException | | container message |
		container := BlElement new.
		container layout: BlLinearLayout horizontal.
		message := errorText ifNil: [ anException messageText ].
		container addChild: (BlTextElement new
			text: 'Debug' translated asRopedText;
			border: (BlBorder paint: Color gray width: 1);
			labelMeasurement;
			background: Color white;
			padding: (BlInsets top: 5 left: 8 bottom: 5 right: 8);
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			when: BlClickEvent do: [ [ anException defaultAction ] fork ]).
		container addChild: (BlTextElement new 
			margin: (BlInsets left: 10 right: 10);
			constraintsDo: [ :c |
				c horizontal exact: 1200.
				c vertical exact: 14 ];
			text: message asRopedText).
		container ].
]

{ #category : #accessing }
LeSlideshowSnippetElement >> editor [ 
	"Answer the current editor element"
	^ coderElement
]

{ #category : #'private - coder' }
LeSlideshowSnippetElement >> ensureCoderCreated [
	"The coder element is initialized lazily only when view model's #shouldShowCode is true"
	
	self isCoderCreated
		ifTrue: [ ^ self ].

	coderElement := self createCoderElement.
	coderDecorationBar := self createCoderDecorationBar.
	coderToolbar := self createCoderToolbar.
	coderSlideActionsToolbar := self createCoderSlideActionsToolbar.
	
	coderContainer := self createCoderContainer.
	coderContainer
		addChild: coderDecorationBar;
		addChild: coderElement;
		addChild: coderSlideActionsToolbar;
		addChild: coderToolbar.
]

{ #category : #accessing }
LeSlideshowSnippetElement >> exceptionAction [

	^ [
		slideElement removeChildNamed: #displayElement.
		exception ifNotNil: [ | exceptionElement |
				exceptionElement := (self errorStencil arguments: { exception }) create.
				exceptionElement constraintsDo: [ :c | 
					c horizontal fitContent.
					c vertical fitContent.
					c frame vertical alignCenter.
					c frame horizontal alignCenter ].
				slideElement addChild: exceptionElement as: #displayElement ] ]
]

{ #category : #private }
LeSlideshowSnippetElement >> generateDisplayElement [
	[[		
		self snippetViewModel doItAllRequestedBy: self ]
		on: Error
			do: [ :ex | self exception: ex ]]
		on: GtCoderEvaluationUnhandledError
			do: [ :ex | self exception: ex exception ]
]

{ #category : #'private - coder' }
LeSlideshowSnippetElement >> hideCoder [	
	self isCoderCreated
		ifFalse: [ ^ self ].
	
	(sceneContainer hasChild: coderContainer)
		ifTrue: [ sceneContainer removeChild: coderContainer ].
	
	(elementContainer hasChild: coderResizer)
		ifTrue: [ elementContainer removeChild: coderResizer ]
]

{ #category : #initialization }
LeSlideshowSnippetElement >> initialize [
	| nextArrowElement previousArrowElement |
	
	super initialize.
	
	self vFitContent.
	self hMatchParent.
	
	sceneContainer := self createSceneContainer.
	elementContainer := self createElementContainer.
	slideElement := self createSlideElement.
	nextArrowElement := self createNextArrow.
	previousArrowElement := self createPreviousArrow.
	elementContainer addChildren: {previousArrowElement. slideElement. nextArrowElement}.
	arrowsAreVisible := true.
	sceneContainer addChild: elementContainer as: #elementContainer.	

	sceneContainer addChild: (snippetResizer := self createVerticalResizer
		target: elementContainer;
		when: BlResizerResizedEvent do: [ :anEvent |
			self snippetViewModel setElementHeightTo: anEvent extent y ]).

	dropdownMenuButton := self createDropdownMenuButton.
	sceneContainer addChild: dropdownMenuButton.
	sceneContainer addAptitude: (maximizerAptitude := BrGlamorousWithMaximizerAptitude new
			// #elementContainer;
			preferredBackground: Color white ).

	"self onSnippetViewModelFocused: false."
	
	self enqueueTask: (BlTaskAction new action: [
		self setElementFromCoder.
		self snippetViewModel updateSlidePreviewsAptitude ]).
]

{ #category : #initialization }
LeSlideshowSnippetElement >> initializeCoderAddOns: anObject [
	"Initialise the keyboard shortcuts in the code editor"

	anObject addOns
		"Create New snippet (after the current snippet)"
		addShortcut: (LeSnippetSplitSnippetShortcut new combination: (self keyboardShortcut: #SplitSnippet));
		"Delete previous character, or merge with previous snippet"	
		addShortcut: (LeSnippetDeletePreviousShortcut new combination: (self keyboardShortcut: #DeletePrevious));
		"Indent LeSnippet"
		addShortcut: (LeSnippetIndentSnippetShortcut new combination: (self keyboardShortcut: #IndentSnippet));
		"Unindent LeSnippet"
		addShortcut: (LeSnippetUnindentSnippetShortcut new combination: (self keyboardShortcut: #UnindentSnippet));
		"Move Snippet up"
		addShortcut: (LeSnippetMoveSnippetUpShortcut new combination: (self keyboardShortcut: #MoveSnippetUp));
		"Move Snippet down"
		addShortcut: (LeSnippetMoveSnippetDownShortcut new combination: (self keyboardShortcut: #MoveSnippetDown))
]

{ #category : #'private - coder' }
LeSlideshowSnippetElement >> isCoderCreated [
	<return: #Boolean>
	^ coderContainer notNil
]

{ #category : #accessing }
LeSlideshowSnippetElement >> nextSlide [
	| slideCode |
	self snippetViewModel hasNextSlide ifFalse: [ ^ self ].
	slideCode := self snippetViewModel nextSlide.
	self changeSnippetCode: slideCode.
	self setElementFromCoder.
	self updateArrows.
]

{ #category : #'private - event handling' }
LeSlideshowSnippetElement >> onCodeEvaluated: anEvaluatedAnnouncement [
	"(anEvaluatedAnnouncement isRequestedByElementOrItsChild: self)
		ifFalse: [ ^ self ]."
	
	self snippetViewModel updateCurrentSlide.
	
	self setElement: [ anEvaluatedAnnouncement evaluationResult value ]
]

{ #category : #'private - event handling' }
LeSlideshowSnippetElement >> onCodeVisibilityChanged [
	self snippetViewModel shouldShowCode
		ifTrue: [ self showCoder ]
		ifFalse: [ self hideCoder ].
		
	"showCoderToggle activated: self snippetViewModel shouldShowCode"
]

{ #category : #'private - event handling' }
LeSlideshowSnippetElement >> onHeightChanged [
	elementContainer vExact: self snippetViewModel elementHeight.
	self updateCoderHeight
]

{ #category : #'private - event handling' }
LeSlideshowSnippetElement >> onPageChildEvaluated: aLeUIPageChildEvaluationAnnouncement [
	snippetViewModel ifNotNil: [ self snippetViewModel coderViewModel coder requestStyleSourceText ]
]

{ #category : #'api - snippet view model' }
LeSlideshowSnippetElement >> onPostSnippetViewModelChanged [
	super onPostSnippetViewModelChanged.
	
	self snippetViewModel displayElement
		ifNotNil: [ :anElement | self setElement: [ anElement ] asStencil ]
		ifNil: [ self generateDisplayElement ]
]

{ #category : #'api - snippet view model' }
LeSlideshowSnippetElement >> onSnippetViewModelChanged [
	super onSnippetViewModelChanged.

	self onCodeVisibilityChanged.
	self onHeightChanged.

	self updateCoderElementViewModel
]

{ #category : #'api - snippet view model' }
LeSlideshowSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	(aBoolean and: [ self snippetViewModel isCoderFocused not ])
		ifTrue: [ sceneContainer requestFocus ].

	aBoolean
		ifFalse: [ sceneContainer loseFocus ].

	aBoolean
		ifTrue: [ snippetResizer visibility: BlVisibility visible ]
		ifFalse: [ snippetResizer visibility: BlVisibility gone ].
		
	aBoolean
		ifTrue: [ dropdownMenuButton visibility: BlVisibility visible ]
		ifFalse: [ dropdownMenuButton visibility: BlVisibility gone ].
		
	aBoolean
		ifTrue: [ maximizerAptitude showMaximizeButton ]
		ifFalse: [ maximizerAptitude hideMaximizeButton ].
		
	self updateCoderWhenFocused: aBoolean
]

{ #category : #accessing }
LeSlideshowSnippetElement >> previousSlide [
	| slideCode |
	self snippetViewModel hasPreviousSlide ifFalse: [ ^ self ].
	slideCode := self snippetViewModel previousSlide.
	self changeSnippetCode: slideCode.
	self setElementFromCoder.
	self updateArrows.
]

{ #category : #initialization }
LeSlideshowSnippetElement >> registerEventsForCoder: aCoder [

	aCoder announcer weak
		when: GtCoderEvaluationAnnouncement
		send: #onCodeEvaluated:
		to: self
]

{ #category : #'api - updating' }
LeSlideshowSnippetElement >> reorderSlides [
	| slideNr slides currentSlideIndex shouldUpdateCurrentSlide slideCode |

	slideNr := 1.
	shouldUpdateCurrentSlide := false.
	slides := self collectSlides.
	currentSlideIndex := self snippetViewModel currentSlideIndex.
	slidesPreviewsContainer childrenDo: [ :each | 
		| slide methodString newSlideMethod |
		slide := slides detect: [ :sl | sl previewElement = each ].
		slide slideIndex = slideNr
			ifFalse: [
				slide slideIndex = currentSlideIndex
					ifTrue: [
						shouldUpdateCurrentSlide := true ].
				slide slideIndex: slideNr ].
		slideNr := slideNr + 1 ].
	self snippetViewModel rearrangeSlides.
	
	shouldUpdateCurrentSlide 
		ifTrue: [
			slideCode := self snippetViewModel changeToSlideWithIndex: currentSlideIndex.
			self changeSnippetCode: slideCode.
			self setElementFromCoder.
			self updateArrows.
			self snippetViewModel updateSlidePreviewsAptitude ].
	
	self updateSlidesPreviewsContainer.
]

{ #category : #private }
LeSlideshowSnippetElement >> setElement: anElementStencil [
	"Set the value of the supplied stencil as the receiver's display element"
	| displayElement |

	displayElement := [ anElementStencil value 
			ifNil: [ BlElement new ]
			ifNotNil: [ :element | element asElement ] ]
		on: Error 
		do: [ :ex | ^ self exception: ex ].
	
	slideElement removeChildNamed: #displayElement.
	displayElement removeFromParent.
	slideElement addChild: displayElement as: #displayElement.

	self snippetViewModel displayElement: displayElement.
	
	self updateArrows.
]

{ #category : #private }
LeSlideshowSnippetElement >> setElementFromCoder [
	"Set the receiver's display element based on the coder's content"

	self snippet isSnippet ifTrue:
		[ self setElement: [ (self snippetViewModel doItAllRequestedBy: self) value 
			ifNil: [ BlElement new ]
			ifNotNil: [ :anElement | anElement ] ] ]
	ifFalse:
		[ self setElement: [ BlElement new ] ]
]

{ #category : #'private - coder' }
LeSlideshowSnippetElement >> showCoder [		
	self ensureCoderCreated.
	
	(sceneContainer hasChild: coderContainer)
		ifTrue: [ ^ self ].
		
	sceneContainer addChild: coderContainer.
	
	elementContainer addChild: (coderResizer := self createVerticalResizer
		target: elementContainer;
		when: BlResizerResizedEvent do: [ :anEvent |
			self snippetViewModel resizeElementHeightTo: anEvent extent y ]).

	self updateCoderWhenFocused: self snippetViewModel focused.
	self updateCoderHeight.
	self updateCoderElementViewModel
]

{ #category : #'api - view' }
LeSlideshowSnippetElement >> snippetContent [
	"Return an element that represents a content of the snippet.
	The embedder is responsible for placing #snippetContent in the right place within snippet element depending on the
	View Model properties and derived look"
	<return: #BlElement>

	^ sceneContainer
]

{ #category : #'api - view' }
LeSlideshowSnippetElement >> snippetToolbar [
	"Return an element that represents a toolbar of the snippet. A toolbar usually appears below the snippet content.
	The embedder is responsible for placing #snippetToolbar in the right place within snippet element depending on the
	View Model properties and derived look.
	If returned #snippetToolbar is nil, no toolbar will be added"
	<return: #BlElement or: nil>

	^ nil
]

{ #category : #'api - snippet view model' }
LeSlideshowSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.

	self snippet weak
		when: LeUIPageChildEvaluationAnnouncement
		send: #onPageChildEvaluated:
		to: self.

	self snippetViewModel weak
		when: LeSlideshowSnippetViewModelHeightChanged
		send: #onHeightChanged
		to: self.
		
	self snippetViewModel weak
		when: LeSlideshowSnippetViewModelCodeVisibilityChanged
		send: #onCodeVisibilityChanged
		to: self.
		
	self snippetViewModel coderViewModel coder weak
		when: GtCoderEvaluationAnnouncement
		send: #onCodeEvaluated:
		to: self
]

{ #category : #'api - snippet view model' }
LeSlideshowSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.

	self snippet unsubscribe: self.
	self snippetViewModel unsubscribe: self.
	self snippetViewModel coderViewModel coder unsubscribe: self
]

{ #category : #'api - updating' }
LeSlideshowSnippetElement >> updateArrows [
	(arrowsAreVisible and: [ self snippetViewModel hasPreviousSlide ])
		ifTrue: [ previousArrow visibility: BlVisibility visible ]
		ifFalse: [ previousArrow visibility: BlVisibility hidden ].
	(arrowsAreVisible and: [ self snippetViewModel hasNextSlide ])
		ifTrue: [ nextArrow visibility: BlVisibility visible ]
		ifFalse: [ nextArrow visibility: BlVisibility hidden ]
]

{ #category : #'private - coder' }
LeSlideshowSnippetElement >> updateCoderElementViewModel [
	self isCoderCreated
		ifFalse: [ ^ self ].

	coderElement textualCoderViewModel: self snippetViewModel coderViewModel.
	coderToolbar textualCoderViewModel: self snippetViewModel coderViewModel
]

{ #category : #'private - coder' }
LeSlideshowSnippetElement >> updateCoderHeight [
	self isCoderCreated
		ifFalse: [ ^ self ].

	coderElement vExact: self snippetViewModel codeHeight
]

{ #category : #'private - coder' }
LeSlideshowSnippetElement >> updateCoderWhenFocused: isFocused [
	self isCoderCreated
		ifFalse: [ ^ self ].

	isFocused
		ifTrue: [ coderResizer visibility: BlVisibility visible ]
		ifFalse: [ coderResizer visibility: BlVisibility gone ].

	isFocused
		ifTrue: [
			coderDecorationBar constraintsDo: [ :c | c grid vertical span: 2 ].
			coderDecorationBar background: (BrGlamorousColors primaryBorderColor alpha: 0.4) gtOpaqueColorOnWhite ]
		ifFalse: [
			coderDecorationBar constraintsDo: [ :c | c grid vertical span: 1 ].
			coderDecorationBar background: BrGlamorousColors lightBorderColor ].
			
	isFocused
		ifTrue: [
			coderToolbar constraintsDo: [ :c | c grid horizontal span: 1 ].
			coderToolbar visibility: BlVisibility visible ]
		ifFalse: [
			coderToolbar constraintsDo: [ :c | c grid horizontal span: 2 ].
			coderToolbar visibility: BlVisibility hidden ]
]

{ #category : #'api - updating' }
LeSlideshowSnippetElement >> updateSlidesPreviewsContainer [
	slidePreviewEventHandler 
		ifNil: [
			slidePreviewEventHandler := LeSlidesSortHandler new
				dropBlock: [ self reorderSlides ];
				yourself ].
	slidesPreviewsContainer removeChildren.
	self collectSlides
		do: [ :each |
			each updateElements.
			each asPreviewElement removeFromParent.
			each asPreviewElement removeEventHandlersSuchThat: [ :handler |
				handler isKindOf: LeSlidesSortHandler ].
			slidesPreviewsContainer
				addChild:
					( each asPreviewElement
						when: BlClickEvent
						do: [ :e |
							| slideCode |
							slideCode := self snippetViewModel changeToSlideWithIndex: each slideIndex.
							self changeSnippetCode: slideCode.
							self setElementFromCoder.
							self updateArrows.
							self snippetViewModel updateSlidePreviewsAptitude. ];
						preventChildrenMouseEvents;
						addEventHandlerIfNotPresent: slidePreviewEventHandler )].
]
