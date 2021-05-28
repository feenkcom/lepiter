Trait {
	#name : #TLeWithIncomingPageLinkCardViewModel,
	#instVars : [
		'incomingPageLinkCardViewModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #'api - incoming page link card view model' }
TLeWithIncomingPageLinkCardViewModel >> hasIncomingPageLinkCard [
	"Return a true if incomingPageLinkCard view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ incomingPageLinkCardViewModel notNil
]

{ #category : #'api - incoming page link card view model' }
TLeWithIncomingPageLinkCardViewModel >> incomingPageLinkCardViewModel [
	"Return a not-null incomingPageLinkCard view model assigned to the receiver element"
	self
		assert: [ incomingPageLinkCardViewModel notNil ]
		description: [ 'incomingPageLinkCard view model should be initialized' ].

	^ incomingPageLinkCardViewModel
]

{ #category : #'api - incoming page link card view model' }
TLeWithIncomingPageLinkCardViewModel >> incomingPageLinkCardViewModel: aIncomingPageLinkCardViewModel [
	"Set a not-null incomingPageLinkCard view model assigned to the receiver element"
	self
		assert: [ aIncomingPageLinkCardViewModel notNil ]
		description: [ 'incomingPageLinkCard view model must not be nil' ].

	incomingPageLinkCardViewModel == aIncomingPageLinkCardViewModel 
		ifTrue: [ ^ self ].

	incomingPageLinkCardViewModel ifNotNil: [ self unsubscribeFromIncomingPageLinkCardViewModel ].
	incomingPageLinkCardViewModel := aIncomingPageLinkCardViewModel.

	self onIncomingPageLinkCardViewModelChanged.
	self subscribeToIncomingPageLinkCardViewModel
]

{ #category : #'api - incoming page link card view model' }
TLeWithIncomingPageLinkCardViewModel >> onIncomingPageLinkCardViewModelChanged [
	"Is sent when a new incomingPageLinkCard view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - incoming page link card view model' }
TLeWithIncomingPageLinkCardViewModel >> subscribeToIncomingPageLinkCardViewModel [
	"Is sent after a new incomingPageLinkCard view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromIncomingPageLinkCardViewModel if elements subscribe to them"
]

{ #category : #'api - incoming page link card view model' }
TLeWithIncomingPageLinkCardViewModel >> unsubscribeFromIncomingPageLinkCardViewModel [
	"Is sent before a new incomingPageLinkCard view model is assigned to the element.
	Elements that subscribe to incomingPageLinkCard view model in domain model are required to implement this methods"
]
