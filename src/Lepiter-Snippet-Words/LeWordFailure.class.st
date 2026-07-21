"
I am a {{gtClass:LeWordResponse}}
I provide an error message when a {{gtClass:LeWordExplanation}} cannot is not obtained due to some issues, e.g., the service does not provide an explanation for a given word.

"
Class {
	#name : #LeWordFailure,
	#superclass : #LeWordResponse,
	#instVars : [
		'response',
		'word'
	],
	#category : 'Lepiter-Snippet-Words-Client'
}

{ #category : #accessing }
LeWordFailure >> response [
	^ response
]

{ #category : #accessing }
LeWordFailure >> response: anObject [
	response := anObject
]

{ #category : #'api - accessing' }
LeWordFailure >> userMessage [
	<return: #BlText or: #String>
	| aContents aJsonObject |
	(self response contentType = ZnMimeType applicationJson) ifFalse: [ 
		^ 'Search failed. You can try it again.' ].
	
	aContents := self response contents.
	aJsonObject := STONJSON fromString: aContents.
	^ aJsonObject
		at: 'message' 
		ifAbsent: [ aContents ]
]

{ #category : #'private - communication' }
LeWordFailure >> word: aWord [ 
]
