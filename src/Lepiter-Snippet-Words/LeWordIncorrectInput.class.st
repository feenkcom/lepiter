"
I am a {{gtClass:LeWordResponse}}
I provide an error message when a {{gtClass:LeWordExplanation}} cannot is not obtained due to incorrect user input, e.g., empty word.

"
Class {
	#name : #LeWordIncorrectInput,
	#superclass : #LeWordResponse,
	#instVars : [
		'word',
		'message'
	],
	#category : 'Lepiter-Snippet-Words-Client'
}

{ #category : #initialization }
LeWordIncorrectInput >> initialize [
	super initialize.
	message := String empty.
	word := String empty.
]

{ #category : #accessing }
LeWordIncorrectInput >> message [
	^ message
]

{ #category : #accessing }
LeWordIncorrectInput >> message: anObject [
	message := anObject
]

{ #category : #'api - accessing' }
LeWordIncorrectInput >> userMessage [
	^ self message ifEmpty: [ 'Incorrect user input' ]
]

{ #category : #accessing }
LeWordIncorrectInput >> word [
	^ word
]

{ #category : #accessing }
LeWordIncorrectInput >> word: anObject [
	word := anObject
]
