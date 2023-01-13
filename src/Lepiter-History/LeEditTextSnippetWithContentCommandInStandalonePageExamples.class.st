Class {
	#name : #LeEditTextSnippetWithContentCommandInStandalonePageExamples,
	#superclass : #LeEditTextSnippetWithContentCommandExamples,
	#traits : 'TLeContentCommandInStandalonePageExamples',
	#classTraits : 'TLeContentCommandInStandalonePageExamples classTrait',
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
LeEditTextSnippetWithContentCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyEditTimestampMetadataFor: aSnippet 
]
