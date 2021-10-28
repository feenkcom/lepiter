Trait {
	#name : #TLeWithLinkReferenceViewModel,
	#instVars : [
		'linkReferenceViewModel'
	],
	#category : 'Lepiter-UI-! Link Reference'
}

{ #category : #'api - link reference view model' }
TLeWithLinkReferenceViewModel >> hasLinkReference [
	"Return a true if linkReference view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ linkReferenceViewModel notNil
]

{ #category : #'api - link reference view model' }
TLeWithLinkReferenceViewModel >> linkReferenceViewModel [
	"Return a not-null linkReference view model assigned to the receiver element"
	self
		assert: [ linkReferenceViewModel notNil ]
		description: [ 'linkReference view model should be initialized' ].

	^ linkReferenceViewModel
]

{ #category : #'api - link reference view model' }
TLeWithLinkReferenceViewModel >> linkReferenceViewModel: aLinkReferenceViewModel [
	"Set a not-null linkReference view model assigned to the receiver element"
	self
		assert: [ aLinkReferenceViewModel notNil ]
		description: [ 'linkReference view model must not be nil' ].

	linkReferenceViewModel == aLinkReferenceViewModel 
		ifTrue: [ ^ self ].

	linkReferenceViewModel ifNotNil: [ self unsubscribeFromLinkReferenceViewModel ].
	linkReferenceViewModel := aLinkReferenceViewModel.

	self onLinkReferenceViewModelChanged.
	self subscribeToLinkReferenceViewModel
]

{ #category : #'api - link reference view model' }
TLeWithLinkReferenceViewModel >> onLinkReferenceViewModelChanged [
	"Is sent when a new linkReference view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - link reference view model' }
TLeWithLinkReferenceViewModel >> subscribeToLinkReferenceViewModel [
	"Is sent after a new linkReference view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromLinkReferenceViewModel if elements subscribe to them"
]

{ #category : #'api - link reference view model' }
TLeWithLinkReferenceViewModel >> unsubscribeFromLinkReferenceViewModel [
	"Is sent before a new linkReference view model is assigned to the element.
	Elements that subscribe to linkReference view model in domain model are required to implement this methods"
]
