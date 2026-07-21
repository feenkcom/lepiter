"
I search for a word explanation using <https://dictionaryapi.dev>.
See {{gtMethod:LeWordSnippetViewModel>>#searchExplanationFrom:|expanded=true}} for my usage:


"
Class {
	#name : #LeWordClient,
	#superclass : #LeWordBasicClient,
	#instVars : [
		'word',
		'onResponse',
		'response'
	],
	#category : 'Lepiter-Snippet-Words-Client'
}

{ #category : #'api - factory' }
LeWordClient class >> default [
	^ BlUseAsyncFeatures 
		ifEnabledDo: [ self future ]
		otherwise: [ self sync ]
]

{ #category : #'api - factory' }
LeWordClient class >> future [
	^ LeWordFutureClient new
]

{ #category : #'api - factory' }
LeWordClient class >> sync [
	^ self new
]

{ #category : #'private - communication' }
LeWordClient >> downloadDefinition [

	| anUrl |
	anUrl := 'https://api.dictionaryapi.dev/api/v2/entries/en' asZnUrl.
	anUrl := anUrl / self word asString.

	^ ZnClient new
		beOneShot;
		setAcceptEncodingGzip;
		url: anUrl;
		get;
		response.
]

{ #category : #'private - communication' }
LeWordClient >> emptyExplanation [
	self response: (LeWordIncorrectInput new
		word: '';
		message: 'Word must be non-empty').
]

{ #category : #'api - communication' }
LeWordClient >> explanation: aWord [
	self word: aWord.
	self updateResponse.
]

{ #category : #initialization }
LeWordClient >> initialize [
	super initialize.
	onResponse := OrderedCollection new: 1.
	word := String empty.
]

{ #category : #'private - notifying' }
LeWordClient >> notifyResponseReceived [
	onResponse do: [ :eachResponse | eachResponse cull: self response ]
]

{ #category : #'api - communication' }
LeWordClient >> onResponse: aValuable [
	"Response callback must be initiliazed before explanation is requested"
	onResponse add: aValuable
]

{ #category : #'private - accessing' }
LeWordClient >> response [
	<return: #LeWordResponse>
	^ response
]

{ #category : #'api - communication' }
LeWordClient >> response: aResponse [
	self 
		assert: [ aResponse isNotNil ] 
		description: [ 'Response must be non-nil' ].
	response == aResponse ifTrue: [ ^ self ].
	response := aResponse.
	self notifyResponseReceived.
]

{ #category : #'private - communication' }
LeWordClient >> secureRequest: aBlock [
	aBlock 
		on: NetworkError, InvalidSocketStatusException
		do: [ :anException | 
			self response: (LeWordNetworkError new 
				exception: anException;
				word: self word) ]
]

{ #category : #'private - communication' }
LeWordClient >> updateResponse [
	self word ifEmpty: [ 
		self emptyExplanation.
		^ self ].
	
	self secureRequest: [ 
		| aZnResponse aWordResponse |
		aZnResponse := self downloadDefinition.
		aWordResponse := aZnResponse isSuccess 
			ifTrue: [ 
				LeWordSuccess new
					explanation: (LeWordExplanation new 
						word: self word;
						rawData: (STON fromString: aZnResponse contents)) ]
			ifFalse: [
				LeWordFailure new
					word: self word;
					response: aZnResponse ].
		self response: aWordResponse ]
]

{ #category : #'private - accessing' }
LeWordClient >> word [
	^ word
]

{ #category : #'private - accessing' }
LeWordClient >> word: anObject [
	word := anObject
]
