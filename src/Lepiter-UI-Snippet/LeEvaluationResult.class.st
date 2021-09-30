Class {
	#name : #LeEvaluationResult,
	#superclass : #Object,
	#instVars : [
		'value',
		'position',
		'expanded',
		'cachedPreview'
	],
	#category : 'Lepiter-UI-Snippet-Text styler'
}

{ #category : #accessing }
LeEvaluationResult >> cachedPreview [
	^ cachedPreview
]

{ #category : #accessing }
LeEvaluationResult >> cachedPreview: anObject [
	cachedPreview := anObject
]

{ #category : #accessing }
LeEvaluationResult >> expanded [
	^ expanded ifNil: [ false ]
]

{ #category : #accessing }
LeEvaluationResult >> expanded: aBoolean [
	expanded := aBoolean
]

{ #category : #accessing }
LeEvaluationResult >> position [
	^ position
]

{ #category : #accessing }
LeEvaluationResult >> position: anInteger [
	position := anInteger
]

{ #category : #accessing }
LeEvaluationResult >> value [
	^ value
]

{ #category : #accessing }
LeEvaluationResult >> value: anObject [
	value := anObject
]
