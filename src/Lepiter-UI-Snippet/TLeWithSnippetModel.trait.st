Trait {
	#name : #TLeWithSnippetModel,
	#instVars : [
		'snippetModel'
	],
	#category : 'Lepiter-UI-Snippet-! View Models'
}

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> hasSnippet [
	"Return a true if snippet model is assigned to the receiver, false otherwise"
	<return: #Boolean>

	^ snippetModel notNil
]

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> hasSnippetModel [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ snippetModel notNil
]

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> onPostSnippetModelChanged [
	"I am an optional hook method that is sent after #subscribeToSnippetModel.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> onSnippetModelChanged [
	"Is sent when a new snippetModel is assigned to the receiver.
	Note: #onSnippetModelChanged is sent before #subscribeToSnippetModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSnippetModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> snippetModel [
	"Return a not-null snippetModel assigned to the receiver"
	<modelGetter: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ snippetModel notNil ]
		description: [ 'snippetModel should be initialized' ].

	^ snippetModel
]

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> snippetModel: aSnippetModel [
	"Set a not-null snippetModel assigned to the receiver"
	<modelSetter: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSnippetModel notNil ]
		description: [ 'snippetModel must not be nil' ].

	snippetModel == aSnippetModel
		ifTrue: [ ^ self ].

	snippetModel ifNotNil: [ self unsubscribeFromSnippetModel ].
	snippetModel := aSnippetModel.

	self onSnippetModelChanged.
	self subscribeToSnippetModel.
	self onPostSnippetModelChanged
]

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> subscribeToSnippetModel [
	"Is sent after a new snippetModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSnippetModel if the receiver subscribes to them"
	<modelSubscriber: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - snippet model' }
TLeWithSnippetModel >> unsubscribeFromSnippetModel [
	"Is sent before a new snippetModel is assigned to the receiver.
	Objects that subscribe to snippetModel are required to implement this method."
	<modelUnsubscriber: #snippet>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
