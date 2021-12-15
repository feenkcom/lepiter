Class {
	#name : #LeGitHubIssueCommand,
	#superclass : #LeGitHubCommand,
	#instVars : [
		'issueNumber'
	],
	#category : 'Lepiter-GitHub-Client'
}

{ #category : #'private - execution' }
LeGitHubIssueCommand >> download [
	| aRawData |
	aRawData := IceGitHubAPI new
			getIssue: self userName 
				project: self projectName 
				number: self issueNumber.
	
	^ aRawData.
]

{ #category : #'api - accessing' }
LeGitHubIssueCommand >> issueNumber [
	^ issueNumber
]

{ #category : #'api - accessing' }
LeGitHubIssueCommand >> issueNumber: anObject [
	issueNumber := anObject
]
