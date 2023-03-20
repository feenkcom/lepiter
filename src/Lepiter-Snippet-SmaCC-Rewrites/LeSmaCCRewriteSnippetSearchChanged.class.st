Class {
	#name : #LeSmaCCRewriteSnippetSearchChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'search'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Event'
}

{ #category : #accessing }
LeSmaCCRewriteSnippetSearchChanged >> search [
	^ search
]

{ #category : #accessing }
LeSmaCCRewriteSnippetSearchChanged >> search: aString [
	search := aString
]
