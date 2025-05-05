Class {
	#name : #LeWardleyMapSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #testing }
LeWardleyMapSnippetUpdateExamples class >> isAbstract [
	^ self = LeWardleyMapSnippetUpdateExamples
]

{ #category : #accessing }
LeWardleyMapSnippetUpdateExamples >> newWardleyMapNode [
	| node |
	node := GtWardleyMapNodeModelExamples new newNode.
	node coordinate: (0.25@0.75).
	node color: Color gray.
	node label: 'Node A'.
	node id: self nodeUUID.
	^ node
]

{ #category : #accessing }
LeWardleyMapSnippetUpdateExamples >> nodeUUID [
	^ UUID fromString: '5c97622e-e180-0d00-93b3-e25f0cc8dc70'
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetUpdateExamples >> wardleyMapWithNode [
	<gtExample>
	<return: #GtWardleyMapModel>
	^ GtWardleyMapModelExamples new newMap
		addNode: self newWardleyMapNode;
		yourself
]
