Class {
	#name : #LeEditTextSnippetClearContentCommandInStandalonePageExamples,
	#superclass : #LeEditTextSnippetCommandExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #accessing }
LeEditTextSnippetClearContentCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyEditTimestampMetadataFor: aSnippet 
]

{ #category : #accessing }
LeEditTextSnippetClearContentCommandInStandalonePageExamples >> initialStringValue [
	^ 'a'
]

{ #category : #accessing }
LeEditTextSnippetClearContentCommandInStandalonePageExamples >> modifiedStringValue [
	^ ''
]
