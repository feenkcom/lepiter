Class {
	#name : #LeInspectorPlaygroundElement,
	#superclass : #GtInspectorObjectElement,
	#instVars : [
		'page',
		'pageElement',
		'resizerElement',
		'widthStrategy'
	],
	#category : #'Lepiter-Playground'
}

{ #category : #'private - visibility' }
LeInspectorPlaygroundElement >> beExact: aNumber [
	widthStrategy := BrResizerElementLength exact: aNumber.
]

{ #category : #'api - visibility' }
LeInspectorPlaygroundElement >> collapse [
	self height: self minimumHeight.
]

{ #category : #initialization }
LeInspectorPlaygroundElement >> defaultPlaygroundHeight [
	^ 200
]

{ #category : #'api - visibility' }
LeInspectorPlaygroundElement >> expand [
	widthStrategy adjustHeightFor: self.
]

{ #category : #initialization }
LeInspectorPlaygroundElement >> initialize [
	super initialize.

	widthStrategy := BrResizerElementLength exact: self defaultPlaygroundHeight.
	
	self initializePageElement.
	
	self layout: (BlLinearLayout vertical cellSpacing: 5).
	self constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	self clipChildren: false.

	"resizer is added in this method"
	self initializeResizerElement.
	self background: self theme default backdropColor.

	self addChild: (BrVerticalPane new 
		matchParent;
		margin: (BlInsets all: 10);
		background: self theme default contentBackgroundColor;
		aptitude: BrShadowAptitude;
		addChild: self pageElement as: #page).
]

{ #category : #initialization }
LeInspectorPlaygroundElement >> initializePageElement [
	pageElement := LePageToolContentTreeElement new 
		withEmptyHeader;
		beInSingleCompositionLayer;
		matchParent
]

{ #category : #initialization }
LeInspectorPlaygroundElement >> initializeResizerElement [
	resizerElement := BrResizer new
		aptitude: BrGlamorousHandleBarResizerAptitude;
		elevation: (BlRelativeElevation elevation: 1000);
		constraintsDo: [ :c | c ignoreByLayout ];
		beTop;
		target: self.

	self addChild: resizerElement.

	self resizerElement
		when: BlResizerResizedEvent
			do: [ :anEvent | self onResizerResized: anEvent ];
		when: BlDoubleClickEvent
			do: [ :anEvent | self onResizerDoubleClick: anEvent ]
]

{ #category : #'private - testing' }
LeInspectorPlaygroundElement >> isCollapsed [
	<return: #Boolean>
	^ self height <= self minimumHeight
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> locatePageForObject [
	| database currentPage |
	database := LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase
		playgroundDB.
	currentPage := database
		at: self object class name
		ifPresent: [ :aPage | aPage ]
		ifAbsent: [ page := LePage pharoClassName: self object class name.
			page addSnippet: LePharoSnippet new.
			database addPage: page.
			page ]
		forPageType: LePharoClassPageType.
	^ currentPage
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> minimumHeight [
	^ 8
]

{ #category : #'private - hooks' }
LeInspectorPlaygroundElement >> onObjectHolderChanged [
	super onObjectHolderChanged.
	self updatePage.
]

{ #category : #'private - event handling' }
LeInspectorPlaygroundElement >> onResizerDoubleClick: anEvent [
	anEvent consumed: true.
	self isCollapsed
		ifTrue: [ self expand ]
		ifFalse: [ self collapse ]
]

{ #category : #'private - event handling' }
LeInspectorPlaygroundElement >> onResizerResized: anEvent [
	self beExact: anEvent extent y
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> page [
	<return: #LePage>
	^ page
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> pageElement [
	<return: #LePageToolContentTreeElement>
	^ pageElement
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> resizerElement [
	^ resizerElement
]

{ #category : #'private - updating' }
LeInspectorPlaygroundElement >> updatePage [

	page := self locatePageForObject.
	self pageElement pageViewModel: page asContentUIModel.
	self pageElement pageViewModel receiver: self object
]

{ #category : #'api - updating' }
LeInspectorPlaygroundElement >> updatePlayPage [
	"Compatibility with ${method:GtInspector>>updateElement}$"
	self updatePage.
]
