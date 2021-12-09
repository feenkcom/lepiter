"
I am an abstract class.
I am a {{gtClass:LeWordClient}} response, providing response information.


"
Class {
	#name : #LeWordResponse,
	#superclass : #Object,
	#category : 'Lepiter-Snippet-Words-Client'
}

{ #category : #'api - testing' }
LeWordResponse >> isSuccess [
	^ false
]

{ #category : #'api - accessing' }
LeWordResponse >> userMessage [
	<return: #BlText or: #String>
	^ String empty
]
