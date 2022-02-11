Trait {
	#name : #TLeWithPageViewModel,
	#instVars : [
		'pageViewModel'
	],
	#category : 'Lepiter-UI-Page-! Views'
}

{ #category : #'api - page view model' }
TLeWithPageViewModel >> hasPage [
	"Return a true if page view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ pageViewModel notNil
]

{ #category : #'api - page view model' }
TLeWithPageViewModel >> onPageViewModelChanged [
	"Is sent when a new page view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - page view model' }
TLeWithPageViewModel >> pageViewModel [
	"Return a not-null page view model assigned to the receiver element"
	self
		assert: [ pageViewModel notNil ]
		description: [ 'page view model should be initialized' ].

	^ pageViewModel
]

{ #category : #'api - page view model' }
TLeWithPageViewModel >> pageViewModel: aPageViewModel [
	"Set a not-null page view model assigned to the receiver element"
	self
		assert: [ aPageViewModel notNil ]
		description: [ 'page view model must not be nil' ].

	pageViewModel == aPageViewModel 
		ifTrue: [ ^ self ].

	pageViewModel ifNotNil: [ self unsubscribeFromPageViewModel ].
	pageViewModel := aPageViewModel.

	self onPageViewModelChanged.
	self subscribeToPageViewModel
]

{ #category : #'api - page view model' }
TLeWithPageViewModel >> subscribeToPageViewModel [
	"Is sent after a new page view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromPageViewModel if elements subscribe to them"
]

{ #category : #'api - page view model' }
TLeWithPageViewModel >> unsubscribeFromPageViewModel [
	"Is sent before a new page view model is assigned to the element.
	Elements that subscribe to page view model in domain model are required to implement this methods"
]
