Class {
	#name : #LeGitHubTagCommand,
	#superclass : #LeGitHubCommand,
	#instVars : [
		'tagName'
	],
	#category : 'Lepiter-GitHub-Client'
}

{ #category : #'private - execution' }
LeGitHubTagCommand >> download [
	| aRawData aCommitInfo |
	aRawData := IceGitHubAPI new
			beAnonymous;
			get: 'repos/', 
				self userName asString, '/', 
				self projectName asString, '/git/refs/tags/',
				self tagName asString.
				
	aCommitInfo := LeGitHubCommitCommand new
		userName: self userName;
		projectName: self projectName;
		commitId: ((aRawData at: #object) at: #sha);
		download.
		
	aRawData at: #commit put: aCommitInfo.
	
	^ aRawData.
]

{ #category : #'api - accessing' }
LeGitHubTagCommand >> tagName [
	^ tagName
]

{ #category : #'api - accessing' }
LeGitHubTagCommand >> tagName: anObject [
	tagName := anObject
]
