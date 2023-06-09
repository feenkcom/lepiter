Extension { #name : #LeExportSnippetExamples }

{ #category : #'*Lepiter-Snippet-Words' }
LeExportSnippetExamples >> textSnippetWithWordAnnotation [
	<gtExample>
	| snippet |
	snippet := LeTextSnippet new string: '{{gtWordExplanation:toolkit|expanded}}'.

	^ snippet
]
