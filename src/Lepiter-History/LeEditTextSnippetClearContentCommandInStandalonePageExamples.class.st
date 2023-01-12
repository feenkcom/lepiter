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
LeEditTextSnippetClearContentCommandInStandalonePageExamples >> initialTargetSnippet [
	^ self textSnippetWithString: 'a'
]

{ #category : #accessing }
LeEditTextSnippetClearContentCommandInStandalonePageExamples >> newStringValue [
	^ ''
]
