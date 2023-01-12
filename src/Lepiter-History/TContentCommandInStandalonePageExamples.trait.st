Trait {
	#name : #TContentCommandInStandalonePageExamples,
	#instVars : [
		'theDatabase'
	],
	#category : #'Lepiter-History-Examples'
}

{ #category : #asserting }
TContentCommandInStandalonePageExamples >> assertEditedSnippetMetadataFor: aSnippet [ 
	self assertFullMetadataSetForSnippet: aSnippet 
]

{ #category : #accessing }
TContentCommandInStandalonePageExamples >> targetDatabase [
	<gtExample>
	
	^ theDatabase ifNil: [
		theDatabase := LeDatabase new. ]
]

{ #category : #accessing }
TContentCommandInStandalonePageExamples >> targetPage [
	<gtExample>
	
	^ self thePage ifNil: [
		self thePage: self createTargetPage.
		self targetDatabase addPage: self thePage ]
]
