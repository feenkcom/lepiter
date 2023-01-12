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
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> initialTargetSnippet [
	^ self textSnippetWithString: 'a'
]

{ #category : #accessing }
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> newStringValue [
	^ 'cd'
]
