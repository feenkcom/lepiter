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
	editorElement editor 
		addEventHandler: (LeEditorReachedBorderEventHandler new 
			snippetElement: self);
		ensureNoUndoRedoShortcuts.
	
	self registerSpawnBelowHandler.
	self initializeSpawnDownElements
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

{ #category : #initialization }
LePharoSnippetElement >> registerSpawnBelowHandler [
	editorElement
		when: GtPhlowObjectToSpawn
		do: [ :aSpawnEvent | 
			aSpawnEvent spawnDestination isSpawnBelow ifTrue: [ 
				self fireEvent: (GtPhlowObjectToSpawn new
					fromPreviousSpawnEvent: aSpawnEvent;
					spawnContainer: self)  ] ].
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
