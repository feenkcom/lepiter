Class {
	#name : #LeSmaCCRewriteReplaceResult,
	#superclass : #Object,
	#instVars : [
		'fileResultsStream'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Model'
}

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> fileResultsStream [
	^ fileResultsStream ifNotNil: [ fileResultsStream asyncSimilarCopy ]
]

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> fileResultsStream: anAsyncStream [
	fileResultsStream := anAsyncStream cached
]

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> gtResultListFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Files';
		items: [ self fileResultsStream ];
		column: 'File' text: [ :each | each file gtDisplayString ];
		column: 'Changed'
			text: [ :each | each hasChanges printString ]
			width: 100
]

{ #category : #accessing }
LeSmaCCRewriteReplaceResult >> gtResultsFor: aView [
	<gtView>
	^ aView list
		title: 'Changes';
		items: [ self fileResultsStream select: [ :each | each hasChanges ] ];
		itemStencil: [ BrVerticalPane new
				vFitContentLimited;
				hMatchParent;
				margin: (BlInsets all: 1);
				background: Color white ];
		itemDataBinder: [ :pane :each :i | 
			pane
				removeChildren;
				addChild: each asElementWithExpander ]
]
