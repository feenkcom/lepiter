Class {
	#name : #LeDockerSnippetUrlChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'url'
	],
	#category : #'Lepiter-Snippet-Docker-Model'
}

{ #category : #accessing }
LeDockerSnippetUrlChanged >> url [
	^ url
]

{ #category : #accessing }
LeDockerSnippetUrlChanged >> url: anUrl [
	url := anUrl
]
