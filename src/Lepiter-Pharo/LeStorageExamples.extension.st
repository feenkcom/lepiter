Extension { #name : #LeStorageExamples }

{ #category : #'*Lepiter-Pharo' }
LeStorageExamples >> emptyPharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: ''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #'*Lepiter-Pharo' }
LeStorageExamples >> pharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: '3+4'.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #'*Lepiter-Pharo' }
LeStorageExamples >> pharoSnippetWithQuotes [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: '''hello world'''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]
