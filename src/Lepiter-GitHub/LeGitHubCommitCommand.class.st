Class {
	#name : #LeGitHubCommitCommand,
	#superclass : #LeGitHubCommand,
	#instVars : [
		'commitId'
	],
	#category : 'Lepiter-GitHub-Client'
}

{ #category : #'api - accessing' }
LeGitHubCommitCommand >> commitId [
	^ commitId
]

{ #category : #'api - accessing' }
LeGitHubCommitCommand >> commitId: anObject [
	commitId := anObject
]

{ #category : #'private - execution' }
LeGitHubCommitCommand >> download [
	^ IceGitHubAPI new
			beAnonymous;
			get: 'repos/', 
				self userName asString, '/', 
				self projectName asString, '/commits/',
				self commitId asString
]
