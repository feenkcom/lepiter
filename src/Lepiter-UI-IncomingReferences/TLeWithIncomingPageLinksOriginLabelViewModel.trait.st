Trait {
	#name : #TLeWithIncomingPageLinksOriginLabelViewModel,
	#instVars : [
		'incomingPageLinksOriginLabelViewModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #'api - incoming page links origin label view model' }
TLeWithIncomingPageLinksOriginLabelViewModel >> hasIncomingPageLinksOriginLabel [
	"Return a true if incomingPageLinksOriginLabel view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ incomingPageLinksOriginLabelViewModel notNil
]

{ #category : #'api - incoming page links origin label view model' }
TLeWithIncomingPageLinksOriginLabelViewModel >> incomingPageLinksOriginLabelViewModel [
	"Return a not-null incomingPageLinksOriginLabel view model assigned to the receiver element"
	self
		assert: [ incomingPageLinksOriginLabelViewModel notNil ]
		description: [ 'incomingPageLinksOriginLabel view model should be initialized' ].

	^ incomingPageLinksOriginLabelViewModel
]

{ #category : #'api - incoming page links origin label view model' }
TLeWithIncomingPageLinksOriginLabelViewModel >> incomingPageLinksOriginLabelViewModel: aIncomingPageLinksOriginLabelViewModel [
	"Set a not-null incomingPageLinksOriginLabel view model assigned to the receiver element"
	self
		assert: [ aIncomingPageLinksOriginLabelViewModel notNil ]
		description: [ 'incomingPageLinksOriginLabel view model must not be nil' ].

	incomingPageLinksOriginLabelViewModel == aIncomingPageLinksOriginLabelViewModel 
		ifTrue: [ ^ self ].

	incomingPageLinksOriginLabelViewModel ifNotNil: [ self unsubscribeFromIncomingPageLinksOriginLabelViewModel ].
	incomingPageLinksOriginLabelViewModel := aIncomingPageLinksOriginLabelViewModel.

	self onIncomingPageLinksOriginLabelViewModelChanged.
	self subscribeToIncomingPageLinksOriginLabelViewModel
]

{ #category : #'api - incoming page links origin label view model' }
TLeWithIncomingPageLinksOriginLabelViewModel >> onIncomingPageLinksOriginLabelViewModelChanged [
	"Is sent when a new incomingPageLinksOriginLabel view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - incoming page links origin label view model' }
TLeWithIncomingPageLinksOriginLabelViewModel >> subscribeToIncomingPageLinksOriginLabelViewModel [
	"Is sent after a new incomingPageLinksOriginLabel view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromIncomingPageLinksOriginLabelViewModel if elements subscribe to them"
]

{ #category : #'api - incoming page links origin label view model' }
TLeWithIncomingPageLinksOriginLabelViewModel >> unsubscribeFromIncomingPageLinksOriginLabelViewModel [
	"Is sent before a new incomingPageLinksOriginLabel view model is assigned to the element.
	Elements that subscribe to incomingPageLinksOriginLabel view model in domain model are required to implement this methods"
]
