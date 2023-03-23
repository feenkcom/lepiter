Class {
	#name : #LeEditElementSnippetWithContentCommandExamples,
	#superclass : #LeEditElementSnippetCodeCommandExamples,
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #accessing }
LeEditElementSnippetWithContentCommandExamples >> initialStringValue [
	^ 'BlElement new'
]

{ #category : #accessing }
LeEditElementSnippetWithContentCommandExamples >> modifiedStringValue [
	^ 'BlElement new
		background: Color red'
]
