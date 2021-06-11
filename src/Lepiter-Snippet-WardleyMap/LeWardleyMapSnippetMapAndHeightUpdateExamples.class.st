Class {
	#name : #LeWardleyMapSnippetMapAndHeightUpdateExamples,
	#superclass : #LeWardleyMapSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapAndHeightUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self 
		assert: aSnippet wardleyMap
		equals: self wardleyMapWithNode.
	self 
		assert: aSnippet height
		equals: 321
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapAndHeightUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeWardleyMapSnippetExamples new emptySnippet
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapAndHeightUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet wardleyMap 
		addNode: self newWardleyMapNode.
	aSnippet height: 321
]
