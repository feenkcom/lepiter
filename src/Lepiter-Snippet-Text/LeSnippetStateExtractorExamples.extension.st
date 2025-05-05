Extension { #name : #LeSnippetStateExtractorExamples }

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetStateExtractorExamples >> extractCommonStateEmptyTextSnippet [
	<gtExample>
	<return: #LeGenericSnippetState>
	| state |
	state := LeTextSnippet empty extractCommonState.
	self assertCommonStateAttributesFor: state.
	state attributes
		do: [ :anAttribute | self assert: anAttribute attributeValue isNil ].

	^ state
]

{ #category : #'*Lepiter-Snippet-Text' }
LeSnippetStateExtractorExamples >> extractSpecificStateTextSnippet [
	<gtExample>
	<return: #LeGenericSnippetState>
	| state |
	state := (LeTextSnippet string: 'a') extractSpecificState.
	self
		assert: (state attributes collect: #attributeName) sorted
		equals: #(paragraphStyle string).

	self assert: (state attributeNamed: 'string') attributeValue equals: 'a'.

	^ state
]
