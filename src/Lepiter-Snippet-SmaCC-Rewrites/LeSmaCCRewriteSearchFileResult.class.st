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
LeSmaCCRewriteSearchFileResult >> gtDisplayOn: stream [
	stream 
		nextPutAll: self nodes items size asString;
		nextPutAll: ' nodes in '.
	file gtDisplayOn: stream.
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> gtNodesFor: aView [
	<gtView>
	^ aView list
		title: 'Nodes';
		items: [ self nodes ];
		itemText: [ :each | each source ]
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> nodes [
	^ nodes asyncSimilarCopy
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> nodes: anAsyncStream [
	nodes := anAsyncStream cached
]
