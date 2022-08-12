Class {
	#name : #LePharoRewriteSnippetReplaceChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'replace'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Event'
}

{ #category : #accessing }
LePharoRewriteSnippetReplaceChanged >> replace [
	^ replace
]

{ #category : #accessing }
LePharoRewriteSnippetReplaceChanged >> replace: aString [
	replace := aString
]
