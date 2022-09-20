Class {
	#name : #LePharoRewriteSnippetScopeChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'scope'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Event'
}

{ #category : #accessing }
LePharoRewriteSnippetScopeChanged >> scope [
	^ scope
]

{ #category : #accessing }
LePharoRewriteSnippetScopeChanged >> scope: aString [
	scope := aString
]
