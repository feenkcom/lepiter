"
I am an asynchronous version of the {{gtClass:LeWordClient}}. I use async futures to execute requests.
"
Class {
	#name : #LeWordFutureClient,
	#superclass : #LeWordBasicClient,
	#instVars : [
		'syncClient'
	],
	#category : #'Lepiter-Snippet-Words-Client'
}

{ #category : #'api - communication' }
LeWordFutureClient >> explanation: aWord [
	"Download a word explanation and execute responses"
	| aFuture |
	aFuture := [ 
			self syncClient explanation: aWord ] asAsyncFuture.
	aFuture await
		then: []
		otherwise: [ :anException | 
			self syncClient response: (LeWordNetworkError new 
				exception: anException; 
				word: aWord) ]
]

{ #category : #initialization }
LeWordFutureClient >> initialize [
	super initialize.
	syncClient := LeWordClient sync.
]

{ #category : #'api - communication' }
LeWordFutureClient >> onResponse: aValuable [
	"when a any response is obtained, aValuable is executed.
	aValuable is a block with one parameter [ :aResponse | ]"
	^ self syncClient onResponse: aValuable
]

{ #category : #'private - accessing' }
LeWordFutureClient >> syncClient [
	<return: #LeWordClient>
	^ syncClient
]
