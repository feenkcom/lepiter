Class {
	#name : #LeGitHubUtility,
	#superclass : #Object,
	#category : 'Lepiter-GitHub-Utility'
}

{ #category : #testing }
LeGitHubUtility class >> isValidGitHubIssueUrl: aString [
	^ LeGitHubIssueUrlValidator new 
		url: aString asString;
		validate;
		isValid
]

{ #category : #testing }
LeGitHubUtility class >> shortGitHubIssueNameFromUrl: aString [
	^ LeGitHubIssueUrlValidator new 
		url: aString asString;
		validate;
		identifier
]
