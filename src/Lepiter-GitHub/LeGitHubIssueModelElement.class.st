Class {
	#name : #LeGitHubIssueModelElement,
	#superclass : #LeGitHubEditorAndSummaryModelElement,
	#category : 'Lepiter-GitHub-UI Model Elements'
}

{ #category : #initialization }
LeGitHubIssueModelElement >> defaultEditorModelElementClass [
	^ LeGitHubIssueEditorModelElement
]

{ #category : #initialization }
LeGitHubIssueModelElement >> defaultSummaryModelElementClass [
	^ LeGitHubIssueSummaryModelElement
]
