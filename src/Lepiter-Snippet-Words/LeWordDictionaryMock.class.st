"
Test dictionary for word annotation styler examples.
"
Class {
	#name : #LeWordDictionaryMock,
	#superclass : #Object,
	#instVars : [
		'response'
	],
	#category : #'Lepiter-Snippet-Words'
}

{ #category : #accessing }
LeWordDictionaryMock >> emptyRequests [
	"No pending requests to reset in tests."
	^ self
]

{ #category : #initialization }
LeWordDictionaryMock >> initialize [
	super initialize.
	response := LeWordSuccess new
		explanation: LeWordExamples new helloExplanation;
		yourself
]

{ #category : #accessing }
LeWordDictionaryMock >> lookup: aString do: aBlock [
	aBlock cull: self response cull: aString
]

{ #category : #accessing }
LeWordDictionaryMock >> response [
	^ response
]
