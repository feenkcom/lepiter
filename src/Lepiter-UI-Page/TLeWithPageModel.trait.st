Trait {
	#name : #TLeWithPageModel,
	#instVars : [
		'pageModel'
	],
	#category : 'Lepiter-UI-Page-! View Models'
}

{ #category : #'api - page model' }
TLeWithPageModel >> hasPage [
	"Return a true if page model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ pageModel notNil
]

{ #category : #'api - page model' }
TLeWithPageModel >> onPageModelChanged [
	"Is sent when a new page model is assigned to the view model"
	
	self explicitRequirement
]

{ #category : #'api - page model' }
TLeWithPageModel >> pageModel [
	"Return a not-null page model assigned to the receiver view model"
	self
		assert: [ pageModel notNil ]
		description: [ 'page model should be initialized' ].

	^ pageModel
]

{ #category : #'api - page model' }
TLeWithPageModel >> pageModel: aPageModel [
	"Set a not-null page domain model assigned to the receiver view model"
	self
		assert: [ aPageModel notNil ]
		description: [ 'page model must not be nil' ].

	pageModel == aPageModel 
		ifTrue: [ ^ self ].

	pageModel ifNotNil: [ self unsubscribeFromPageModel ].
	pageModel := aPageModel.

	self onPageModelChanged.
	self subscribeToPageModel
]

{ #category : #'api - page model' }
TLeWithPageModel >> subscribeToPageModel [
	"Is sent after a new page model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromPageModel if view model subscribes to them"
]

{ #category : #'api - page model' }
TLeWithPageModel >> unsubscribeFromPageModel [
	"Is sent before a new page model is assigned to the view model.
	View models that subscribe to page model are required to implement this methods"
]
