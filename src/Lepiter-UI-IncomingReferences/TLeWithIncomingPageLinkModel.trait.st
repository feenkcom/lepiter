Trait {
	#name : #TLeWithIncomingPageLinkModel,
	#instVars : [
		'incomingPageLinkModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #'api - incoming page link model' }
TLeWithIncomingPageLinkModel >> hasIncomingPageLink [
	"Return a true if incomingPageLink model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ incomingPageLinkModel notNil
]

{ #category : #'api - incoming page link model' }
TLeWithIncomingPageLinkModel >> incomingPageLinkModel [
	"Return a not-null incomingPageLink model assigned to the receiver view model"
	self
		assert: [ incomingPageLinkModel notNil ]
		description: [ 'incomingPageLink model should be initialized' ].

	^ incomingPageLinkModel
]

{ #category : #'api - incoming page link model' }
TLeWithIncomingPageLinkModel >> incomingPageLinkModel: aIncomingPageLinkModel [
	"Set a not-null incomingPageLink domain model assigned to the receiver view model"
	self
		assert: [ aIncomingPageLinkModel notNil ]
		description: [ 'incomingPageLink model must not be nil' ].

	incomingPageLinkModel == aIncomingPageLinkModel 
		ifTrue: [ ^ self ].

	incomingPageLinkModel ifNotNil: [ self unsubscribeFromIncomingPageLinkModel ].
	incomingPageLinkModel := aIncomingPageLinkModel.

	self onIncomingPageLinkModelChanged.
	self subscribeToIncomingPageLinkModel
]

{ #category : #'api - incoming page link model' }
TLeWithIncomingPageLinkModel >> onIncomingPageLinkModelChanged [
	"Is sent when a new incomingPageLink model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #accessing }
TLeWithIncomingPageLinkModel >> referencedPage [
	^ self incomingPageLinkModel referencedPage
]

{ #category : #'api - incoming page link model' }
TLeWithIncomingPageLinkModel >> subscribeToIncomingPageLinkModel [
	"Is sent after a new incomingPageLink model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromIncomingPageLinkModel if view model subscribes to them"
]

{ #category : #'api - incoming page link model' }
TLeWithIncomingPageLinkModel >> unsubscribeFromIncomingPageLinkModel [
	"Is sent before a new incomingPageLink model is assigned to the view model.
	View models that subscribe to incomingPageLink model are required to implement this methods"
]
