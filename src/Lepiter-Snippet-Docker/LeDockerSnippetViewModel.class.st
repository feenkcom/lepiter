Class {
	#name : #LeDockerSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-Snippet-Docker-View-Model'
}

{ #category : #accessing }
LeDockerSnippetViewModel >> dockerSnippetModel [
	^ snippetModel
]

{ #category : #accessing }
LeDockerSnippetViewModel >> snippetElementClass [
	^ LeDockerSnippetElement
]
