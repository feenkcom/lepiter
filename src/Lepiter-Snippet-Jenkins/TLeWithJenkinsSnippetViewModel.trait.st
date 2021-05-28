Trait {
	#name : #TLeWithJenkinsSnippetViewModel,
	#instVars : [
		'jenkinsSnippetViewModel'
	],
	#category : #'Lepiter-Snippet-Jenkins-View-Element'
}

{ #category : #'api - jenkins snippet view model' }
TLeWithJenkinsSnippetViewModel >> hasJenkinsSnippet [
	"Return a true if jenkinsSnippet view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ jenkinsSnippetViewModel notNil
]

{ #category : #'api - jenkins snippet view model' }
TLeWithJenkinsSnippetViewModel >> jenkinsSnippetViewModel [
	"Return a not-null jenkinsSnippet view model assigned to the receiver element"
	self
		assert: [ jenkinsSnippetViewModel notNil ]
		description: [ 'jenkinsSnippet view model should be initialized' ].

	^ jenkinsSnippetViewModel
]

{ #category : #'api - jenkins snippet view model' }
TLeWithJenkinsSnippetViewModel >> jenkinsSnippetViewModel: aJenkinsSnippetViewModel [
	"Set a not-null jenkinsSnippet view model assigned to the receiver element"
	self
		assert: [ aJenkinsSnippetViewModel notNil ]
		description: [ 'jenkinsSnippet view model must not be nil' ].

	jenkinsSnippetViewModel == aJenkinsSnippetViewModel 
		ifTrue: [ ^ self ].

	jenkinsSnippetViewModel ifNotNil: [ self unsubscribeFromJenkinsSnippetViewModel ].
	jenkinsSnippetViewModel := aJenkinsSnippetViewModel.

	self onJenkinsSnippetViewModelChanged.
	self subscribeToJenkinsSnippetViewModel
]

{ #category : #'api - jenkins snippet view model' }
TLeWithJenkinsSnippetViewModel >> onJenkinsSnippetViewModelChanged [
	"Is sent when a new jenkinsSnippet view model is assigned to the element"
	
	self explicitRequirement
]

{ #category : #'api - jenkins snippet view model' }
TLeWithJenkinsSnippetViewModel >> subscribeToJenkinsSnippetViewModel [
	"Is sent after a new jenkinsSnippet view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromJenkinsSnippetViewModel if elements subscribe to them"
]

{ #category : #'api - jenkins snippet view model' }
TLeWithJenkinsSnippetViewModel >> unsubscribeFromJenkinsSnippetViewModel [
	"Is sent before a new jenkinsSnippet view model is assigned to the element.
	Elements that subscribe to jenkinsSnippet view model in domain model are required to implement this methods"
]
