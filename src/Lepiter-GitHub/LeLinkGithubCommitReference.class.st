Class {
	#name : #LeLinkGithubCommitReference,
	#superclass : #LeLinkGithubReference,
	#instVars : [
		'commitId'
	],
	#category : 'Lepiter-GitHub-Model'
}

{ #category : #accessing }
LeLinkGithubCommitReference >> commitId [
	^ commitId
]

{ #category : #accessing }
LeLinkGithubCommitReference >> commitId: anObject [
	commitId := anObject
]

{ #category : #accessing }
LeLinkGithubCommitReference >> description [
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: 'GitHub Commit Reference: '.
		self printDetailsOn: aStream ]
]

{ #category : #communication }
LeLinkGithubCommitReference >> download [
	^ IceGitHubAPI new
			beAnonymous;
			get: 'repos/', 
				self userName asString, '/', 
				self projectName asString, '/commits/',
				self commitId asString
]

{ #category : #printing }
LeLinkGithubCommitReference >> printDetailsOn: aStream [
	super printDetailsOn: aStream.
	aStream 
		nextPut: $/;
		nextPutAll: self commitId asString
]

{ #category : #communication }
LeLinkGithubCommitReference >> urlString [
	^ String streamContents: [ :aStream |
		aStream 
			nextPutAll: 'https://github.com/';
			nextPutAll: self userName asString;
			nextPut: $/;
			nextPutAll: self projectName asString;
			nextPutAll: '/commit/';
			nextPutAll: self commitId asString ]
]
