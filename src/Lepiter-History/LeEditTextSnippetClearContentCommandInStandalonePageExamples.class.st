Class {
	#name : #LeEditTextSnippetClearContentCommandInStandalonePageExamples,
	#superclass : #LeEditTextSnippetClearContentCommandExamples,
	#traits : 'TLeContentCommandInStandalonePageExamples',
	#classTraits : 'TLeContentCommandInStandalonePageExamples classTrait',
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #accessing }
LeEditTextSnippetClearContentCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyEditTimestampMetadataFor: aSnippet 
]
