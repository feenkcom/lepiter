Class {
	#name : #LeInspectorPlaygroundElement,
	#superclass : #GtInspectorObjectElement,
	#instVars : [
		'page',
		'pageElement',
		'resizerElement',
		'widthStrategy',
		'playgroundPageStrategy',
		'databasesRegistry'
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

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> currentPlaygroundPageStrategy [
	^ playgroundPageStrategy ifNil: [
		self object gtPlaygroundPageStrategy ]
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> databasesRegistry [
	^ databasesRegistry ifNil: [
			LeDatabasesRegistry default ]
]

{ #category : #accessing }
LeInspectorPlaygroundElement >> databasesRegistry: aDatabasesRegistry [
	databasesRegistry := aDatabasesRegistry
]

{ #category : #'api - visibility' }
LeInspectorPlaygroundElement >> expand [
	widthStrategy adjustHeightFor: self.
]

{ #category : #initialization }
LeInspectorPlaygroundElement >> initialize [
	super initialize.
	widthStrategy := BrResizerElementLength exact: self minimumHeight.
	
	self initializePageElement.
	
	self layout: (BlLinearLayout vertical cellSpacing: 5).
	self constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].

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
	self
		addAptitude: (BrGlamorousWithVerticalResizerAptitude new beTop
		resizerDo: [ :theResizer | resizerElement := theResizer ]).
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
LeInspectorPlaygroundElement >> locateDefaultPlaygroundDatabase [
	^ self databasesRegistry currentLoadedDefaultLogicalDatabase playgroundDB
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> locatePageForObject [
	| currentPage |
	
	currentPage := self currentPlaygroundPageStrategy
		ensurePlaygroundPageInDatabase: self locateDefaultPlaygroundDatabase
		forObject: self object.
	
	^ currentPage
]

{ #category : #'private - accessing' }
LeInspectorPlaygroundElement >> minimumHeight [
	^ 5
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

{ #category : #accessing }
LeInspectorPlaygroundElement >> playgroundPageStrategy: aPlaygroundPageStrategy [
	playgroundPageStrategy := aPlaygroundPageStrategy
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
