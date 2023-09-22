Class {
	#name : #LeElementSnippetCodeVisibilityChanged,
	#superclass : #LeElementSnippetAnnouncement,
	#instVars : [
		'codeVisible'
	],
	#category : #'Lepiter-Snippet-Element-Events'
}

{ #category : #accessing }
LeElementSnippetCodeVisibilityChanged >> codeVisible [
	^ codeVisible
]

{ #category : #accessing }
LeElementSnippetCodeVisibilityChanged >> codeVisible: aBoolean [
	codeVisible := aBoolean
]
