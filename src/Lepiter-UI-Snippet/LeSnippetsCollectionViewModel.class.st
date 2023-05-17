Class {
	#name : #LeSnippetsCollectionViewModel,
	#superclass : #LeContentCollectionViewModel,
	#instVars : [
		'snippetsMap',
		'focusedSnippetUIModel',
		'viewModelToScrollTo',
		'sharedSnippetContext'
	],
	#category : #'Lepiter-UI-Snippet-! View Models'
}

{ #category : #testing }
LeSnippetsCollectionViewModel class >> isAbstract [
	^ self = LeSnippetsCollectionViewModel
]

{ #category : #accessing }
LeSnippetsCollectionViewModel >> content: aLeContent [
	super content: aLeContent.

	snippetsMap removeAll.
	self updateChildren
]

{ #category : #'private - instance creation' }
LeSnippetsCollectionViewModel >> createSnippetViewModelFor: aLeSnippet [
	^ aLeSnippet asSnippetViewModel
		snippetsCollection: self;
		sharedSnippetContext: self sharedSnippetContext
]

{ #category : #'api - snippets' }
LeSnippetsCollectionViewModel >> findOrCreateSnippetViewModel: aLeSnippet [
	^ snippetsMap
		at: aLeSnippet
		ifAbsentPut: [ self createSnippetViewModelFor: aLeSnippet ]
]

{ #category : #'api - snippets' }
LeSnippetsCollectionViewModel >> findSnippetViewModel: aLeSnippet [
	^ snippetsMap
		at: aLeSnippet
]

{ #category : #'api - focus' }
LeSnippetsCollectionViewModel >> focusFirstSnippet [
	(focusedSnippetUIModel notNil and: [ self includesContentUIModel: focusedSnippetUIModel ])
		ifTrue: [ ^ self ].
		
	self allChildrenBreadthFirstDo: [ :aFirstUIModel |
		aFirstUIModel focused: true.
		^ self ].
]

{ #category : #'api - focus' }
LeSnippetsCollectionViewModel >> focusSnippetUIModel: aSnippetUIModel [
	(focusedSnippetUIModel notNil
		and: [ focusedSnippetUIModel ~= aSnippetUIModel ])
		ifTrue: [ focusedSnippetUIModel focused: false.
			focusedSnippetUIModel := nil ].
	focusedSnippetUIModel := aSnippetUIModel.
	focusedSnippetUIModel focused: true
]

{ #category : #'gt - extensions' }
LeSnippetsCollectionViewModel >> gtViewSnippetsMapFor: aView [
	<gtView>
	
	^ aView forward 
		title: 'Snippets map';
		priority: 10;
		object: [ snippetsMap ];
		view: #gtItemsFor:
]

{ #category : #private }
LeSnippetsCollectionViewModel >> includesContentUIModel: aContentUIModel [
	self allChildrenBreadthFirstDo: [ :eachUIModel |
		eachUIModel == aContentUIModel
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #'api - testing' }
LeSnippetsCollectionViewModel >> includesSnippetViewModelForSnippet: aLeSnippet [
	^ snippetsMap
		includesKey: aLeSnippet
]

{ #category : #initialization }
LeSnippetsCollectionViewModel >> initialize [
	super initialize.

	sharedSnippetContext := LeSharedSnippetContext new.
	snippetsMap := IdentityDictionary new
]

{ #category : #private }
LeSnippetsCollectionViewModel >> notifyScrollToChanged [
	self announce: (LeSnippetCollectionScrollToChanged new)
]

{ #category : #'api - scrolling' }
LeSnippetsCollectionViewModel >> scrollToViewModel: aLeViewModel [
	self
		assert: [ aLeViewModel notNil ]
		description: [ 'View model to scroll to must not be nil' ].

	viewModelToScrollTo := aLeViewModel.
	self notifyScrollToChanged
]

{ #category : #accessing }
LeSnippetsCollectionViewModel >> sharedSnippetContext [
	^ sharedSnippetContext
]

{ #category : #accessing }
LeSnippetsCollectionViewModel >> sharedSnippetContext: aLeSharedSnippetContext [
	self
		assert: [ aLeSharedSnippetContext notNil ]
		description: [ 'Shared snippet context must not be nil' ].

	sharedSnippetContext := aLeSharedSnippetContext.
	
	self allChildrenBreadthFirstDo: [ :eachSnippetUIModel | eachSnippetUIModel sharedSnippetContext: aLeSharedSnippetContext ]
]

{ #category : #'api - scrolling' }
LeSnippetsCollectionViewModel >> takeViewModelToScrollToIf: aBlock [
	"Evaluate a given block with a pending view model to scroll to
	and if aBlock returns true, forget that view model and consider scrolling request to be fulfilled"

	(aBlock value: viewModelToScrollTo)
		ifTrue: [ viewModelToScrollTo := nil ]
]

{ #category : #'api - focus' }
LeSnippetsCollectionViewModel >> unfocusSnippetUIModel: aSnippetUIModel [
	focusedSnippetUIModel = aSnippetUIModel
		ifTrue: [ focusedSnippetUIModel := nil ].

	aSnippetUIModel focused: false
]

{ #category : #'api - scrolling' }
LeSnippetsCollectionViewModel >> viewModelToScrollTo [
	^ viewModelToScrollTo
]
