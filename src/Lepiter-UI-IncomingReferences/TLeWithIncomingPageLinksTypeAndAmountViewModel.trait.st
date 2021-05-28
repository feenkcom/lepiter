Trait {
	#name : #TLeWithIncomingPageLinksTypeAndAmountViewModel,
	#instVars : [
		'incomingPageLinksTypeAndAmountViewModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #'api - incoming page links type and amount view model' }
TLeWithIncomingPageLinksTypeAndAmountViewModel >> hasIncomingPageLinksTypeAndAmount [
	"Return a true if incomingPageLinksTypeAndAmount view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ incomingPageLinksTypeAndAmountViewModel notNil
]

{ #category : #'api - incoming page links type and amount view model' }
TLeWithIncomingPageLinksTypeAndAmountViewModel >> incomingPageLinksTypeAndAmountViewModel [
	"Return a not-null incomingPageLinksTypeAndAmount view model assigned to the receiver element"
	self
		assert: [ incomingPageLinksTypeAndAmountViewModel notNil ]
		description: [ 'incomingPageLinksTypeAndAmount view model should be initialized' ].

	^ incomingPageLinksTypeAndAmountViewModel
]

{ #category : #'api - incoming page links type and amount view model' }
TLeWithIncomingPageLinksTypeAndAmountViewModel >> incomingPageLinksTypeAndAmountViewModel: aIncomingPageLinksTypeAndAmountViewModel [
	"Set a not-null incomingPageLinksTypeAndAmount view model assigned to the receiver element"
	self
		assert: [ aIncomingPageLinksTypeAndAmountViewModel notNil ]
		description: [ 'incomingPageLinksTypeAndAmount view model must not be nil' ].

	incomingPageLinksTypeAndAmountViewModel == aIncomingPageLinksTypeAndAmountViewModel 
		ifTrue: [ ^ self ].

	incomingPageLinksTypeAndAmountViewModel ifNotNil: [ self unsubscribeFromIncomingPageLinksTypeAndAmountViewModel ].
	incomingPageLinksTypeAndAmountViewModel := aIncomingPageLinksTypeAndAmountViewModel.

	self onIncomingPageLinksTypeAndAmountViewModelChanged.
	self subscribeToIncomingPageLinksTypeAndAmountViewModel
]

{ #category : #'api - incoming page links type and amount view model' }
TLeWithIncomingPageLinksTypeAndAmountViewModel >> onIncomingPageLinksTypeAndAmountViewModelChanged [
	"Is sent when a new incomingPageLinksTypeAndAmount view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - incoming page links type and amount view model' }
TLeWithIncomingPageLinksTypeAndAmountViewModel >> subscribeToIncomingPageLinksTypeAndAmountViewModel [
	"Is sent after a new incomingPageLinksTypeAndAmount view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromIncomingPageLinksTypeAndAmountViewModel if elements subscribe to them"
]

{ #category : #'api - incoming page links type and amount view model' }
TLeWithIncomingPageLinksTypeAndAmountViewModel >> unsubscribeFromIncomingPageLinksTypeAndAmountViewModel [
	"Is sent before a new incomingPageLinksTypeAndAmount view model is assigned to the element.
	Elements that subscribe to incomingPageLinksTypeAndAmount view model in domain model are required to implement this methods"
]
