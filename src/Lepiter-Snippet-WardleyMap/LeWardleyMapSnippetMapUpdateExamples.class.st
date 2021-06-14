Class {
	#name : #LeWardleyMapSnippetMapUpdateExamples,
	#superclass : #LeWardleyMapSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self 
		assert: aSnippet wardleyMap
		equals: self wardleyMapWithNode.
	self 
		assert: aSnippet height
		equals: LeWardleyMapSnippet defaultHeight
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeWardleyMapSnippetExamples new emptySnippet
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetMapUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet wardleyMap 
		addNode: self newWardleyMapNode.
]
