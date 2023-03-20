Class {
	#name : #LeSmaCCRewriteSnippetScopeChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'scope'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Event'
}

{ #category : #accessing }
LeSmaCCRewriteSnippetScopeChanged >> scope [
	^ scope
]

{ #category : #accessing }
LeSmaCCRewriteSnippetScopeChanged >> scope: aString [
	scope := aString
]
