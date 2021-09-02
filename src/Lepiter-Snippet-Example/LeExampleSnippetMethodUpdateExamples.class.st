Class {
	#name : 'LeExampleSnippetMethodUpdateExamples',
	#superclass : 'LeSingleSnippetUpdateExamples',
	#category : 'Lepiter-Snippet-Example-Examples'
}

{ #category : 'examples - snippets' }
LeExampleSnippetMethodUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet exampleBehaviorName 
		equals:'BlElementBoundsExamples'.
	self 
		assert: targetSnippet exampleSelector 
		equals: #bounds
]

{ #category : 'examples - snippets' }
LeExampleSnippetMethodUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeExampleSnippet new 
		exampleBehaviorName: 'BlBasicExamples';
		exampleSelector: #circle
]

{ #category : 'examples - snippets' }
LeExampleSnippetMethodUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet 
		exampleBehaviorName: 'BlElementBoundsExamples';
		exampleSelector: #bounds
]
