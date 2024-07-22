Class {
	#name : #LeWardleyMapNodeInSnippet,
	#superclass : #Object,
	#instVars : [
		'node',
		'wardleyMapSnippet'
	],
	#category : #'Lepiter-Snippets'
}

{ #category : #accessing }
LeWardleyMapNodeInSnippet >> gtLiveFor: aView [
	<gtView>
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ self wardleyMapSnippet];
		view: #gtLiveFor:
]

{ #category : #accessing }
LeWardleyMapNodeInSnippet >> node [
	^ node
]

{ #category : #accessing }
LeWardleyMapNodeInSnippet >> node: aNode [ 
	node := aNode
]

{ #category : #accessing }
LeWardleyMapNodeInSnippet >> wardleyMapSnippet [
	^ wardleyMapSnippet
]

{ #category : #accessing }
LeWardleyMapNodeInSnippet >> wardleyMapSnippet: aSnippet [ 
	wardleyMapSnippet := aSnippet
]
