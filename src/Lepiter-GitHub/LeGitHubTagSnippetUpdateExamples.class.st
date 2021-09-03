Class {
	#name : 'LeGitHubTagSnippetUpdateExamples',
	#superclass : 'LeSingleSnippetUpdateExamples',
	#category : 'Lepiter-GitHub-Examples'
}

{ #category : 'examples - snippets' }
LeGitHubTagSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet ownerName equals: 'pharo-project'.
	self assert: targetSnippet projectName equals: 'pharo'.
	self assert: targetSnippet tagName equals: 'v8.0.0'
]

{ #category : 'examples - snippets' }
LeGitHubTagSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeGitHubTagSnippet new
		ownerName: 'feenkcom';
		projectName: 'gtoolkit';
		tagName: 'v0.8.439'
]

{ #category : 'examples - snippets' }
LeGitHubTagSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet 
		ownerName: 'pharo-project';
		projectName: 'pharo';
		tagName: 'v8.0.0'
]
