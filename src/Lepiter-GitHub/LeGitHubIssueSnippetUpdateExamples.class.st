Class {
	#name : #LeGitHubIssueSnippetUpdateExamples,
	#superclass : #LeGitHubSnippetUpdateExamples,
	#category : #'Lepiter-GitHub-Examples'
}

{ #category : #asserting }
LeGitHubIssueSnippetUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [

	self assert: anAnnouncementsCollection size equals: 3.
	
	self assert: (anAnnouncementsCollection allSatisfy: [ :anAnnouncement |
		anAnnouncement class = LeSnippetContentChanged ])
]

{ #category : #asserting }
LeGitHubIssueSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet ownerName equals: 'pharo-project'.
	self assert: targetSnippet projectName equals: 'pharo'.
	self assert: targetSnippet issueNumber equals: 9392.
]

{ #category : #'examples - snippets' }
LeGitHubIssueSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeGitHubIssueSnippet>
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
