"
I display a {{gtClass:LeDatabase}} or {{gtClass:LeLogicalDatabase}} recent pages: {{gtExample:LeUIWorldExamples>>#databaseRecentPageCardsElement|previewExpanded|codeExpanded=false|previewExpanded=true|previewHeight=333}}
1. # Note

{{gtMethod:LeDatabase>>#isPrimary|label=Primary}} {{gtClass:LeDatabase}} instances and {{gtClass:LeLogicalDatabase}} instances display as a first card a card with a today's title.


"
Class {
	#name : #LeHomeRecentPageCardsElement,
	#superclass : #LeHomePagesElement,
	#category : #'Lepiter-Tool-UI'
}

{ #category : #initialization }
LeHomeRecentPageCardsElement >> defaultLayout [
	^ BlFlowLayout new
]

{ #category : #initialization }
LeHomeRecentPageCardsElement >> initialize [
	super initialize.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent).
]

{ #category : #'private - instance creation' }
LeHomeRecentPageCardsElement >> newPageSummaryCardElement [
	^ LePageSummaryCardElement new
		action: [ :aCard | self onPageCardClick: aCard ];
		margin: (BlInsets top: 20 right: 40 bottom: 20 left: 0)
]

{ #category : #'private - event handling' }
LeHomeRecentPageCardsElement >> onAddTodayPageFrom: aCardElement [
	| aNewPage |
	aNewPage := self database pageBuilder todayNote; ensure.
	aCardElement page: aNewPage.
	self onPageCardClick: aCardElement.
]

{ #category : #'private - hooks' }
LeHomeRecentPageCardsElement >> onContentUIModelChanged [
	super onContentUIModelChanged.
	self updateElement.
]

{ #category : #'private - announcement handling' }
LeHomeRecentPageCardsElement >> onDatabaseContentChanged: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [
		self updateElement ])
]

{ #category : #'private - event handling' }
LeHomeRecentPageCardsElement >> onPageCardClick: aCard [ 
	self onPageClick: aCard pageViewModel
]

{ #category : #'private - updating' }
LeHomeRecentPageCardsElement >> removeCardsAfterStarting: anIndex [ 
	| extraCount |
	extraCount := self childrenCount - anIndex.
	extraCount isZero ifTrue: [ ^ self ].
	extraCount timesRepeat: [ 
		self removeChildAt: anIndex ].
]

{ #category : #'private - subscriptions' }
LeHomeRecentPageCardsElement >> subscribeToContent [
	super subscribeToContent.

	self database weak
		when: LeDatabasePageAdded, LeDatabasePageRemoved, LeDatabaseResorted, LePageUnloadAnnouncement 
		send: #onDatabaseContentChanged: 
		to: self
]

{ #category : #'private - subscriptions' }
LeHomeRecentPageCardsElement >> unsubscribeFromContent [
	super unsubscribeFromContent.

	self database unsubscribe: self
]

{ #category : #'private - updating' }
LeHomeRecentPageCardsElement >> updateElement [
	| anAmount aMaxPages aTodayPageUIModel |
	anAmount := 0.
	aTodayPageUIModel := nil.
	self isForTodayNote
		ifTrue: [ self updateTodayPageCard.
			aTodayPageUIModel := (self childAt: 1) pageViewModel.
			anAmount := 1 ].
	aMaxPages := 5.
	self pagesByDateToShow
		do: [ :eachPage | 
			| anIndex |
			anIndex := anAmount + 1.
			anAmount = aMaxPages
				ifTrue: [ ^ self removeCardsAfterStarting: anIndex ].
			eachPage = aTodayPageUIModel pageModel
				ifFalse: [ self updatePageCardAt: anIndex withPage: aTodayPageUIModel.
					anAmount := anAmount + 1 ] ].
	self removeCardsAfterStarting: anAmount + 1
]

{ #category : #'private - updating' }
LeHomeRecentPageCardsElement >> updatePageCardAt: anIndex withPage: aPageViewModel [
	| aCard |
	self childrenCount >= anIndex
		ifTrue: [ aCard := self childAt: anIndex ]
		ifFalse: [ 
			self 
				addChild: (aCard := self newPageSummaryCardElement)
				at: anIndex ].
	aCard pageViewModel: aPageViewModel
]

{ #category : #'private - updating' }
LeHomeRecentPageCardsElement >> updateTodayPageCard [
	| aPageUIModel aCard |
	aPageUIModel := self databaseViewModel pageUIModelFor: self todayPage.
			
	self updatePageCardAt: 1 withPage: aPageUIModel.
	aCard := self childAt: 1.
	
	self 
		assert: [ aCard pageViewModel = aPageUIModel ] 
		description: [ 'Today card element must have today page' ].
		
	aCard action: [ :theCard | 
		self onAddTodayPageFrom: theCard ]
]
