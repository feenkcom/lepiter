"
I hold a {{gtClass:GtExampleWithResult}} and an {{gtClass:BlElement}} that represents an example preview.
"
Class {
	#name : #LeExampleSnippetComputedPreview,
	#superclass : #Object,
	#traits : 'TLeExampleSnippetPreview',
	#classTraits : 'TLeExampleSnippetPreview classTrait',
	#instVars : [
		'example',
		'element'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #accessing }
LeExampleSnippetComputedPreview >> element [

	^ element
]

{ #category : #accessing }
LeExampleSnippetComputedPreview >> element: anObject [

	element := anObject
]

{ #category : #accessing }
LeExampleSnippetComputedPreview >> example [

	^ example
]

{ #category : #accessing }
LeExampleSnippetComputedPreview >> example: anObject [

	example := anObject
]

{ #category : #testing }
LeExampleSnippetComputedPreview >> hasElement [
	^ self element isNotNil
]

{ #category : #testing }
LeExampleSnippetComputedPreview >> hasExample [
	^ self example isNotNil
]

{ #category : #testing }
LeExampleSnippetComputedPreview >> hasExamplePreview [
	"Return true if if holds and example preview element (and not another element)."

	^ self hasElement and: [ self hasExample ]
]
