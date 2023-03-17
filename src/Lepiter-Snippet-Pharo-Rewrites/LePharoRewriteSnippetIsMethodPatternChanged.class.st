Class {
	#name : #LePharoRewriteSnippetIsMethodPatternChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'isMethodPattern'
	],
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Event'
}

{ #category : #accessing }
LePharoRewriteSnippetIsMethodPatternChanged >> isMethodPattern [
	^ isMethodPattern
]

{ #category : #accessing }
LePharoRewriteSnippetIsMethodPatternChanged >> isMethodPattern: aBoolean [
	isMethodPattern := aBoolean
]
