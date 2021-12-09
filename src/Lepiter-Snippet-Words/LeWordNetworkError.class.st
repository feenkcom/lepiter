"
I am a {{gtClass:LeWordResponse}}
I provide an error message when a {{gtClass:LeWordExplanation}} cannot is not obtained due to network failures.

"
Class {
	#name : #LeWordNetworkError,
	#superclass : #LeWordResponse,
	#instVars : [
		'exception',
		'word'
	],
	#category : 'Lepiter-Snippet-Words-Client'
}

{ #category : #accessing }
LeWordNetworkError >> exception [
	^ exception
]

{ #category : #accessing }
LeWordNetworkError >> exception: anObject [
	exception := anObject
]

{ #category : #'api - accessing' }
LeWordNetworkError >> userMessage [
	<return: #BlText or: #String>
	^ self exception messageText
]

{ #category : #accessing }
LeWordNetworkError >> word [
	^ word
]

{ #category : #accessing }
LeWordNetworkError >> word: anObject [
	word := anObject
]
