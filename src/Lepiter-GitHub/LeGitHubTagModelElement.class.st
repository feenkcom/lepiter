Class {
	#name : #LeGitHubTagModelElement,
	#superclass : #LeGitHubEditorAndSummaryModelElement,
	#category : 'Lepiter-GitHub-UI Model Elements'
}

{ #category : #initialization }
LeGitHubTagModelElement >> defaultEditorModelElementClass [
	^ LeGitHubTagEditorModelElement
]

{ #category : #initialization }
LeGitHubTagModelElement >> defaultSummaryModelElementClass [
	^ LeGitHubTagSummaryModelElement
]
