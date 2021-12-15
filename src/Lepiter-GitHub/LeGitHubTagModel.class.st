Class {
	#name : #LeGitHubTagModel,
	#superclass : #LeGitHubModel,
	#instVars : [
		'tagName'
	],
	#category : 'Lepiter-GitHub-Model'
}

{ #category : #'private - execution' }
LeGitHubTagModel >> download [
	^ LeGitHubClient new
		userName: self ownerName 
		projectName: self projectName 
		tag: self tagName
]

{ #category : #initialization }
LeGitHubTagModel >> initialize [
	super initialize.
	tagName := String empty .
]

{ #category : #'api - response' }
LeGitHubTagModel >> message [
	<return: #String>
	^ self responseAtPath: #( commit commit message ) ifAbsent: [ '' ]
]

{ #category : #printing }
LeGitHubTagModel >> printOn: aStream [
	self ownerName ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: (self ownerName ifEmpty: [ '<owner>' ]);
		nextPutAll: (self projectName ifEmpty: [ '<project>' ]);
		nextPutAll: '/tags/';
		nextPutAll: (self tagName ifEmpty: [ '<tag>' ])
]

{ #category : #'api - accessing' }
LeGitHubTagModel >> tagName [
	^ tagName
]

{ #category : #'api - accessing' }
LeGitHubTagModel >> tagName: aString [
	self tagName: aString source: nil
]

{ #category : #'api - accessing' }
LeGitHubTagModel >> tagName: aString source: aSource [
	self tagName = aString ifTrue: [ ^ self ].
	tagName := aString.
	self announceConfigurationChangedBy: aSource
]
