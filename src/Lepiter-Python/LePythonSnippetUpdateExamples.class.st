Class {
	#name : 'LePythonSnippetUpdateExamples',
	#superclass : 'LeSingleSnippetUpdateExamples',
	#category : 'Lepiter-Python-Examples'
}

{ #category : 'examples - snippets' }
LePythonSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet code equals: '1+2+3'.
]

{ #category : 'examples - snippets' }
LePythonSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LePythonSnippet code: '1+2'
]

{ #category : 'examples - snippets' }
LePythonSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: '1+2+3'.
	self 
		assert: aTargetSnippet code 
		equals: '1+2+3'.
	^ aTargetSnippet
]
