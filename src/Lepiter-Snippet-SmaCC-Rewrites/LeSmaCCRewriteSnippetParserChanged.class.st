Class {
	#name : #LeSmaCCRewriteSnippetParserChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'parser'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Event'
}

{ #category : #accessing }
LeSmaCCRewriteSnippetParserChanged >> parser [
	^ parser
]

{ #category : #accessing }
LeSmaCCRewriteSnippetParserChanged >> parser: aSymbol [
	parser := aSymbol
]
