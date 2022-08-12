Class {
	#name : #LePharoRewriteSnippetSearchChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'search'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Event'
}

{ #category : #accessing }
LePharoRewriteSnippetSearchChanged >> search [
	^ search
]

{ #category : #accessing }
LePharoRewriteSnippetSearchChanged >> search: aString [
	search := aString
]
