Class {
	#name : #LeSmaCCRewriteSearchFileResult,
	#superclass : #Object,
	#instVars : [
		'file',
		'nodes'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Model'
}

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> file [
	^ file
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> file: aFileReference [
	file := aFileReference
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> nodes [
	^ nodes asyncSimilarCopy
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> nodes: anAsyncStream [
	nodes := anAsyncStream cached
]
