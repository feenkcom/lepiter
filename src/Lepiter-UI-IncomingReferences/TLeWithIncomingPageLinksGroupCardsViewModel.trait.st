Trait {
	#name : #TLeWithIncomingPageLinksGroupCardsViewModel,
	#instVars : [
		'incomingPageLinksGroupCardsViewModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #'api - incoming page links group cards view model' }
TLeWithIncomingPageLinksGroupCardsViewModel >> hasIncomingPageLinksGroupCards [
	"Return a true if incomingPageLinksGroupCards view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ incomingPageLinksGroupCardsViewModel notNil
]

{ #category : #'api - incoming page links group cards view model' }
TLeWithIncomingPageLinksGroupCardsViewModel >> incomingPageLinksGroupCardsViewModel [
	"Return a not-null incomingPageLinksGroupCards view model assigned to the receiver element"
	self
		assert: [ incomingPageLinksGroupCardsViewModel notNil ]
		description: [ 'incomingPageLinksGroupCards view model should be initialized' ].

	^ incomingPageLinksGroupCardsViewModel
]

{ #category : #'api - incoming page links group cards view model' }
TLeWithIncomingPageLinksGroupCardsViewModel >> incomingPageLinksGroupCardsViewModel: aIncomingPageLinksGroupCardsViewModel [
	"Set a not-null incomingPageLinksGroupCards view model assigned to the receiver element"
	self
		assert: [ aIncomingPageLinksGroupCardsViewModel notNil ]
		description: [ 'incomingPageLinksGroupCards view model must not be nil' ].

	incomingPageLinksGroupCardsViewModel == aIncomingPageLinksGroupCardsViewModel 
		ifTrue: [ ^ self ].

	incomingPageLinksGroupCardsViewModel ifNotNil: [ self unsubscribeFromIncomingPageLinksGroupCardsViewModel ].
	incomingPageLinksGroupCardsViewModel := aIncomingPageLinksGroupCardsViewModel.

	self onIncomingPageLinksGroupCardsViewModelChanged.
	self subscribeToIncomingPageLinksGroupCardsViewModel
]

{ #category : #'api - incoming page links group cards view model' }
TLeWithIncomingPageLinksGroupCardsViewModel >> onIncomingPageLinksGroupCardsViewModelChanged [
	"Is sent when a new incomingPageLinksGroupCards view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - incoming page links group cards view model' }
TLeWithIncomingPageLinksGroupCardsViewModel >> subscribeToIncomingPageLinksGroupCardsViewModel [
	"Is sent after a new incomingPageLinksGroupCards view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromIncomingPageLinksGroupCardsViewModel if elements subscribe to them"
]

{ #category : #'api - incoming page links group cards view model' }
TLeWithIncomingPageLinksGroupCardsViewModel >> unsubscribeFromIncomingPageLinksGroupCardsViewModel [
	"Is sent before a new incomingPageLinksGroupCards view model is assigned to the element.
	Elements that subscribe to incomingPageLinksGroupCards view model in domain model are required to implement this methods"
]
