"
I am an abstract class.
I document {{gtClass:LeWordClient}} common API that clients must implement.

"
Class {
	#name : #LeWordBasicClient,
	#superclass : #Object,
	#category : 'Lepiter-Snippet-Words-Client'
}

{ #category : #'api - communication' }
LeWordBasicClient >> explanation: aWord [
	"Download a word explanation and execute responses"
	self subclassResponsibility
]

{ #category : #'api - communication' }
LeWordBasicClient >> onResponse: aValuable [
	"when a any response is obtained, aValuable is executed.
	aValuable is a block with one parameter [ :aResponse | ]"
	^ self subclassResponsibility
]
