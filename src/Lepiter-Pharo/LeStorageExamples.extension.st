Extension { #name : #LeStorageExamples }

{ #category : #'*Lepiter-Pharo' }
LeStorageExamples >> emptyPharoSnippet [
	<gtExample>
	<return: #LePharoSnippet>
	| snippet |
	snippet := LePharoSnippet code: ''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #'*Lepiter-Pharo' }
LeStorageExamples >> pharoSnippet [
	<gtExample>
	<return: #LePharoSnippet>
	| snippet |
	snippet := LePharoSnippet code: '3+4'.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #'*Lepiter-Pharo' }
LeStorageExamples >> pharoSnippetWithQuotes [
	<gtExample>
	<return: #LePharoSnippet>
	| snippet |
	snippet := LePharoSnippet code: '''hello world'''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]
