Class {
	#name : #LeHomePageCardListElement,
	#superclass : #LeHomePagesElement,
	#instVars : [
		'listElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #initialization }
LeHomePageCardListElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
LeHomePageCardListElement >> initialize [
	super initialize.
	self initializeListElement.
	
	self addChildFirst: self listElement as: #list.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent;
		hInherit: self listElement;
		vAnyToFitContent: self listElement)
]

{ #category : #initialization }
LeHomePageCardListElement >> initializeListElement [
	| aScrollable |
	listElement := BrSimpleList horizontal
		itemStencil: [ self newPageSummaryCardElement ];
		itemDataBinder: [ :anElement :aPageViewModel :anIndex | anElement pageViewModel: aPageViewModel ].
	aScrollable := listElement childNamed: #scrollable.
	aScrollable margin: aScrollable margin + (BlInsets bottom: 10)
]

{ #category : #'private - accessing' }
LeHomePageCardListElement >> listElement [
	<return: #BrSimpleList>
	^ listElement
]

{ #category : #'private - instance creation' }
LeHomePageCardListElement >> newPageSummaryCardElement [
	^ LePageSummaryCardElement new
		action: [ :aCard | self onPageCardClick: aCard ];
		margin: (BlInsets top: 20 right: 30 bottom: 20 left: 10)
]

{ #category : #'private - hooks' }
LeHomePageCardListElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateElement.
]

{ #category : #'private - event handling' }
LeHomePageCardListElement >> onPageCardClick: aCard [
	| aPageViewModel |
	aPageViewModel := aCard pageViewModel.
	self onPageClick: aPageViewModel
]

{ #category : #'private - updating' }
LeHomePageCardListElement >> updateElement [
	| allPages |
	allPages := self pagesByDateToShow.
	self listElement items: (allPages collect: [ :eachPage | 
		eachPage asContentUIModel ])
]
