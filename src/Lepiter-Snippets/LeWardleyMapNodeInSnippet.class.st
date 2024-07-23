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
		object: [ self wardleyMapSnippetWithNodeHighlight];
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

{ #category : #accessing }
LeWardleyMapNodeInSnippet >> wardleyMapSnippetWithNodeHighlight [
	| aSnippet aSnippetViewModel aMapViewModel |
	aSnippet := self wardleyMapSnippet.
	aSnippetViewModel := aSnippet asSnippetViewModel.
	
	aMapViewModel := aSnippetViewModel wardleyMapViewModel.
	aMapViewModel 
		nodeViewModelFor: self node 
		ifFound: [ :aNodeViewModel | 
			"We do not add a decoration model since we do not want to see the same highlight in all snippet views."
			aNodeViewModel addWardleyMapDecoratorViewModel: GtWardleyMapHighlight new asDecoratorViewModel ] 
		ifNone: [ "ignore" ].

	^ aSnippetViewModel
]
