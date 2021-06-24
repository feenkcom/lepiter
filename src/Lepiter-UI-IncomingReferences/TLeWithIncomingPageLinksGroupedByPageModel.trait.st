Trait {
	#name : #TLeWithIncomingPageLinksGroupedByPageModel,
	#instVars : [
		'incomingPageLinksGroupedByPageModel'
	],
	#category : #'Lepiter-UI-IncomingReferences-! View Models'
}

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> hasIncomingPageLinksGroupedByPage [
	"Return a true if incomingPageLinksGroupedByPage model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ incomingPageLinksGroupedByPageModel notNil
]

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> incomingPageLinksGroupedByPageModel [
	"Return a not-null incomingPageLinksGroupedByPage model assigned to the receiver view model"
	self
		assert: [ incomingPageLinksGroupedByPageModel notNil ]
		description: [ 'incomingPageLinksGroupedByPage model should be initialized' ].

	^ incomingPageLinksGroupedByPageModel
]

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> incomingPageLinksGroupedByPageModel: aIncomingPageLinksGroupedByPageModel [
	"Set a not-null incomingPageLinksGroupedByPage domain model assigned to the receiver view model"
	self
		assert: [ aIncomingPageLinksGroupedByPageModel notNil ]
		description: [ 'incomingPageLinksGroupedByPage model must not be nil' ].

	incomingPageLinksGroupedByPageModel == aIncomingPageLinksGroupedByPageModel 
		ifTrue: [ ^ self ].

	incomingPageLinksGroupedByPageModel ifNotNil: [ self unsubscribeFromIncomingPageLinksGroupedByPageModel ].
	incomingPageLinksGroupedByPageModel := aIncomingPageLinksGroupedByPageModel.

	self onIncomingPageLinksGroupedByPageModelChanged.
	self subscribeToIncomingPageLinksGroupedByPageModel
]

{ #category : #'api - accessing' }
TLeWithIncomingPageLinksGroupedByPageModel >> latestEditDateAndTime [

	^ self latestEditTime time
]

{ #category : #'api - accessing' }
TLeWithIncomingPageLinksGroupedByPageModel >> latestEditTime [ 

	^ incomingPageLinksGroupedByPageModel latestEditTime
]

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> onIncomingPageLinksGroupedByPageModelChanged [
	"Is sent when a new incomingPageLinksGroupedByPage model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> referencedPage [
	"Return a referenced page"
	<return: #LePage>
	
	^ self incomingPageLinksGroupedByPageModel referencedPage
]

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> referencingPage [
	"Return a referencing page"
	<return: #LePage>
	
	^ self incomingPageLinksGroupedByPageModel referencingPage
]

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> subscribeToIncomingPageLinksGroupedByPageModel [
	"Is sent after a new incomingPageLinksGroupedByPage model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromIncomingPageLinksGroupedByPageModel if view model subscribes to them"
]

{ #category : #'api - incoming page links grouped by page model' }
TLeWithIncomingPageLinksGroupedByPageModel >> unsubscribeFromIncomingPageLinksGroupedByPageModel [
	"Is sent before a new incomingPageLinksGroupedByPage model is assigned to the view model.
	View models that subscribe to incomingPageLinksGroupedByPage model are required to implement this methods"
]
