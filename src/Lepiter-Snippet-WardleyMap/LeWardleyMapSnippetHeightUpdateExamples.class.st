Class {
	#name : #LeWardleyMapSnippetHeightUpdateExamples,
	#superclass : #LeWardleyMapSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-WardleyMap-Examples'
}

{ #category : #'examples - snippets' }
LeWardleyMapSnippetHeightUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self 
		assert: aSnippet wardleyMap
		equals: self wardleyMapWithNode.
	self 
		assert: aSnippet height
		equals: 321
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetHeightUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeWardleyMapSnippet new
		wardleyMap: self wardleyMapWithNode
]

{ #category : #'examples - snippets' }
LeWardleyMapSnippetHeightUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet height: 321
]
