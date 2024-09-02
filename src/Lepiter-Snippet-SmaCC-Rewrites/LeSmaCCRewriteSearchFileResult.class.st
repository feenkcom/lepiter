Class {
	#name : #LeSmaCCRewriteSearchFileResult,
	#superclass : #Object,
	#instVars : [
		'file',
		'nodes',
		'owner'
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
LeSmaCCRewriteSearchFileResult >> gtLSPFileFor: aView [
	<gtView>
	| lspFile |
	lspFile := (self owner ifNotNil: [ self owner lspModel ])
			ifNotNil: [ :model | model existingOrCreatefileFor: file ].
	lspFile ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'File';
		priority: 60;
		object: [ lspFile ];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> gtNodesFor: aView [
	<gtView>
	| lspFile |
	lspFile := (self owner ifNotNil: [ self owner lspModel ])
			ifNotNil: [ :model | model existingOrCreatefileFor: file ].
	^ aView list
		title: 'Nodes';
		items: [ self nodes ];
		itemText: [ :each | each source ];
		send: [ :each | 
			lspFile
				ifNil: [ each ]
				ifNotNil: [ GtLSPFileLocation new
						lspFile: lspFile;
						start: each startPosition;
						end: each stopPosition;
						yourself ] ]
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> nodes [
	^ nodes asyncSimilarCopy
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> nodes: anAsyncStream [
	nodes := anAsyncStream cached
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> owner [
	^ owner
]

{ #category : #accessing }
LeSmaCCRewriteSearchFileResult >> owner: aSearchResult [
	owner := aSearchResult
]
