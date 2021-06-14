Class {
	#name : #LeDockerSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-Docker-Examples'
}

{ #category : #'examples - snippets' }
LeDockerSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet url
		equals:'www.example.com/docker2'
]

{ #category : #'examples - snippets' }
LeDockerSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeDockerSnippet new 
		url: 'www.example.com/docker1'
]

{ #category : #'examples - snippets' }
LeDockerSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet url: 'www.example.com/docker2'
]
