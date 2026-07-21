"
I am a {{gtClass:LeSnippetViewModel}} for {{gtClass:LeWordSnippet}}.
I am used by {{gtClass:LeWordSnippetElement}}.

"
Class {
	#name : #LeWordSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#instVars : [
		'word',
		'response',
		'state'
	],
	#category : 'Lepiter-Snippet-Words-UI View Model'
}

{ #category : #visiting }
LeWordSnippetViewModel >> acceptStateVisitor: aVisitor [
	self state accept: aVisitor.
]

{ #category : #'api - state' }
LeWordSnippetViewModel >> editStateFrom: aSource [
	self state: LeWordSnippetViewModelEditState default source: aSource
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> explanation [
	self
		assert: [ self hasSuccessResponse ] 
		description: [ 'Only success response has word explanation' ].
	^ self response explanation
]

{ #category : #'private - accessing' }
LeWordSnippetViewModel >> explanation: anExplanation [
	self explanation: anExplanation source: self
]

{ #category : #'private - accessing' }
LeWordSnippetViewModel >> explanation: anExplanation source: aSource [
	self response: (LeWordSuccess new explanation: anExplanation) source: aSource
]

{ #category : #'api - testing' }
LeWordSnippetViewModel >> hasResponse [
	^ response isNotNil
]

{ #category : #'api - testing' }
LeWordSnippetViewModel >> hasSuccessResponse [
	^ self hasResponse and: [ self response isSuccess ]
]

{ #category : #'api - testing' }
LeWordSnippetViewModel >> ifSuccess: aSuccessBlock otherwise: anOtherwiseBlock [
	self hasSuccessResponse
		ifTrue: aSuccessBlock 
		ifFalse: anOtherwiseBlock
]

{ #category : #initialization }
LeWordSnippetViewModel >> initialize [
	super initialize.
	word := String empty.
	state := LeWordSnippetViewModelEditState default.
]

{ #category : #'private - announcing' }
LeWordSnippetViewModel >> notifyResponseChangedBy: aSource [
	self announce: (LeWordViewModelResponseChangedAnnouncement new
		source: aSource;
		response: self response;
		word: self word)
]

{ #category : #'private - announcing' }
LeWordSnippetViewModel >> notifyStateChangedBy: aSource [
	self announce: (LeWordViewModelStateChangedAnnouncement new
		source: aSource;
		state: state;
		word: self word)
]

{ #category : #'private - announcing' }
LeWordSnippetViewModel >> notifyWordChangedBy: aSource [
	self announce: (LeWordViewModelWordChangedAnnouncement new
		source: aSource;
		word: self word)
]

{ #category : #'private - event handling' }
LeWordSnippetViewModel >> onResponse: aResponse source: aSource [
	self response: aResponse source: aSource.
	self 
		ifSuccess: [
			self response == aResponse ifTrue: [ 
				self snippetModel explanation: self explanation source: self.
				self snippetModel word: self word source: self ] ]
		otherwise: [ "ignore" ]
]

{ #category : #'private - announcement handling' }
LeWordSnippetViewModel >> onSnippetExplanationChanged: anAnnouncement [
	anAnnouncement source == self ifTrue: [ ^ self ].
	self explanation: anAnnouncement explanation source: anAnnouncement source.
]

{ #category : #'api - snippet model' }
LeWordSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	self word: self snippetModel word.
	
	self snippetModel explanation ifNotNil: [ :anExplanation |
		self explanation: anExplanation. ].
	
	self snippetModel weak
		when: LeWordSnippetExplanationChangedAnnouncement 
		send: #onSnippetExplanationChanged: 
		to: self.
	
	self snippetModel weak
		when: LeWordSnippetWordChangedAnnouncement 
		send: #onSnippetWordChanged: 
		to: self
]

{ #category : #'private - announcement handling' }
LeWordSnippetViewModel >> onSnippetWordChanged: anAnnouncement [
	anAnnouncement source == self ifTrue: [ ^ self ].
	self word: anAnnouncement word source: anAnnouncement source.
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> response [
	<return: #LeWordResponse>
	^ response
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> response: aResponse [
	self response: aResponse source: self.
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> response: aResponse source: aSource [
	self 
		assert: [ aResponse notNil ] 
		description: [ 'Word response must be non-nil' ].
	response == aResponse ifTrue: [ ^ self ].
	response := aResponse.
	
	self 
		ifSuccess: [ self state: LeWordSnippetViewModelViewState default source: aSource ]
		otherwise: [ self state: LeWordSnippetViewModelEditState default source: aSource ].
	
	self notifyResponseChangedBy: aSource.
]

{ #category : #'api - communication' }
LeWordSnippetViewModel >> searchExplanation [
	self searchExplanationFrom: nil
]

{ #category : #'api - communication' }
LeWordSnippetViewModel >> searchExplanationFrom: aSource [

	self state: LeWordSnippetViewModelSearchState default source: aSource.

	LeWordClient default
		onResponse: [ :aResponse | self onResponse: aResponse source: aSource ];
		explanation: self word
]

{ #category : #'api - state' }
LeWordSnippetViewModel >> searchStateFrom: aSource [
	self state: LeWordSnippetViewModelSearchState default source: aSource
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> snippetElementClass [
	^ LeWordSnippetElement
]

{ #category : #'private - accessing' }
LeWordSnippetViewModel >> state [
	<return: #LeWordSnippetViewModelState>
	^ state
]

{ #category : #'private - accessing' }
LeWordSnippetViewModel >> state: aState source: aSource [
	self
		assert: [ aState isNotNil ] 
		description: [ 'Word snippet view model state must be non-nil' ].
	self state == aState ifTrue: [ ^ self ].
	
	state := aState.
	
	self notifyStateChangedBy: aSource.
]

{ #category : #'api - snippet model' }
LeWordSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.
 
	self snippetModel weak
		when: LeWordSnippetExplanationChangedAnnouncement 
		send: #onSnippetExplanationChanged: 
		to: self.
	
	self snippetModel weak
		when: LeWordSnippetWordChangedAnnouncement 
		send: #onSnippetWordChanged: 
		to: self
]

{ #category : #'api - snippet model' }
LeWordSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.
	
	self snippetModel unsubscribe: self
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> userMessage [
	^ self hasResponse 
		ifTrue: [ self response userMessage ] 
		ifFalse: [ '' ]
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> word [
	<return: #String>
	^ word
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> word: aString [
	self word: aString source: self.
]

{ #category : #'api - accessing' }
LeWordSnippetViewModel >> word: aString source: aSource [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Word must be non-nil' ].
	word = aString ifTrue: [ ^ self ].
	word := aString.
	self notifyWordChangedBy: aSource.
]
