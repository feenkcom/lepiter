Extension { #name : #LeExportSnippetExamples }

{ #category : #'*Lepiter-Snippet-Words' }
LeExportSnippetExamples >> textSnippetWithWordAnnotation [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtWordExplanation:toolkit|expanded}}'.

	^ snippet
]
