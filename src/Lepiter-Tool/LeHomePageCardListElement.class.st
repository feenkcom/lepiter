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

{ #category : #'private - testing' }
LeHomePageCardListElement >> hasTodayPage [
	^ self database 
		pageNamed: (LeDailyNoteTitleBuilder new 
			title: Date today)
		ifPresent: [ true ]
		ifAbsent: [ false ].
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
	
	"We know that there might be a daily note page that is not part of the database.
	It does not happen for other pages, we therefore create a new daily note."
	aPageViewModel database isDatabase ifFalse: [ 
		| aNewPage |
		aNewPage := self database pageBuilder todayNote; ensure.
		aPageViewModel := self databaseViewModel pageUIModelFor: aNewPage.
		aCard pageViewModel: aPageViewModel ].
	
	self onPageClick: aPageViewModel
]

{ #category : #'private - updating' }
LeHomePageCardListElement >> updateElement [
	| allPages |
	allPages := self pagesByDateToShow copy.
	
	self isForTodayNote ifTrue: [ 
		| aTodayPage |
		aTodayPage := self todayPage.
		aTodayPage database isDatabase ifFalse: [ 
			allPages add: aTodayPage ]
 	].

	self listElement items: (allPages collect: [ :eachPage | eachPage asContentUIModel ])
]
