"
I am a {{gtClass:LeWordResponse}}
I provide a success response with {{gtMethod:LeWordSuccess>>#explanation|label=#selector}}.


"
Class {
	#name : #LeWordSuccess,
	#superclass : #LeWordResponse,
	#instVars : [
		'explanation'
	],
	#category : 'Lepiter-Snippet-Words-Client'
}

{ #category : #accessing }
LeWordSuccess >> explanation [
	<return: #LeWordExplanation>
	^ explanation
]

{ #category : #accessing }
LeWordSuccess >> explanation: anExplanation [
	explanation := anExplanation
]

{ #category : #'public - testing' }
LeWordSuccess >> isSuccess [
	^ true
]

{ #category : #accessing }
LeWordSuccess >> rawData [
	^ self explanation rawData
]
