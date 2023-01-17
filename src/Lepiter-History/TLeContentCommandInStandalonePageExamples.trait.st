Trait {
	#name : #TLeContentCommandInStandalonePageExamples,
	#category : #'Lepiter-History-Examples - Commands'
}

{ #category : #asserting }
TLeContentCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyTimeMetadataSetForSnippet: aSnippet 
]

{ #category : #accessing }
TLeContentCommandInStandalonePageExamples >> createTargetDatabase [
	^ LeDatabase null
]
