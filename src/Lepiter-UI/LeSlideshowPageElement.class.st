Class {
	#name : #LeSlideshowPageElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'columnCount',
		'page',
		'slidesGridTool',
		'slidesDetailTool',
		'toolDetailAptitude'
	],
	#category : #'Lepiter-UI-Slideshow Page Type'
}

{ #category : #initialization }
LeSlideshowPageElement class >> page: aLePage [
	^ self basicNew
		page: aLePage;
		initialize
]

{ #category : #initialization }
LeSlideshowPageElement >> addExplainerToButtons: anElement [
	| buttonsToExplain |
	buttonsToExplain := {#slidesChangeLayoutButton
				-> (anElement query // #slidesChangeLayoutButton) anyOne.
			#playSlidesButton -> (anElement query // #playSlidesButton) anyOne}.
	buttonsToExplain
		do: [ :each | 
			each value
				preventChildrenMouseEvents;
				addChild: (BrButton new
						constraintsDo: [ :c | c ignoreByLayout ];
						size: 25 @ 25;
						elevation: (BlRelativeElevation elevation: 10);
						geometry: BlCircle new;
						aptitude: (GtExplainerTargetAptitude new explanationModel: each key);
						relocate: 5 @ each value extent y / 2) ].
	^ anElement
]

{ #category : #initialization }
LeSlideshowPageElement >> addSlideLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new fontSize: 20);
		text: 'Add Slide';
		padding: (BlInsets top: 50)
]

{ #category : #ui }
LeSlideshowPageElement >> changeLayoutButton [
	^ BrButton new
		id: #slidesChangeLayoutButton;
		zIndex: 1000;
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets all: 25);
		constraintsDo: [ :c | 
			c frame horizontal alignLeft.
			c frame vertical alignTop ];
		label: 'Zoom out to change slide order';
		icon: self dynamicGridButtonIcon;
		action: [ :aBrButton :aBrButtonModel :anEvent | 
			| grid |
			anEvent consumed: true.
			grid := (aBrButton parent query // #slidesGrid) result anyOne.
			self columnCount = self summaryColumnCount
				ifTrue: [ grid columnCount: self detailedColumnCount.
					self columnCount: self detailedColumnCount.
					aBrButton icon: self dynamicGridButtonIcon;
					label: 'Zoom out to change slide order'.
					(grid query // LeElementSnippetElement) result
						do: [ :aSnippetElement | aSnippetElement showCoder ].
					self dispatchEvent: GtSlidesGridShowMoreDetailEvent new ]
				ifFalse: [ grid columnCount: self summaryColumnCount.
					self columnCount: self summaryColumnCount.
					aBrButton icon: self dynamicGridButtonIcon;
					label: 'Zoom in to work on slide code'.
					(grid query // LeElementSnippetElement) result
						do: [ :aSnippetElement | aSnippetElement hideCoder ].
					self dispatchEvent: GtSlidesGridShowLessDetailEvent new ] ]
]

{ #category : #accessing }
LeSlideshowPageElement >> columnCount [
	^ columnCount
]

{ #category : #accessing }
LeSlideshowPageElement >> columnCount: anInteger [
	columnCount := anInteger
]

{ #category : #ui }
LeSlideshowPageElement >> detailedColumnCount [
	^ 2
]

{ #category : #ui }
LeSlideshowPageElement >> dynamicGridButtonIcon [
	| columns pane |
	columns := {self detailedColumnCount.
			self summaryColumnCount} detect: [ :each | (each = self columnCount) not ].
	pane := BrHorizontalPane new
			matchParent;
			addChild: (BrHorizontalGrid new
					fitContent;
					size: 20 @ 20;
					cellSpacing: 1;
					columnCount: columns;
					addChildren: ((1 to: (columns = 4 ifTrue: [ 12 ] ifFalse: [ 4 ]))
							collect: [ :_ | 
								BlElement new
									size: (columns = 4 ifTrue: [ 4 @ 4 ] ifFalse: [ 8 @ 8 ]);
									background: Color black ])).
	^ columns = 4 ifTrue: [ pane alignBottomCenter ] ifFalse: [ pane alignCenter ]
]

{ #category : #accessing }
LeSlideshowPageElement >> elementSnippets [
	| result |
	result := OrderedCollection new.
	self page
		withAllChildrenDepthFirstDo: [ :aSnippet | (aSnippet isKindOf: LeElementSnippet) ifTrue: [ result add: aSnippet ] ].

	^ result
]

{ #category : #initialization }
LeSlideshowPageElement >> howToEditor [
	^ (BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		beReadOnlyWithSelection;
		text: self howToText)
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent ];
		margin: (BlInsets
				top: 10
				left: 50
				bottom: 0
				right: 10)
]

{ #category : #initialization }
LeSlideshowPageElement >> howToText [
	^ 'Add a slide above or continue reading below for instructions on how to use this tool.
	
The two views below show the two views this tool has. On the left is the view you will see when the tool is in expanded mode. On the right is the view you wil see when the tool is in ''minimized mode'' (when there are two miller columns in the current pager).
	
You will not see both tools at once, only shown here for explanatory purposes.
	
The view on the left has a scrollable list of slides and a detailed view of a single slide where you can modify the slide code. Try it out! You can use the + and x buttons on each slide to add (either empty or from templates) or delete slides respectively.
	
The view on the right is scrollable as well. It has two buttons:
	- The '
		asRopedText
		, ('change layout' asRopedText glamorousExplanationFor: #slidesChangeLayoutButton)
		, ' button toggles the amount of columns shown as well as the slide code. When in ''summmary mode'', when you can''t see the slide code, you can drag and drop slides around to modify their order. Try it out!
	- The '
		asRopedText
		, ('play slideshow' asRopedText glamorousExplanationFor: #playSlidesButton)
		, ' button generates a slideshow from the current slides in a new window.' asRopedText
]

{ #category : #initialization }
LeSlideshowPageElement >> howToTool [
	| verticalPane |
	verticalPane := BrVerticalPane new matchParent
			alignBottomCenter;
			addChildren: {self addSlideLabel.
					self newAddSlideDropdown.
					self howToEditor.
					self toolForExplainer}.
	verticalPane explainer isExplanationHolder: true.
	self addExplainerToButtons: verticalPane.
	^ verticalPane
]

{ #category : #initialization }
LeSlideshowPageElement >> initializaTools [
	toolDetailAptitude
		ifNotNil: [ self removeAptitude: toolDetailAptitude.
			toolDetailAptitude := nil ].
	self page type elementSnippets size = 0
		ifTrue: [ self
				removeChildren;
				addChild: self howToTool asElement ]
		ifFalse: [ self
				removeChildren;
				addChildren: {slidesDetailTool := self slidesDetailTool.
						slidesGridTool := self slidesGridTool};
				addAptitude: (toolDetailAptitude := GtPhlowToolDetailAptitude new
							normal: [ :aStyle | 
								aStyle
									do: [ slidesDetailTool visibility: BlVisibility gone.
										slidesGridTool visibility: BlVisibility visible ] ];
							detailed: [ :aStyle | 
								aStyle
									do: [ slidesDetailTool visibility: BlVisibility visible.
										slidesGridTool visibility: BlVisibility gone ] ]) ]
]

{ #category : #initialization }
LeSlideshowPageElement >> initialize [
	super initialize.
	self phlow beViewContent.
	self
		id: #slideshowPageTool;
		matchParent.
	self initializaTools.
	self page announcer weak
		when: LeContentTreeRemoved
		do: [ :anAnnouncement | 
			self page type elementSnippets size = 0
				ifTrue: [ self initializaTools ] ]
]

{ #category : #initialization }
LeSlideshowPageElement >> newAddSlideDropdown [
	<return: #BlElement>
	| aButton |
	aButton := self newPlusElement.
	aButton
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
				handle: [ self newPlusElement
						aptitude: BrIconAptitude;
						background: BrGlamorousColors secondaryHeaderBackgroundColor ]
				content: [ GtSpotterDropdownButtonStencil new
						valuable: LeSlideshowPageSpotterStart new;
						extent: [ 800 @ 600 ];
						objectActOn: [ :anActOnEvent :aMenuItem :theButton | 
							self page addSnippet: aMenuItem asSnippet.
							self initializaTools.
							anActOnEvent beActed ];
						spotterElementFor: aButton ]
				containerDo: [ :aMenuContainer | aMenuContainer background: BrGlamorousColors secondaryHeaderBackgroundColor ])
				doNotHideWidget.
	^ aButton
]

{ #category : #initialization }
LeSlideshowPageElement >> newPlusElement [
	<return: #BlElement>
	^ GtInspectorRoundButtonStencil large asElement
		icon: (BrPlusIconStencil add
				thickness: 1;
				radius: 4;
				asElement);
		margin: (BlInsets top: 10 bottom: 10)
]

{ #category : #ui }
LeSlideshowPageElement >> onSnippetAdded: aGrid createElementOfClass: aClass [
	self page announcer weak
		when: LeContentTreeAdded
		do: [ :anAnnouncement | 
			(anAnnouncement content isKindOf: LeElementSnippet)
				ifTrue: [ | indexOfNewSnippet pageSnippets |
					pageSnippets := self page type elementSnippets.
					indexOfNewSnippet := pageSnippets indexOf: anAnnouncement content.
					aGrid
						addChild: (aClass forSnippet: anAnnouncement content)
						at: indexOfNewSnippet ] ]
]

{ #category : #ui }
LeSlideshowPageElement >> onSnippetRemoved: aGrid [
	self page announcer weak
		when: LeContentTreeRemoved
		do: [ :anAnnouncement | 
			(anAnnouncement content isKindOf: LeElementSnippet)
				ifTrue: [ aGrid children
						detect: [ :each | [ each snippet = anAnnouncement content ] on: MessageNotUnderstood do: [ false ] ]
						ifFound: [ :found | 
							(found isKindOf: LeSlideshowPageSlideListDetailElement)
								ifTrue: [ aGrid replaceChild: found with: self placeholderElement ]
								ifFalse: [ aGrid removeChild: found ] ] ] ]
]

{ #category : #accessing }
LeSlideshowPageElement >> page [
	^ page
]

{ #category : #accessing }
LeSlideshowPageElement >> page: aLePge [
	page := aLePge
]

{ #category : #ui }
LeSlideshowPageElement >> placeholderElement [
	^ BlTextElement
		text: ('Select a slide to work on' asRopedText foreground: Color lightGray)
]

{ #category : #ui }
LeSlideshowPageElement >> playSlideshowButton [
	^ BrButton new
		id: #playSlidesButton;
		zIndex: 1000;
		aptitude: BrGlamorousButtonWithIconAptitude;
		margin: (BlInsets all: 25);
		constraintsDo: [ :c | 
			c frame horizontal alignRight.
			c frame vertical alignTop ];
		label: 'Play slideshow in new window';
		icon: BrGlamorousVectorIcons play;
		action: [ :aBrButton :aBrButtonModel :anEvent | 
			| gtPresenterSlideshow slideshowElement slideshowViewModel |
			anEvent consumed: true.
			gtPresenterSlideshow := GtPresenterSlideShow new.
			gtPresenterSlideshow slides
				slides: (self elementSnippets
						collect: [ :elementSnippet | 
							GtPresenterSlide new
								stencil: [ GtElementLiveSlide new
										element: [ elementSnippet coder asCoderViewModel doIt value ] ]
										asStencil ]).
			slideshowViewModel := GtPresenterSlideShowViewModel new
					slideShow: gtPresenterSlideshow.
			slideshowElement := GtPresenterSlideShowElement new
					slideShowViewModel: slideshowViewModel.
			BlSpace new
				withSceneDriller;
				addChild: slideshowElement;
				show ]
]

{ #category : #ui }
LeSlideshowPageElement >> slidesDetailTool [
	| pane slideDetailContainer |
	pane := BrHorizontalPane new
			id: #slidesDetailTool;
			matchParent.
	slideDetailContainer := BrVerticalPane new
			id: #slidesDetail;
			padding: (BlInsets all: 10);
			matchParent;
			alignCenter;
			constraintsDo: [ :c | c linear weight: 4 ];
			addChild: self placeholderElement.
	self onSnippetRemoved: slideDetailContainer.

	^ pane
		addChildren: {self slidesList.
				slideDetailContainer}
]

{ #category : #ui }
LeSlideshowPageElement >> slidesGrid [
	self columnCount: self detailedColumnCount.
	^ BrHorizontalGrid new
		id: #slidesGrid;
		hMatchParent;
		vFitContent;
		columnCount: self columnCount;
		cellSpacing: 10;
		addChildren: (self elementSnippets
				collect: [ :aSnippet | LeSlideshowPageSlideGridElement forSnippet: aSnippet ])
]

{ #category : #ui }
LeSlideshowPageElement >> slidesGridTool [
	| aFrame aGrid aScrollable |
	aFrame := BrFrame new
			id: #slidesGridTool;
			matchParent.
	aGrid := self slidesGrid.
	aScrollable := BrFrame new
			hMatchParent;
			vFitContent;
			addChild: aGrid;
			asScrollableElement.
	aFrame
		addChildren: {aScrollable.
				self changeLayoutButton.
				self playSlideshowButton}.
	self onSnippetAdded: aGrid createElementOfClass: LeSlideshowPageSlideGridElement.
	self onSnippetRemoved: aGrid.

	^ aFrame
]

{ #category : #ui }
LeSlideshowPageElement >> slidesList [
	| aVerticalPane |
	aVerticalPane := BrVerticalPane new
			id: #slidesList;
			hMatchParent;
			vFitContent;
			padding: (BlInsets all: 10);
			constraintsDo: [ :c | c linear weight: 1 ];
			cellSpacing: 10;
			addAptitude: BrShadowAptitude new
					+ (BrGlamorousSlideExteriorAptitude new
							backgroundPaint: Color white;
							borderPaint: Color transparent);
			addChildren: (self elementSnippets
					collect: [ :aSnippet | LeSlideshowPageSlideListElement forSnippet: aSnippet ]).
	self onSnippetAdded: aVerticalPane createElementOfClass: LeSlideshowPageSlideListElement.
	self onSnippetRemoved: aVerticalPane.
	self page announcer weak
		when: LeContentTreeChanged
		do: [ :anEvent | 
			anEvent content = self page
				ifTrue: [ | slideElements |
					slideElements := aVerticalPane children
							groupedBy: [ :each | each snippet uid ].
					aVerticalPane removeChildren.
					self elementSnippets
						do: [ :each | aVerticalPane addChild: (slideElements at: each uid) first ] ] ].
	^ aVerticalPane asScrollableElement
]

{ #category : #ui }
LeSlideshowPageElement >> summaryColumnCount [
	^ 4
]

{ #category : #initialization }
LeSlideshowPageElement >> toolForExplainer [
	| tool samplePage |
	samplePage := LeSlideshowPageType samplePage.
	tool := samplePage type tool.
	tool
		removeAptitude: (tool aptitude children
				detect: [ :each | each isKindOf: GtPhlowToolDetailAptitude ]).
	tool children
		do: [ :each | 
			each
				margin: (BlInsets
						top: 25
						bottom: 25
						left: 25
						right: 25);
				addAptitude: BrShadowAptitude new
						+ (BrGlamorousButtonExteriorAptitude new
								backgroundPaint: Color white;
								borderPaint: Color transparent) ].
	^ tool
]
