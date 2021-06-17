Class {
	#name : #LeHomeCommonDatabaseElement,
	#superclass : #LeHomeBasicElement,
	#instVars : [
		'headerElement',
		'recentPageCardsElement'
	],
	#category : #'Lepiter-Tool-UI'
}

{ #category : #initialization }
LeHomeCommonDatabaseElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterLeft
]

{ #category : #'private - accessing' }
LeHomeCommonDatabaseElement >> headerElement [
	<return: #LeHomeCommonDatabaseHeaderElement>
	^ headerElement
]

{ #category : #defaults }
LeHomeCommonDatabaseElement >> headerElementClass [
	^ LeHomeCommonDatabaseHeaderElement
]

{ #category : #initialization }
LeHomeCommonDatabaseElement >> initialize [
	super initialize.
	self initializeHeaderElement.
	self initializeRecentPageCardsElement.
	
	self addChild: self headerElement as: #header.
	self addChild: self recentPageCardsElement as: #cards.
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent; 
		hInherit: self headerElement;
		vAnyToFitContent: self headerElement; 
		hInherit: self recentPageCardsElement;
		vAnyToFitContent: self recentPageCardsElement).
		
	self 
		margin: (BlInsets bottom: 20)
]

{ #category : #initialization }
LeHomeCommonDatabaseElement >> initializeHeaderElement [
	headerElement := self headerElementClass new
]

{ #category : #initialization }
LeHomeCommonDatabaseElement >> initializeRecentPageCardsElement [
	recentPageCardsElement := LeHomePageCardListElement new.
	recentPageCardsElement margin: recentPageCardsElement margin + (BlInsets right: 5)
]

{ #category : #'private - hooks' }
LeHomeCommonDatabaseElement >> onContentUIModelChanged [
	super onContentUIModelChanged.
	self headerElement databaseViewModel: self databaseViewModel.
	self recentPageCardsElement databaseViewModel: self databaseViewModel.
]

{ #category : #callbacks }
LeHomeCommonDatabaseElement >> onDatabasePageAdded: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateRecentPagesCardsElement ]).
]

{ #category : #callbacks }
LeHomeCommonDatabaseElement >> onDatatabasePageRemoved: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateRecentPagesCardsElement ]).
]

{ #category : #'private - accessing' }
LeHomeCommonDatabaseElement >> recentPageCardsElement [
	<return: #LeHomePagesElement>
	^ recentPageCardsElement
]

{ #category : #'private - subscriptions' }
LeHomeCommonDatabaseElement >> subscribeToContent [
	super subscribeToContent.
	self database weak 
		when: LeDatabasePageAdded  
			send: #onDatabasePageAdded: 
			to: self;
		when: LeDatabasePageRemoved
			send: #onDatatabasePageRemoved:
			to: self;
		when: LePageUnloadAnnouncement 
			send: #onDatatabasePageRemoved:
			to: self
]

{ #category : #'private - subscriptions' }
LeHomeCommonDatabaseElement >> unsubscribeFromContent [
	super unsubscribeFromContent.

	self database unsubscribe: self
]

{ #category : #'private - updating' }
LeHomeCommonDatabaseElement >> updateRecentPagesCardsElement [
	self recentPageCardsElement updateElement
]
