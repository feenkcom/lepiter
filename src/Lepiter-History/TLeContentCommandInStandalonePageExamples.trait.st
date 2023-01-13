Trait {
	#name : #TLeContentCommandInStandalonePageExamples,
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
TLeContentCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertOnlyTimeMetadataSetForSnippet: aSnippet 
]

{ #category : #accessing }
TLeContentCommandInStandalonePageExamples >> createTargetDatabase [
	^ LeDatabase null
]
