Class {
	#name : #LeEditSnippetCommandExamples,
	#superclass : #LeContentCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #testing }
LeEditSnippetCommandExamples class >> isAbstract [ 
	^ self name = #LeEditSnippetCommandExamples
]

{ #category : #asserting }
LeEditSnippetCommandExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyTimeMetadataSetForSnippet: aSnippet
]

{ #category : #accessing }
LeEditSnippetCommandExamples >> targetSnippet [
	^ self targetPage children first
]
