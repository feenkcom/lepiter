Trait {
	#name : #TLeWithSnippetViewModel,
	#instVars : [
		'snippetViewModel'
	],
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #'gt - extensions' }
TLeWithSnippetViewModel >> gtSnippetModelProperty [
	<gtInspectorElementOverview>
	self hasSnippetViewModel ifFalse: [ ^ nil ].
	self snippetViewModel hasSnippetModel ifFalse: [ ^ nil ].

	^ GtInspectorElementOverviewProperty new
		label: 'Snippet model';
		object: [ self snippetViewModel snippetModel ]
]

{ #category : #'gt - extensions' }
TLeWithSnippetViewModel >> gtSnippetViewModelProperty [
	<gtInspectorElementOverview>
	self hasSnippetViewModel ifFalse: [ ^ nil ].

	^ GtInspectorElementOverviewProperty new
		label: 'Snippet view model';
		object: [ self snippetViewModel ]
]

{ #category : #'api - snippet view model' }
TLeWithSnippetViewModel >> hasSnippetViewModel [
	"Return a true if snippet view model is assigned to the receiver element, false otherwise"
	<return: #Boolean>

	^ snippetViewModel notNil
]

{ #category : #'api - snippet view model' }
TLeWithSnippetViewModel >> onPostSnippetViewModelChanged [
	"I am an optional hook method that is sent after #subscribeToSnippetViewModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
]

{ #category : #'api - snippet view model' }
TLeWithSnippetViewModel >> onSnippetViewModelChanged [
	"Is sent when a new snippet view model is assigned to the element.
	Note: #onSnippetViewModelChanged is sent before #subscribeToSnippetViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSnippetViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"

	self explicitRequirement
]

{ #category : #'api - snippet view model' }
TLeWithSnippetViewModel >> snippetViewModel [
	"Return a not-null snippet view model assigned to the receiver element"
	self
		assert: [ snippetViewModel notNil ]
		description: [ 'snippet view model should be initialized' ].

	^ snippetViewModel
]

{ #category : #'api - snippet view model' }
TLeWithSnippetViewModel >> snippetViewModel: aSnippetViewModel [
	"Set a not-null snippet view model assigned to the receiver element"
	self
		assert: [ aSnippetViewModel notNil ]
		description: [ 'snippet view model must not be nil' ].

	snippetViewModel == aSnippetViewModel 
		ifTrue: [ ^ self ].

	snippetViewModel ifNotNil: [ self unsubscribeFromSnippetViewModel ].
	snippetViewModel := aSnippetViewModel.

	self onSnippetViewModelChanged.
	self subscribeToSnippetViewModel.
	self onPostSnippetViewModelChanged
]

{ #category : #'api - snippet view model' }
TLeWithSnippetViewModel >> subscribeToSnippetViewModel [
	"Is sent after a new snippet view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromSnippetViewModel if elements subscribe to them"
]

{ #category : #'api - snippet view model' }
TLeWithSnippetViewModel >> unsubscribeFromSnippetViewModel [
	"Is sent before a new snippet view model is assigned to the element.
	Elements that subscribe to snippet view model in domain model are required to implement this methods."
]
