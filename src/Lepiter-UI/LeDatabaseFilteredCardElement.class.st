Class {
	#name : #LeDatabaseFilteredCardElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'labelElement',
		'cardsElement',
		'filtersElement',
		'initialPages',
		'appliedFilter',
		'filters'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #accessing }
LeDatabaseFilteredCardElement >> appliedFilter: aLeAppliedFilter [
	appliedFilter := aLeAppliedFilter.
	self updateLabel.
	self databaseViewModel: appliedFilter database asContentUIModel
]

{ #category : #'private - event handling' }
LeDatabaseFilteredCardElement >> buildFilters: anEvent [
	filters := OrderedCollection new.
	anEvent filterElement
		filtersDo:
			[ :descriptor :value | filters add: (descriptor newFilterWithValue: value) ].
	self updateCards
]

{ #category : #'private - accessing' }
LeDatabaseFilteredCardElement >> cardsElement [
	^ cardsElement
]

{ #category : #'private - accessing' }
LeDatabaseFilteredCardElement >> filteredPages [
	^ (initialPages
		select: [ :each | filters allSatisfy: [ :filter | filter matches: each ] ])
			sorted: [ :a :b | a latestEditTime > b latestEditTime ]
]

{ #category : #'private - accessing' }
LeDatabaseFilteredCardElement >> filtersElement [
	<return: #GtFiltersElement>
	^ filtersElement
]

{ #category : #initialization }
LeDatabaseFilteredCardElement >> initialize [
	super initialize.
	filters := #().
	initialPages := #().
	self initializeLabelElement.
	self initializeFiltersElement.
	self initializeCardsElement.
	
	self layout: (BlLinearLayout vertical cellSpacing: 5).
	self padding: (BlInsets left: 5).

	self addChild: self labelElement as: #label.
	self addChild: self filtersElement as: #filters.	
	self addChild: self cardsElement as: #cards.
	
	self addAptitude: (BrLayoutResizerAptitude new inherit: self cardsElement)
]

{ #category : #initialization }
LeDatabaseFilteredCardElement >> initializeCardsElement [
	cardsElement := BlElement new
		layout: BlFlowLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ];
		padding: (BlInsets all: 0);
		margin: (BlInsets left: 2)
]

{ #category : #initialization }
LeDatabaseFilteredCardElement >> initializeFiltersElement [
	filtersElement := GtFiltersElement new.
	filtersElement margin: (BlInsets left: 0).
	filtersElement
		when: GtFiltersChangedEvent
		do: [ :event | self buildFilters: event ].
]

{ #category : #initialization }
LeDatabaseFilteredCardElement >> initializeLabelElement [
	labelElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new glamorousRegularFontAndSize foreground: Color gray);
		hMatchParent;
		margin: (BlInsets left: 2);
		vFitContent
]

{ #category : #'private - accessing' }
LeDatabaseFilteredCardElement >> labelElement [
	^ labelElement
]

{ #category : #'private - hooks' }
LeDatabaseFilteredCardElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateInitialPages.
	self updateFilterDescriptors.
	self updateCards
]

{ #category : #'private - updating' }
LeDatabaseFilteredCardElement >> updateCards [
	self cardsElement removeChildren.
	self filteredPages
		do:
			[ :each | self cardsElement addChild: (
			LePageCardElement new
				pageViewModel: (self databaseViewModel pageUIModelFor: each);
				exact: 200@200;
				margin: (BlInsets top: 0 left: 0 bottom: 15 right: 15)) ]
]

{ #category : #'private - updating' }
LeDatabaseFilteredCardElement >> updateFilterDescriptors [
	filtersElement descriptors: (
		LeFilter allFilterDescriptorsFor: self database)
]

{ #category : #'private - updating' }
LeDatabaseFilteredCardElement >> updateInitialPages [
	initialPages := appliedFilter pages
]

{ #category : #'private - updating' }
LeDatabaseFilteredCardElement >> updateLabel [
	self labelElement text: appliedFilter filter printString
]
