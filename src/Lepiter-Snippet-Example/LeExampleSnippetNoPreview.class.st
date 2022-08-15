Class {
	#name : #LeExampleSnippetNoPreview,
	#superclass : #Object,
	#traits : 'TLeExampleSnippetPreview',
	#classTraits : 'TLeExampleSnippetPreview classTrait',
	#instVars : [
		'element'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #accessing }
LeExampleSnippetNoPreview >> element [

	^ element
]

{ #category : #accessing }
LeExampleSnippetNoPreview >> element: anObject [

	element := anObject
]

{ #category : #testing }
LeExampleSnippetNoPreview >> hasElement [
	^ self element isNotNil
]

{ #category : #testing }
LeExampleSnippetNoPreview >> hasExample [
	^ false
]

{ #category : #testing }
LeExampleSnippetNoPreview >> hasExamplePreview [
	"Return true if if holds and example preview element (and not another element)."

	^ false
]
