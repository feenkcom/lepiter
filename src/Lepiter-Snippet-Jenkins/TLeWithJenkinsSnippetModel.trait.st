Trait {
	#name : #TLeWithJenkinsSnippetModel,
	#instVars : [
		'jenkinsSnippetModel'
	],
	#category : #'Lepiter-Snippet-Jenkins-View-Model'
}

{ #category : #'api - jenkins snippet model' }
TLeWithJenkinsSnippetModel >> hasJenkinsSnippet [
	"Return a true if jenkinsSnippet model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ jenkinsSnippetModel notNil
]

{ #category : #'api - jenkins snippet model' }
TLeWithJenkinsSnippetModel >> jenkinsSnippetModel [
	"Return a not-null jenkinsSnippet model assigned to the receiver view model"
	self
		assert: [ jenkinsSnippetModel notNil ]
		description: [ 'jenkinsSnippet model should be initialized' ].

	^ jenkinsSnippetModel
]

{ #category : #'api - jenkins snippet model' }
TLeWithJenkinsSnippetModel >> jenkinsSnippetModel: aJenkinsSnippetModel [
	"Set a not-null jenkinsSnippet domain model assigned to the receiver view model"
	self
		assert: [ aJenkinsSnippetModel notNil ]
		description: [ 'jenkinsSnippet model must not be nil' ].

	jenkinsSnippetModel == aJenkinsSnippetModel 
		ifTrue: [ ^ self ].

	jenkinsSnippetModel ifNotNil: [ self unsubscribeFromJenkinsSnippetModel ].
	jenkinsSnippetModel := aJenkinsSnippetModel.

	self onJenkinsSnippetModelChanged.
	self subscribeToJenkinsSnippetModel
]

{ #category : #'api - jenkins snippet model' }
TLeWithJenkinsSnippetModel >> onJenkinsSnippetModelChanged [
	"Is sent when a new jenkinsSnippet model is assigned to the view model"
	
	"self explicitRequirement"
]

{ #category : #'api - jenkins snippet model' }
TLeWithJenkinsSnippetModel >> subscribeToJenkinsSnippetModel [
	"Is sent after a new jenkinsSnippet model is assigned to the view model.
	It is required to unsubscribe from the domain model by implementing
	#unsubscribeFromJenkinsSnippetModel if view model subscribes to them"
]

{ #category : #'api - jenkins snippet model' }
TLeWithJenkinsSnippetModel >> unsubscribeFromJenkinsSnippetModel [
	"Is sent before a new jenkinsSnippet model is assigned to the view model.
	View models that subscribe to jenkinsSnippet model are required to implement this methods"
]
