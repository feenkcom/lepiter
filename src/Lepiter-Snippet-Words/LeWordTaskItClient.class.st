"
I am an asynchronous version of the ${class:LeWordClient}$. I use ${class:BlTktWorkerProvider}$ to execute requests.
"
Class {
	#name : #LeWordTaskItClient,
	#superclass : #LeWordBasicClient,
	#instVars : [
		'syncClient'
	],
	#category : #'Lepiter-Snippet-Words-Client'
}

{ #category : #'api - communication' }
LeWordTaskItClient >> explanation: aWord [
	"Download a word explanation and execute responses"
	| aFuture |
	aFuture := BlTktWorkerProvider highUICPUBoundPool
		future: [ 
			self syncClient explanation: aWord ].
	aFuture
		onFailureDo: [ :anException | 
			self syncClient response: (LeWordNetworkError new 
				exception: anException; 
				word: aWord) ]
]

{ #category : #initialization }
LeWordTaskItClient >> initialize [
	super initialize.
	syncClient := LeWordClient sync.
]

{ #category : #'api - communication' }
LeWordTaskItClient >> onResponse: aValuable [
	"when a any response is obtained, aValuable is executed.
	aValuable is a block with one parameter [ :aResponse | ]"
	^ self syncClient onResponse: aValuable
]

{ #category : #'private - accessing' }
LeWordTaskItClient >> syncClient [
	<return: #LeWordClient>
	^ syncClient
]
