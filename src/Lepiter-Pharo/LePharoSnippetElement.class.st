Class {
	#name : #LePharoSnippetElement,
	#superclass : #LeEvaluatedSnippetElement,
	#category : #'Lepiter-Pharo-Snippet'
}

{ #category : #'private - accessing' }
LePharoSnippetElement >> editorElement [
	"Answer the BrEditor used by the receiver"

	^ editorElement
]

{ #category : #testing }
LePharoSnippetElement >> hasText [
	<return: #Boolean>
	^ self text isNotNil and: [ self text isNotEmpty ]
]

{ #category : #initialization }
LePharoSnippetElement >> initialize [
	super initialize.

	self initializeCoderToolbar.

	editorElement := GtSourceCoderEditorElement new.
	editorElement padding: (BlInsets top: 5 left: 7 bottom: 5 right: 0).
	editorElement margin: BlInsets empty.

	self initializeTextEditor.
	
	self registerSpawnBelowHandler.
	self initializeSpawnDownElements
]

{ #category : #initialization }
LePharoSnippetElement >> initializeTextEditor [
	self editor navigator
		whenReachedBoundary: [ :anEvent | self onReachedBoundary: anEvent ].
]

{ #category : #'private - announcement handling' }
LePharoSnippetElement >> onCodeEvaluated: anEvaluatedAnnouncement [
	"We inform a parent page element"
	
	self fireEvent: (LeSnippetEvaluated new
		element: self;
		snippet: self snippet;
		evaluationResult: anEvaluatedAnnouncement evaluationResult)
]

{ #category : #'private - announcement handling' }
LePharoSnippetElement >> onPageChildEvaluated: aLeUIPageChildEvaluationAnnouncement [
	self coder requestStyleSourceText.
]

{ #category : #'api - snippet view model' }
LePharoSnippetElement >> onSnippetViewModelChanged [

	super onSnippetViewModelChanged.
	self snippetViewModel setSelfObjectFromBindings.
]

{ #category : #initialization }
LePharoSnippetElement >> registerSpawnBelowHandler [
	editorElement
		when: GtPhlowObjectToSpawn
		do: [ :aSpawnEvent | 
			aSpawnEvent spawnDestination isSpawnBelow ifTrue: [ 
				aSpawnEvent consumed: true. 
				self fireEvent: (GtPhlowObjectToSpawn new 
					previousSpawnEvent: aSpawnEvent;
					tool: aSpawnEvent tool; 
					sourceElement: aSpawnEvent currentTarget;
					spawnDestination: aSpawnEvent spawnDestination;
					in: [ :anNewEvent | 
						anNewEvent propertyAt: #spawnContainer put: self ];
					yourself) ] ].
]

{ #category : #actions }
LePharoSnippetElement >> spawnBelowObject: anObject [
	| previewElement |
	
	previewElement := self newPreviewElementFor: anObject.	
	self spawnBelowPreviewElement: previewElement
]

{ #category : #'api - snippet view model' }
LePharoSnippetElement >> subscribeToSnippetViewModel [
	super subscribeToSnippetViewModel.

	self snippet weak
		when: LeUIPageChildEvaluationAnnouncement
			send: #onPageChildEvaluated:
			to: self.
			
	self coder announcer weak
		when: GtCoderEvaluationAnnouncement
		send: #onCodeEvaluated:
		to: self
]

{ #category : #'api - snippet view model' }
LePharoSnippetElement >> unsubscribeFromSnippetViewModel [
	super unsubscribeFromSnippetViewModel.

	self snippet unsubscribe: self.
	self coder announcer unsubscribe: self.
]

{ #category : #'private - updating' }
LePharoSnippetElement >> updateCoderUIModel [
	super updateCoderUIModel.

	coderToolbar coderUIModel: self snippetViewModel coderViewModel
]
