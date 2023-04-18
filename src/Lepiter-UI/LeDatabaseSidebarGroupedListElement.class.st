Class {
	#name : #LeDatabaseSidebarGroupedListElement,
	#superclass : #LeDatabaseElement,
	#instVars : [
		'listElement',
		'navigationModel',
		'groupedItems'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> database [
	^ self navigationModel database
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> databaseViewModel [
	^ self navigationModel databaseViewModel
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> findPageIndexInListElement: aPage [
	| anIndex groups anEntity |
	anIndex := 1.
	groups := self listElement viewModel groups.
	1
		to: groups amountOfEntities
		do: [ :anEntityIndex | 
			anEntity := self listElement viewModel entityAt: anEntityIndex.
			anEntity isHeader
				ifFalse: [ anEntity itemObject = aPage ifTrue: [ ^ anEntityIndex ].
					anIndex := anIndex + 1 ] ].
	^ 0
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> groupedItems [
	^ groupedItems
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> groupedItems: anObject [
	groupedItems := anObject.
	self updateListItems
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> hasSelection [
	^ navigationModel notNil and: [ navigationModel hasPage ]
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> initialize [
	super initialize.
	
	groupedItems := {}.
	
	self initializeListElement.
	self layout: BlLinearLayout vertical.

	self addChild: self listElement as: #list.
	self addAptitude: (BrLayoutResizerAptitude inherit inherit: self listElement).
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> initializeListElement [
	listElement := BrGroupedList new
			margin: (BlInsets top: 5);
			when: BrSelectionChanged
				do: [ :anEvent | self onTreeSelectionChanged: anEvent ];
			headerElementStencil: [ BrLabel new
					beSmallSize;
					aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
					hMatchParent;
					vFitContent;
					margin: (BlInsets top: 10 left: 5) ];
			headerDataBinder: [ :aLabelElement :aGroup | aLabelElement text: aGroup domainObject asString ];
			groups: {};
			matchParent
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> items [
	self groupedItems ifNil: [ ^ {} asAsyncStream ].

	^ (self groupedItems
		collect: [ :aPair | 
			BrGroup new
				stream: aPair value asAsyncStream;
				domainObject: aPair key;
				itemStencil: [ :aNodeType | 
					LePageTitleAndSummaryElement new
						hMatchParent;
						vFitContent;
						addAptitude: BrGlamorousListItemAptitude;
						margin: (BlInsets left: 5) ];
				itemDataBinder: [ :anItemElement :aPage | anItemElement contentViewModel: aPage asContentUIModel ] ])
		asAsyncStream
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> listElement [
	^ listElement
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> listElement: anObject [
	listElement := anObject
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> navigationModel [
	^ navigationModel
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> navigationModel: anObject [
	navigationModel := anObject.
	navigationModel when: LeUIDatabaseNavigationModelChanged send: #onNavigationModelChanged to: self.
	navigationModel when: LeUIPageSelected send: #updateSelection to: self
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> notifyListSelectionChangedTo: aPage [
	| aPageUIModel |
	aPageUIModel := aPage asContentUIModel.
	
	self selection = aPageUIModel ifTrue: [ ^ self ].
	(self selection notNil and: [ self selection pageModel = aPage ])
		ifTrue: [ ^ self ].

	self navigationModel
		announce: (LeUIPageSelectionRequest new page: aPageUIModel)
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> onAddedToSceneGraph [
	super onAddedToSceneGraph.
	self updateSelection.
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> onContentUIModelChanged [
	super onContentUIModelChanged.

	self updateListItems.
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> onNavigationModelChanged [
	self updateListItems.
	self updateSelection
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> onSelectionChanged [
	self updateSelection.
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> onTreeSelectionChanged: aBrSelectionChanged [
	aBrSelectionChanged
		selectedDo: [ :anInterval | 
			self listElement
				selectedEntityDo: [ :aNode | aNode isHeader ifFalse: [ self notifyListSelectionChangedTo: aNode itemObject ] ] ]
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> selection [
	^ navigationModel page
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> selection: aViewModel [
	"Set selected page"

	navigationModel announce: (LeUIPageSelectionRequest new page: aViewModel)
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> updateListItems [
	self listElement
		stream: self items.
		
	self updateSelection.
]

{ #category : #accessing }
LeDatabaseSidebarGroupedListElement >> updateSelection [
	| page index |
	self hasSelection ifFalse: [ ^ self ].

	self selection class = LeContentViewModel ifTrue: [ ^ self ].

	self hasSelection
		ifTrue: [ page := self selection pageModel.
			index := self findPageIndexInListElement: page.
			index > 0
				ifTrue: [ self listElement selectOne: index.
					self listElement scrollToIndex: index ] ]
]
