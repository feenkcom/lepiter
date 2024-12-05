Class {
	#name : #LeGitHubModelElement,
	#superclass : #BlElement,
	#traits : 'TBrLayoutResizable',
	#classTraits : 'TBrLayoutResizable classTrait',
	#instVars : [
		'model',
		'snippetViewModel'
	],
	#category : #'Lepiter-GitHub-UI Model Elements'
}

{ #category : #'private - asserting' }
LeGitHubModelElement >> assertModel: aLeGitHubIdentity [
	self 
		assert: [ aLeGitHubIdentity isNotNil ] 
		description: [ 'GitHub Identity model must be non-nil' ].
]

{ #category : #initialization }
LeGitHubModelElement >> defaultLayout [
	^ BlLinearLayout vertical
]

{ #category : #'gt-extension' }
LeGitHubModelElement >> gtLiveFor: aView [
	<gtView>
	^ (super gtLiveFor: aView)
		actionButtonIcon: BrGlamorousIcons inspect 
			label: 'Model' 
			tooltip: 'Inspect model object' 
			action: [ :aButton | aButton phlow spawnObject: self model ]
]

{ #category : #'private - testing' }
LeGitHubModelElement >> hasErrorResponse [
	^ self model hasErrorResponse
]

{ #category : #'private - testing' }
LeGitHubModelElement >> hasSuccessResponse [
	^ self model hasSuccessResponse
]

{ #category : #'api - accessing' }
LeGitHubModelElement >> model [
	<return: #LeGitHubModel>
	^ model
]

{ #category : #'api - accessing' }
LeGitHubModelElement >> model: aLeGitHubIdentity [
	self assertModel: aLeGitHubIdentity.
	model = aLeGitHubIdentity ifTrue: [ ^ self ].
	self unsubscribeFromModel.
	model := aLeGitHubIdentity.
	self subscribeToModel.
	self onModelChanged.
]

{ #category : #'private - hooks' }
LeGitHubModelElement >> onModelChanged [
	self updateElement.
]

{ #category : #'private - announcement handling' }
LeGitHubModelElement >> onResponeChanged: anAnnouncement [
	anAnnouncement source = self ifTrue: [ ^ self ].
	self enqueueTask: (BlTaskAction new action: [
		self updateElement ])
]

{ #category : #accessing }
LeGitHubModelElement >> snippetViewModel [
	^ snippetViewModel
]

{ #category : #accessing }
LeGitHubModelElement >> snippetViewModel: anObject [
	snippetViewModel := anObject
]

{ #category : #'private - subscriptions' }
LeGitHubModelElement >> subscribeToModel [
	self model weak
		when: LeGitHubModelResponseChangedAnnouncement 
		send: #onResponeChanged: 
		to: self
]

{ #category : #'private - subscriptions' }
LeGitHubModelElement >> unsubscribeFromModel [
	self model ifNil: [ ^ self ].
	self model unsubscribe: self.
]

{ #category : #'private - updating' }
LeGitHubModelElement >> updateElement [
	
]
