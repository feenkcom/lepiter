Class {
	#name : #LePageToolContentElement,
	#superclass : #BlElement,
	#traits : 'TLeWithPageViewModel + TBrLayoutResizable',
	#classTraits : 'TLeWithPageViewModel classTrait + TBrLayoutResizable classTrait',
	#instVars : [
		'titleElement',
		'headerElement'
	],
	#category : 'Lepiter-UI-! Tool - Page'
}

{ #category : #'private - accessing' }
LePageToolContentElement >> headerElement [
	<return: #LeToolbarElement>
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

	self withTitleAndInspectButton
]

{ #category : #initialization }
LePageToolContentElement >> initializeHeaderElement [
	headerElement := LeToolbarElement new.
	headerElement margin: (BlInsets left: 3)
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
				(aSpawnEvent propertyAt: #spawnContainer)
					spawnBelowTool: aSpawnEvent tool ] ]
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
	(LePageEmptyHeaderBuilder new
		pageElement: self;
		toolbarElement: self headerElement;
		titleElement: self titleElement;
		build)
]

{ #category : #'api - initialization' }
LePageToolContentElement >> withTitleAndAllActionButtons [
	"Install all toolbar items (including the title)"
	(LePageHeaderWithAllItemsBuilder new
		pageElement: self;
		toolbarElement: self headerElement;
		titleElement: self titleElement;
		build)
]

{ #category : #'api - initialization' }
LePageToolContentElement >> withTitleAndInspectButton [
	(LePageHeaderWithTitleAndInspectButtonBuilder new
		pageElement: self;
		toolbarElement: self headerElement;
		titleElement: self titleElement;
		build)
]

{ #category : #'api - initialization' }
LePageToolContentElement >> withTitleAndRemoveAction [
	"Do not display other toolbar items, e.g., buttons.
	Display only a page title."
	(LePageHeaderWithTitleAndRemoveActionBuilder new
		pageElement: self;
		toolbarElement: self headerElement;
		titleElement: self titleElement;
		build)
]

{ #category : #'api - initialization' }
LePageToolContentElement >> withTitleOnly [
	"Do not display other toolbar items, e.g., buttons.
	Display only a page title."
	(LePageHeaderWithTitleOnlyBuilder new
		pageElement: self;
		toolbarElement: self headerElement;
		titleElement: self titleElement;
		build)
]
