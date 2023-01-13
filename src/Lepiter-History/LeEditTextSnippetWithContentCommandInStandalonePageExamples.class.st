Class {
	#name : #LeEditTextSnippetWithContentCommandInStandalonePageExamples,
	#superclass : #LeEditTextSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyEditTimestampMetadataFor: aSnippet 
]

{ #category : #accessing }
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> initialStringValue [
	^ 'a'
]

{ #category : #accessing }
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> modifiedStringValue [
	^ 'cd'
]
