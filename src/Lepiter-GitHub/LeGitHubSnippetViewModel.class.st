Class {
	#name : #LeGitHubSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : 'Lepiter-GitHub-UI Snippet View Models'
}

{ #category : #testing }
LeGitHubSnippetViewModel class >> isAbstract [
	^ self name = #LeGitHubSnippetViewModel 
]
