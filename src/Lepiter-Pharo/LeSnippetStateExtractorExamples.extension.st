Extension { #name : #LeSnippetStateExtractorExamples }

{ #category : #'*Lepiter-Pharo' }
LeSnippetStateExtractorExamples >> extractCommonStateEmptyPharoSnippet [
	<gtExample>
	<return: #LeGenericSnippetState>
	| state |
	state := LePharoSnippet empty extractCommonState.
	self assertCommonStateAttributesFor: state.
	state attributes
		do: [ :anAttribute | self assert: anAttribute attributeValue isNil ].

	^ state
]

{ #category : #'*Lepiter-Pharo' }
LeSnippetStateExtractorExamples >> extractSpecificStatePharoSnippet [
	<gtExample>
	<return: #LeGenericSnippetState>
	| state |
	state := (LePharoSnippet code: '1') extractSpecificState.
	self assert: (state attributes collect: #attributeName) sorted equals: #(code).

	self assert: (state attributeNamed: 'code') attributeValue equals: '1'.

	^ state
]
