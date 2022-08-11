"
I hold a {{gtClass:GtExampleWithResult}} and an {{gtClass:BlElement}} that represents an example preview.
"
Class {
	#name : #LeExampleSnippetComputedPreview,
	#superclass : #Object,
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
LeExampleSnippetComputedPreview >> hasExamplePreview [
	"If example is nil, then the element displays an information, not an example preview"

	^ self example isNotNil
]
