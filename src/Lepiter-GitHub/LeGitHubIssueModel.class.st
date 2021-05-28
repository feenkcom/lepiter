Class {
	#name : #LeGitHubIssueModel,
	#superclass : #LeGitHubModel,
	#instVars : [
		'issueNumber'
	],
	#category : #'Lepiter-GitHub-Model'
}

{ #category : #'api - response' }
LeGitHubIssueModel >> body [
	<return: #String>
	^ self responseAtPath: #( body ) ifAbsent: [ '' ]
]

{ #category : #'private - execution' }
LeGitHubIssueModel >> download [
	^ LeGitHubClient new
		userName: self ownerName 
		projectName: self projectName 
		issue: self issueNumber
]

{ #category : #initialization }
LeGitHubIssueModel >> initialize [
	super initialize.
	issueNumber := String empty .
]

{ #category : #'api - accessing' }
LeGitHubIssueModel >> issueNumber [
	^ issueNumber
]

{ #category : #'api - accessing' }
LeGitHubIssueModel >> issueNumber: aNumber [
	self issueNumber: aNumber source: nil
]

{ #category : #'api - accessing' }
LeGitHubIssueModel >> issueNumber: aString source: aSource [
	self issueNumber = aString ifTrue: [ ^ self ].
	issueNumber := aString.
	self announceConfigurationChangedBy: aSource
]

{ #category : #'api - response' }
LeGitHubIssueModel >> title [
	<return: #String>
	^ self responseAtPath: #( title ) ifAbsent: [ '' ]
]
