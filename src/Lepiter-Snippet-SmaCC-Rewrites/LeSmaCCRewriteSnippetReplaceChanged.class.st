Class {
	#name : #LeSmaCCRewriteSnippetReplaceChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'replace'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Event'
}

{ #category : #accessing }
LeSmaCCRewriteSnippetReplaceChanged >> replace [
	^ replace
]

{ #category : #accessing }
LeSmaCCRewriteSnippetReplaceChanged >> replace: aString [
	replace := aString
]
