"
I inform {{gtClass:BlElement}} parents that a {{gtClass:LeCodeSnippet}} was evaluated.

"
Class {
	#name : #LeSnippetEvaluated,
	#superclass : #BlEvent,
	#instVars : [
		'snippet',
		'element',
		'evaluationResult'
	],
	#category : 'Lepiter-UI-Basic - Events'
}

{ #category : #'api - accessing' }
LeSnippetEvaluated >> block [
	self 
		deprecated: 'Use #snippet instead.' 
		transformWith: '`@receiver block' -> '`@receiver snippet'.
	^ self snippet
]

{ #category : #'api - accessing' }
LeSnippetEvaluated >> block: aSnippet [
	self 
		deprecated: 'Use #snippet: instead.' 
		transformWith: '`@receiver block: `@arg' -> '`@receiver snippet: `@arg'.
	^ self snippet: aSnippet.
]

{ #category : #'api - accessing' }
LeSnippetEvaluated >> element [
	^ element
]

{ #category : #'api - accessing' }
LeSnippetEvaluated >> element: anObject [
	element := anObject
]

{ #category : #'api - accessing' }
LeSnippetEvaluated >> evaluationResult [
	^ evaluationResult
]

{ #category : #'api - accessing' }
LeSnippetEvaluated >> evaluationResult: anObject [
	evaluationResult := anObject
]

{ #category : #'api - accessing' }
LeSnippetEvaluated >> snippet [
	^ snippet
]

{ #category : #'api - accessing' }
LeSnippetEvaluated >> snippet: aSnippet [
	snippet := aSnippet
]
