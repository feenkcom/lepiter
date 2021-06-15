Class {
	#name : #LeGitHubIssueSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-GitHub-Examples'
}

{ #category : #'examples - snippets' }
LeGitHubIssueSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet ownerName equals: 'pharo-project'.
	self assert: targetSnippet projectName equals: 'pharo'.
	self assert: targetSnippet issueNumber equals: 9392.
]

{ #category : #'examples - snippets' }
LeGitHubIssueSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeGitHubIssueSnippet new
		ownerName: 'feenkcom';
		projectName: 'gtoolkit';
		issueNumber: 1772
]

{ #category : #'examples - snippets' }
LeGitHubIssueSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet 
		ownerName: 'pharo-project';
		projectName: 'pharo';
		issueNumber: 9392
]
