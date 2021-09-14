Class {
	#name : 'LeJavaScriptSnippetUpdateExamples',
	#superclass : 'LeSingleSnippetUpdateExamples',
	#category : 'Lepiter-JavaScript-Examples'
}

{ #category : 'examples - snippets' }
LeJavaScriptSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet code equals: '1+2+3'.
]

{ #category : 'examples - snippets' }
LeJavaScriptSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeJavaScriptSnippet code: '1+2'
]

{ #category : 'examples - snippets' }
LeJavaScriptSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: '1+2+3'.
	self 
		assert: aTargetSnippet code 
		equals: '1+2+3'.
	^ aTargetSnippet
]
