Trait {
	#name : #TLeWithIncomingPageLinksGroupModel,
	#instVars : [
		'incomingPageLinksGroupModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #'api - incoming page links group model' }
TLeWithIncomingPageLinksGroupModel >> hasIncomingPageLinksGroup [
	"Return a true if incomingPageLinksGroup model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ incomingPageLinksGroupModel notNil
]

{ #category : #'api - incoming page links group model' }
TLeWithIncomingPageLinksGroupModel >> incomingPageLinksGroupModel [
	"Return a not-null incomingPageLinksGroup model assigned to the receiver view model"
	self
		assert: [ incomingPageLinksGroupModel notNil ]
		description: [ 'incomingPageLinksGroup model should be initialized' ].

	^ incomingPageLinksGroupModel
]

{ #category : #'api - incoming page links group model' }
TLeWithIncomingPageLinksGroupModel >> incomingPageLinksGroupModel: aIncomingPageLinksGroupModel [
	"Set a not-null incomingPageLinksGroup domain model assigned to the receiver view model"
	self
		assert: [ aIncomingPageLinksGroupModel notNil ]
		description: [ 'incomingPageLinksGroup model must not be nil' ].

	incomingPageLinksGroupModel == aIncomingPageLinksGroupModel 
		ifTrue: [ ^ self ].

	incomingPageLinksGroupModel ifNotNil: [ self unsubscribeFromIncomingPageLinksGroupModel ].
	incomingPageLinksGroupModel := aIncomingPageLinksGroupModel.

	self onIncomingPageLinksGroupModelChanged.
	self subscribeToIncomingPageLinksGroupModel
]

{ #category : #'api - incoming page links group model' }
TLeWithIncomingPageLinksGroupModel >> onIncomingPageLinksGroupModelChanged [
	"Is sent when a new incomingPageLinksGroup model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - incoming page links group model' }
TLeWithIncomingPageLinksGroupModel >> referencedPage [
	"Return a referenced page"
	<return: #LePage>
	
	^ self incomingPageLinksGroupModel referencedPage
]

{ #category : #'api - incoming page links group model' }
TLeWithIncomingPageLinksGroupModel >> subscribeToIncomingPageLinksGroupModel [
	"Is sent after a new incomingPageLinksGroup model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromIncomingPageLinksGroupModel if view model subscribes to them"
]

{ #category : #'api - incoming page links group model' }
TLeWithIncomingPageLinksGroupModel >> unsubscribeFromIncomingPageLinksGroupModel [
	"Is sent before a new incomingPageLinksGroup model is assigned to the view model.
	View models that subscribe to incomingPageLinksGroup model are required to implement this methods"
]
