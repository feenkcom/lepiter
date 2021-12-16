Class {
	#name : #LeGitHubTagSnippetElement,
	#superclass : #LeGitHubSnippetElement,
	#category : 'Lepiter-GitHub-UI Snippet Elements'
}

{ #category : #initialization }
LeGitHubTagSnippetElement >> defaultModelElement [
	<return: #LeGitHubModelElement>
	^ LeGitHubTagModelElement new
]

{ #category : #'api - ui model' }
LeGitHubTagSnippetElement >> onSnippetViewModelFocused: aBoolean [
	"Override me to either request or lose focus when the focused state is changed in the UI Model"

	aBoolean
		ifTrue: [ self requestFocus ]
		ifFalse: [ self loseFocus ]
]
