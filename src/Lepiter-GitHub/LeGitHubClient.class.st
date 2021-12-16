Class {
	#name : #LeGitHubClient,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Lepiter-GitHub-Client'
}

{ #category : #'api - communication' }
LeGitHubClient >> userName: aUser projectName: aProject issue: anIssue [
	<return: #LeGitHubResponse>
	^ LeGitHubIssueCommand new
		userName: aUser;
		projectName: aProject;
		issueNumber: anIssue;
		execute
]

{ #category : #'api - communication' }
LeGitHubClient >> userName: aUser projectName: aProject tag: aTag [
	<return: #LeGitHubResponse>
	^ LeGitHubTagCommand new
		userName: aUser;
		projectName: aProject;
		tagName: aTag;
		execute
]
