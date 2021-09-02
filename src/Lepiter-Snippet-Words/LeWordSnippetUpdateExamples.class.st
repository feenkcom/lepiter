Class {
	#name : 'LeWordSnippetUpdateExamples',
	#superclass : 'LeSingleSnippetUpdateExamples',
	#category : 'Lepiter-Snippet-Words-Examples'
}

{ #category : 'examples - snippets' }
LeWordSnippetUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self assert: aSnippet word equals: 'hello2'
]

{ #category : 'examples - snippets' }
LeWordSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeWordExamples new snippetWithExplanation
]

{ #category : 'examples - snippets' }
LeWordSnippetUpdateExamples >> modifySnippet: aSnippet [ 
	aSnippet word: 'hello2'
]
