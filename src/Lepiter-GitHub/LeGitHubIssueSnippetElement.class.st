Class {
	#name : #LeGitHubIssueSnippetElement,
	#superclass : #LeGitHubSnippetElement,
	#category : 'Lepiter-GitHub-UI Snippet Elements'
}

{ #category : #initialization }
LeGitHubIssueSnippetElement >> defaultModelElement [
	<return: #LeGitHubModelElement>
	^ LeGitHubIssueModelElement new
]

{ #category : #'api - ui model' }
LeGitHubIssueSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	self flag: 'what should I do?'
]
