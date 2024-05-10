Class {
	#name : #LeConnectorPageContainerElement,
	#superclass : #BlElement,
	#traits : 'TGtPhlowToolDetailAdjustable + TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TGtPhlowToolDetailAdjustable classTrait + TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'page',
		'connectorElement',
		'innerContainer',
		'pageElement'
	],
	#category : #'Lepiter-UI-Connector'
}

{ #category : #'as yet unclassified' }
LeConnectorPageContainerElement >> actOnDetailedVolume [	
	self constraintsDo: [ :c | c doNotAccountTransformation ].
	
	innerContainer allowChildrenMouseEvents.
]

{ #category : #'as yet unclassified' }
LeConnectorPageContainerElement >> actOnNormalVolume [	
	self constraintsDo: [ :c | c accountTransformation ].

	innerContainer preventChildrenMouseEvents.
]

{ #category : #accessing }
LeConnectorPageContainerElement >> connectorElement [
	^ connectorElement
]

{ #category : #accessing }
LeConnectorPageContainerElement >> connectorElement: aConnectorElement [
	connectorElement := aConnectorElement
]

{ #category : #'api - zooming' }
LeConnectorPageContainerElement >> decreaseZoomLevel [
	self addAnimation: ((BlTransformAnimation scale: 0.25) absolute duration: self zoomAnimationDuration)
]

{ #category : #'api - zooming' }
LeConnectorPageContainerElement >> increaseZoomLevel [
	self addAnimation: ((BlTransformAnimation scale: 1) absolute duration: self zoomAnimationDuration)
]

{ #category : #initialization }
LeConnectorPageContainerElement >> initialize [ 	
	| aCloseButton aRightResizer aBottomResizer |
	super initialize.

	self layout: BlLinearLayout horizontal.

	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c accountTransformation ].
	self clipChildren: false.

	innerContainer := BlElement new.
	innerContainer
		clipChildren: false;
		size: 400@400;
		padding: (BlInsets all: 5);
		addAptitude: BrGlamorousFocusableShadowAptitude new;
		background: Color white;
		layout: BlLinearLayout new.

	self
		when: BlClickEvent  
		do: [ self toggleVolume ].
	
	aRightResizer := BlElement new
		aptitude: BrGlamorousResizerRightBarAptitude new;
		background: BrGlamorousColors editorBorderColor;
		constraintsDo: [ :c | 
			c margin: (BlInsets right: 0). 
			c horizontal exact: 3.];
		addEventHandler: (BlResizerRightListener new 
			resizeTarget: innerContainer; 
			minimumExtent: 75@0).
	aBottomResizer := BlElement new
		aptitude: BrGlamorousResizerBottomBarAptitude new;
		background: BrGlamorousColors editorBorderColor;
		constraintsDo: [ :c | 
			c margin: (BlInsets bottom: 0). 
			c vertical exact: 3.];
		addEventHandler: (BlResizerBottomListener new 
			resizeTarget: innerContainer; 
			minimumExtent: 0@75).
	aCloseButton := GtInspectorRoundButtonStencil new asElement
		icon: (BrPlusIconStencil close asElement);
		constraintsDo: [ :c |
			c ignoreByLayout.
			c margin: (BlInsets top: -10 left: 0 bottom: 0 right: -10).
			c ignored horizontal alignRight.
			c ignored vertical alignTop ];
		action: [ :e |  
			e 
				allParentsDetect: [:aParent | aParent isKindOf: LeConnectorPageContainerElement] 
				ifFound: [:aParent | self connectorElement removeChild: aParent ] 
				ifNone: [] ].

	pageElement := LeConnectorPageElement new.
	pageElement matchParent.
	pageElement when: GtPhlowObjectToSpawn do: [ :spawnEvent | 
			| isInspect |
			isInspect := spawnEvent target userData includesKey: #isInspectButton.
			isInspect ifFalse: [
				self connectorElement addEntity: spawnEvent object tools anyOne object.
				spawnEvent consumed: true ] ].

	innerContainer addChild: pageElement.
	innerContainer addChild: aRightResizer.
	innerContainer addChild: aBottomResizer.
	innerContainer addChild: aCloseButton.

	self addChild: innerContainer.

	self addAptitude: (GtPhlowToolDetailAptitude new
		normal: [ :aStyle | aStyle do: [ self actOnNormalVolume ] ];
		detailed: [ :aStyle | aStyle do: [ self actOnDetailedVolume ] ]).
]

{ #category : #'api - page view model' }
LeConnectorPageContainerElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self updateContent
]

{ #category : #accessing }
LeConnectorPageContainerElement >> page [
	^ page
]

{ #category : #accessing }
LeConnectorPageContainerElement >> page: aPage [
	page := aPage.
	self updateContent.
]

{ #category : #accessing }
LeConnectorPageContainerElement >> pageElement [
	^ pageElement
]

{ #category : #accessing }
LeConnectorPageContainerElement >> toggleVolume [
	self isDetailedLevel ifFalse: [ 
		self beDetailedLevel.
		(self connectorElement entityElements copyWithout: self) do: [ :aContainer |
			aContainer beNormalLevel ] ].
]

{ #category : #updating }
LeConnectorPageContainerElement >> updateContent [

	self pageElement pageViewModel: self page asContentUIModel
]

{ #category : #'api - zooming' }
LeConnectorPageContainerElement >> zoomAnimationDuration [
	^ 300 milliSeconds
]
