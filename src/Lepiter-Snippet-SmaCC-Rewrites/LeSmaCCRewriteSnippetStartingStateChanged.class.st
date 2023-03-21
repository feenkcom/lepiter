Class {
	#name : #LeSmaCCRewriteSnippetStartingStateChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'startingState'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Event'
}

{ #category : #accessing }
LeSmaCCRewriteSnippetStartingStateChanged >> startingState [
	^ startingState
]

{ #category : #accessing }
LeSmaCCRewriteSnippetStartingStateChanged >> startingState: aString [
	startingState := aString
]
