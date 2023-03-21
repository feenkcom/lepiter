Class {
	#name : #LeUpdatableSnippetStateExtractor,
	#superclass : #LeSnippetStateExtractor,
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeUpdatableSnippetStateExtractor >> ignoredAttributeNames [
	^ self fixedAttributeNames
]
