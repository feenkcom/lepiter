"
I am an abstract class.
I provide basic {{gtMethod:LeContentElement>>#content:|label=content}} accessors, model {{gtMethod:LeContentElement>>#subscribeToContent|label=subscriptons}}, and model {{gtMethod:LeContentElement>>#onContentUIModelChanged|label=instance changes}}.
See my {{gtClass:LeContentElement|expanded|show=#gtSubclassesFor:}} for concrete implementations:

"
Class {
	#name : #LeContentElement,
	#superclass : #LeElement,
	#instVars : [
		'contentUIModel'
	],
	#category : #'Lepiter-UI-! Content Elements'
}

{ #category : #'api - accessing' }
LeContentElement >> content [
	<return: #LePage or: #LeSnippet>

	^ self contentUIModel content
]

{ #category : #'api - accessing' }
LeContentElement >> content: aPageOrBlock [
	"Create and set a new default ui model for a given page or block"

	self contentUIModel: aPageOrBlock asContentUIModel
]

{ #category : #accessing }
LeContentElement >> contentHolder [
	self deprecated: 'Use #contentUIModel instead'.

	^ contentUIModel
]

{ #category : #'api - ui model' }
LeContentElement >> contentUIModel [
	<return: #LeContentViewModel>

	self
		assert: [ contentUIModel notNil ]
		description: [ 'UI model should be initialized' ].

	^ contentUIModel
]

{ #category : #'api - ui model' }
LeContentElement >> contentUIModel: aLeContentUIModel [
	"Quietly set the receivers UI Model (without performing #onContentUIModelChanged).
	Answer a boolean indicating whether the content holder was actually changed"
	<return: #Boolean>
	self assertUIProcess.

	self
		assert: [ aLeContentUIModel isKindOf: LeContentViewModel ]
		description: [ 'Should be a UI model' ].

	contentUIModel = aLeContentUIModel 
		ifTrue: [ ^ self ].

	contentUIModel ifNotNil: [ self unsubscribeFromContent ].
	contentUIModel := aLeContentUIModel.
	self onContentUIModelChanged.
	self subscribeToContent
]

{ #category : #'gt-extension' }
LeContentElement >> gtLiveFor: aView [
	<gtView>
	^ (super gtLiveFor: aView)
		actionButtonIcon: BrGlamorousIcons inspect 
			label: 'Model' 
			tooltip: 'Inspect model object' 
			action: [ :aButton | aButton phlow spawnObject: self content ]
]

{ #category : #'api - testing' }
LeContentElement >> hasContent [
	<return: #Boolean>

	^ contentUIModel notNil
]

{ #category : #'api - ui model' }
LeContentElement >> onContentUIModelChanged [
	"Subclasses can react to content (page and block) changes"
	
	self assertUIProcess.
]

{ #category : #accessing }
LeContentElement >> selectAndScrollTo: aPage [
	self flag: 'TODO define this method to be able scroll to a specific block'
]

{ #category : #'private - subscriptions' }
LeContentElement >> subscribeToContent [
	"Subclasses can subscribe to what they are interested in.
	All subscriptions to the model should be weak.
	Announcements may happen in a non-UI process."
]

{ #category : #'private - subscriptions' }
LeContentElement >> unsubscribeFromContent [
	"Subclasses can unsubscribe from what they are interested in"
]
