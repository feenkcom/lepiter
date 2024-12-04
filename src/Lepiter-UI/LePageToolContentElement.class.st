Class {
	#name : #LePageToolContentElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement',
		'headerElement',
		'toolbarBuilder'
	],
	#category : #'Lepiter-UI-! Tool - Page'
}

{ #category : #initialization }
LePageToolContentElement >> buildToolbar [
	toolbarBuilder
		pageElement: self;
		frame: self headerElement;
		titleElement: self titleElement;
		build
]

{ #category : #'private - accessing' }
LePageToolContentElement >> headerElement [
	^ headerElement
]

{ #category : #initialization }
LePageToolContentElement >> initialize [
	super initialize.
	
	self layout: BlLinearLayout vertical.
	self matchParent.
	
	self initializeHeaderElement.
	self initializeTitleElement.
	self initializeListeners.
	self registerSpawnBelowHandler.
	
	self addChild: self headerElement as: #header.

	self withTitleAndButtons.
	self buildToolbar
]

{ #category : #initialization }
LePageToolContentElement >> initializeHeaderElement [
	headerElement := BrHorizontalPane new alignCenter.
	headerElement
		clipChildren: false;
		margin: (BlInsets
				top: 5
				left: 8
				bottom: 10
				right: 0)
]

{ #category : #initialization }
LePageToolContentElement >> initializeListeners [
	self when: LeSnippetEvaluated do: [ :anEvent | self onSnippetEvaluated: anEvent ].
]

{ #category : #initialization }
LePageToolContentElement >> initializeTitleElement [
	titleElement := LePageEditableTitleElement new.
]

{ #category : #'private - notifying' }
LePageToolContentElement >> notifyContentChanged [
	self dispatchEvent: (LeContentChanged new content: self pageViewModel pageModel)
]

{ #category : #'api - page view model' }
LePageToolContentElement >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self titleElement pageViewModel: self pageViewModel.
	self buildToolbar.
	self notifyContentChanged
]

{ #category : #'private - event handling' }
LePageToolContentElement >> onSnippetEvaluated: anEvent [
	self pageViewModel pageModel notifier tree announce: (LeUIPageChildEvaluationAnnouncement new
		evaluatedBlock: anEvent snippet;
		evaluatedBlockElement: anEvent element;
		topParentElement: self;
		evaluationResult: anEvent evaluationResult)
]

{ #category : #initialization }
LePageToolContentElement >> registerSpawnBelowHandler [
	self
		when: GtPhlowObjectToSpawn
		do: [ :aSpawnEvent | 
			aSpawnEvent spawnDestination isSpawnBelow ifTrue: [ 
				aSpawnEvent consumed: true. 
				(aSpawnEvent spawnContainer)
					spawnBelowTool: aSpawnEvent tool ] ]
]

{ #category : #'selection - handling' }
LePageToolContentElement >> selectTitle [
	titleElement requestFocus
]

{ #category : #'api - accessing' }
LePageToolContentElement >> selectionTransformation: aBlock [
]

{ #category : #'private - accessing' }
LePageToolContentElement >> titleElement [
	^ titleElement
]

{ #category : #'api - initialization' }
LePageToolContentElement >> withEmptyHeader [
	"Do not display any toolbar neither the title."
	toolbarBuilder := LePageEmptyHeaderBuilder new
]

{ #category : #'api - initialization' }
LePageToolContentElement >> withTitleAndButtons [
	toolbarBuilder := LePageHeaderWithTitleAndButtonsBuilder new
]

{ #category : #'api - initialization' }
LePageToolContentElement >> withTitleOnly [
	"Do not display other toolbar items, e.g., buttons.
	Display only a page title."
	toolbarBuilder := LePageHeaderWithTitleOnlyBuilder new
]
