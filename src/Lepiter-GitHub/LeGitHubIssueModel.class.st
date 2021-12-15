Class {
	#name : #LeGitHubIssueModel,
	#superclass : #LeGitHubModel,
	#instVars : [
		'issueNumber'
	],
	#category : 'Lepiter-GitHub-Model'
}

{ #category : #'api - response' }
LeGitHubIssueModel >> body [
	<return: #String>
	^ self responseAtPath: #( body ) ifAbsent: [ '' ]
]

{ #category : #accessing }
LeGitHubIssueModel >> createHtmlUrl [

	^ ('https://github.com' asZnUrl / self ownerName / self projectName
	   / 'issues' / self issueNumber asString) asString
]

{ #category : #'private - execution' }
LeGitHubIssueModel >> download [
	^ LeGitHubClient new
		userName: self ownerName 
		projectName: self projectName 
		issue: self issueNumber
]

{ #category : #'api - accessing' }
LeGitHubIssueModel >> htmlUrl [

	self hasResponse ifFalse: [ ^ self createHtmlUrl ].

	^ self response
		  atPath: #( 'html_url' )
		  ifAbsent: [ self createHtmlUrl ]
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

{ #category : #accessing }
LeGitHubIssueModel >> longIdentificator [

	"Return an identificator in a form of owner/project#issue."

	^ String streamContents: [ :aStream | 
		  aStream
			  nextPutAll: self ownerName asString;
			  nextPut: $/;
			  nextPutAll: self projectName asString;
			  nextPut: $#;
			  nextPutAll: self issueNumber asString ]
]

{ #category : #'api - response' }
LeGitHubIssueModel >> title [
	<return: #String>
	^ self responseAtPath: #( title ) ifAbsent: [ '' ]
]
