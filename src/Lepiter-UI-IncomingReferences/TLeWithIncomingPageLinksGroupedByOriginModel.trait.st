Trait {
	#name : #TLeWithIncomingPageLinksGroupedByOriginModel,
	#instVars : [
		'incomingPageLinksGroupedByOriginModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #'api - incoming page links grouped by origin model' }
TLeWithIncomingPageLinksGroupedByOriginModel >> hasIncomingPageLinksGroupedByOrigin [
	"Return a true if incomingPageLinksGroupedByOrigin model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ incomingPageLinksGroupedByOriginModel notNil
]

{ #category : #'api - incoming page links grouped by origin model' }
TLeWithIncomingPageLinksGroupedByOriginModel >> incomingPageLinksGroupedByOriginModel [
	"Return a not-null incomingPageLinksGroupedByOrigin model assigned to the receiver view model"
	self
		assert: [ incomingPageLinksGroupedByOriginModel notNil ]
		description: [ 'incomingPageLinksGroupedByOrigin model should be initialized' ].

	^ incomingPageLinksGroupedByOriginModel
]

{ #category : #'api - incoming page links grouped by origin model' }
TLeWithIncomingPageLinksGroupedByOriginModel >> incomingPageLinksGroupedByOriginModel: aIncomingPageLinksGroupedByOriginModel [
	"Set a not-null incomingPageLinksGroupedByOrigin domain model assigned to the receiver view model"
	self
		assert: [ aIncomingPageLinksGroupedByOriginModel notNil ]
		description: [ 'incomingPageLinksGroupedByOrigin model must not be nil' ].

	incomingPageLinksGroupedByOriginModel == aIncomingPageLinksGroupedByOriginModel 
		ifTrue: [ ^ self ].

	incomingPageLinksGroupedByOriginModel ifNotNil: [ self unsubscribeFromIncomingPageLinksGroupedByOriginModel ].
	incomingPageLinksGroupedByOriginModel := aIncomingPageLinksGroupedByOriginModel.

	self onIncomingPageLinksGroupedByOriginModelChanged.
	self subscribeToIncomingPageLinksGroupedByOriginModel
]

{ #category : #'api - incoming page links grouped by origin model' }
TLeWithIncomingPageLinksGroupedByOriginModel >> onIncomingPageLinksGroupedByOriginModelChanged [
	"Is sent when a new incomingPageLinksGroupedByOrigin model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - incoming page links grouped by origin model' }
TLeWithIncomingPageLinksGroupedByOriginModel >> referencedPage [
	"Return a referenced page"
	<return: #LePage>
	
	^ self incomingPageLinksGroupedByOriginModel referencedPage
]

{ #category : #'api - incoming page links grouped by origin model' }
TLeWithIncomingPageLinksGroupedByOriginModel >> subscribeToIncomingPageLinksGroupedByOriginModel [
	"Is sent after a new incomingPageLinksGroupedByOrigin model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromIncomingPageLinksGroupedByOriginModel if view model subscribes to them"
]

{ #category : #'api - incoming page links grouped by origin model' }
TLeWithIncomingPageLinksGroupedByOriginModel >> unsubscribeFromIncomingPageLinksGroupedByOriginModel [
	"Is sent before a new incomingPageLinksGroupedByOrigin model is assigned to the view model.
	View models that subscribe to incomingPageLinksGroupedByOrigin model are required to implement this methods"
]
