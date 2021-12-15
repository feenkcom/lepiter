Class {
	#name : #LeLinkGithubTagReference,
	#superclass : #LeLinkGithubReference,
	#instVars : [
		'tagName'
	],
	#category : 'Lepiter-GitHub-Model'
}

{ #category : #accessing }
LeLinkGithubTagReference >> description [
	^ String streamContents: [ :aStream | 
			aStream 
				nextPutAll: 'GitHub Tag Reference: '.
			self printDetailsOn: aStream ]
]

{ #category : #communication }
LeLinkGithubTagReference >> download [
	| aRawData aCommitInfo |
	aRawData := IceGitHubAPI new
			beAnonymous;
			get: 'repos/', 
				self userName asString, '/', 
				self projectName asString, '/git/refs/tags/',
				self tagName asString.
				
	aCommitInfo := LeLinkGithubCommitReference new
		userName: self userName;
		projectName: self projectName;
		commitId: ((aRawData at: #object) at: #sha);
		download.
		
	aRawData at: #commit put: aCommitInfo.
	
	^ aRawData.
]

{ #category : #printing }
LeLinkGithubTagReference >> printDetailsOn: aStream [
	super printDetailsOn: aStream.
	aStream 
		nextPut: $/;
		nextPutAll: self tagName asString
]

{ #category : #accessing }
LeLinkGithubTagReference >> tagName [
	^ tagName
]

{ #category : #accessing }
LeLinkGithubTagReference >> tagName: anObject [
	tagName := anObject
]

{ #category : #accessing }
LeLinkGithubTagReference >> urlString [
	^ String streamContents: [ :aStream |
		aStream 
			nextPutAll: 'https://github.com/';
			nextPutAll: self userName asString;
			nextPut: $/;
			nextPutAll: self projectName asString;
			nextPutAll: '/releases/tag/';
			nextPutAll: self tagName asString ]
]
