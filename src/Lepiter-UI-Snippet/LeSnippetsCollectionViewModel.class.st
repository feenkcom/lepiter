Class {
	#name : #LeSnippetsCollectionViewModel,
	#superclass : #LeContentCollectionViewModel,
	#instVars : [
		'snippetsMap',
		'snippetBindings',
		'focusedSnippetUIModel',
		'viewModelToScrollTo'
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
LeSnippetsCollectionViewModel >> createSnippetUIModelFor: aLeSnippet [
	^ aLeSnippet asSnippetViewModel
		snippetsCollection: self;
		snippetBindings: self snippetBindings
]

{ #category : #'api - snippets' }
LeSnippetsCollectionViewModel >> findOrCreateSnippetViewModel: aLeSnippet [
	^ snippetsMap
		at: aLeSnippet
		ifAbsentPut: [ self createSnippetUIModelFor: aLeSnippet ]
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

{ #category : #private }
LeSnippetsCollectionViewModel >> includesContentUIModel: aContentUIModel [
	self allChildrenBreadthFirstDo: [ :eachUIModel |
		eachUIModel == aContentUIModel
			ifTrue: [ ^ true ] ].

	^ false
]

{ #category : #initialization }
LeSnippetsCollectionViewModel >> initialize [
	super initialize.

	snippetBindings := GtSnippetBindings new.
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
LeSnippetsCollectionViewModel >> snippetBindings [
	^ snippetBindings
]

{ #category : #accessing }
LeSnippetsCollectionViewModel >> snippetBindings: aGtSnippetBindings [
	self
		assert: [ aGtSnippetBindings notNil ]
		description: [ 'Snippet bindings must not be nil' ].

	snippetBindings := aGtSnippetBindings.
	
	self allChildrenBreadthFirstDo: [ :eachSnippetUIModel | eachSnippetUIModel snippetBindings: aGtSnippetBindings ]
]

{ #category : #'api - scrolling' }
LeSnippetsCollectionViewModel >> takeViewModelToScrollTo [
	| aViewModelToScrollTo |

	aViewModelToScrollTo := viewModelToScrollTo.
	viewModelToScrollTo := nil.
	^ aViewModelToScrollTo
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
