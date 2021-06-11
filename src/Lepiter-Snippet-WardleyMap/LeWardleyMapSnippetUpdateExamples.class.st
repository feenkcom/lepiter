Class {
	#name : #LeWardleyMapSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #'examples - snippets' }
LeWardleyMapSnippetUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self 
		assert: aSnippet wardleyMap
		equals: (GtWardleyMapModelExamples new newMap 
			addNode: self newWardleyMapNode)
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeWardleyMapSnippetExamples new emptySnippet
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet wardleyMap 
		addNode: self newWardleyMapNode.
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetUpdateExamples >> newWardleyMapNode [
	| node |
	node := GtWardleyMapNodeModelExamples new newNode.
	node coordinate: (0.25@0.75).
	node color: Color gray.
	node label: 'Node A'.
	node id: self nodeUUID.
	^ node
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetUpdateExamples >> nodeUUID [
	^ UUID fromString: '5c97622e-e180-0d00-93b3-e25f0cc8dc70'
]
