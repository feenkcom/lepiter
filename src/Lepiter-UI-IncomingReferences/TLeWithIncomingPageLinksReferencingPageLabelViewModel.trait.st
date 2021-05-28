Trait {
	#name : #TLeWithIncomingPageLinksReferencingPageLabelViewModel,
	#instVars : [
		'incomingPageLinksReferencingPageLabelViewModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! Views'
}

{ #category : #'api - incoming page links referencing page label view model' }
TLeWithIncomingPageLinksReferencingPageLabelViewModel >> hasIncomingPageLinksReferencingPageLabel [
	"Return a true if incomingPageLinksReferencingPageLabel view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ incomingPageLinksReferencingPageLabelViewModel notNil
]

{ #category : #'api - incoming page links referencing page label view model' }
TLeWithIncomingPageLinksReferencingPageLabelViewModel >> incomingPageLinksReferencingPageLabelViewModel [
	"Return a not-null incomingPageLinksReferencingPageLabel view model assigned to the receiver element"
	self
		assert: [ incomingPageLinksReferencingPageLabelViewModel notNil ]
		description: [ 'incomingPageLinksReferencingPageLabel view model should be initialized' ].

	^ incomingPageLinksReferencingPageLabelViewModel
]

{ #category : #'api - incoming page links referencing page label view model' }
TLeWithIncomingPageLinksReferencingPageLabelViewModel >> incomingPageLinksReferencingPageLabelViewModel: aIncomingPageLinksReferencingPageLabelViewModel [
	"Set a not-null incomingPageLinksReferencingPageLabel view model assigned to the receiver element"
	self
		assert: [ aIncomingPageLinksReferencingPageLabelViewModel notNil ]
		description: [ 'incomingPageLinksReferencingPageLabel view model must not be nil' ].

	incomingPageLinksReferencingPageLabelViewModel == aIncomingPageLinksReferencingPageLabelViewModel 
		ifTrue: [ ^ self ].

	incomingPageLinksReferencingPageLabelViewModel ifNotNil: [ self unsubscribeFromIncomingPageLinksReferencingPageLabelViewModel ].
	incomingPageLinksReferencingPageLabelViewModel := aIncomingPageLinksReferencingPageLabelViewModel.

	self onIncomingPageLinksReferencingPageLabelViewModelChanged.
	self subscribeToIncomingPageLinksReferencingPageLabelViewModel
]

{ #category : #'api - incoming page links referencing page label view model' }
TLeWithIncomingPageLinksReferencingPageLabelViewModel >> onIncomingPageLinksReferencingPageLabelViewModelChanged [
	"Is sent when a new incomingPageLinksReferencingPageLabel view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - incoming page links referencing page label view model' }
TLeWithIncomingPageLinksReferencingPageLabelViewModel >> subscribeToIncomingPageLinksReferencingPageLabelViewModel [
	"Is sent after a new incomingPageLinksReferencingPageLabel view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromIncomingPageLinksReferencingPageLabelViewModel if elements subscribe to them"
]

{ #category : #'api - incoming page links referencing page label view model' }
TLeWithIncomingPageLinksReferencingPageLabelViewModel >> unsubscribeFromIncomingPageLinksReferencingPageLabelViewModel [
	"Is sent before a new incomingPageLinksReferencingPageLabel view model is assigned to the element.
	Elements that subscribe to incomingPageLinksReferencingPageLabel view model in domain model are required to implement this methods"
]
