Class {
	#name : #LeExampleSnippetOptionalAttributesUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : 'Lepiter-Snippet-Example-Examples'
}

{ #category : #'examples - snippets' }
LeExampleSnippetOptionalAttributesUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet exampleBehaviorName 
		equals:'BlBasicExamples'.
	self 
		assert: targetSnippet exampleSelector 
		equals: #circle.
	self assert: targetSnippet codeExpanded equals: false.
	self assert: targetSnippet noCode equals: false.
	self assert: targetSnippet previewExpanded equals: false.
	self assert: targetSnippet previewShowSelector equals: #gtLiveFor:.
	self assert: targetSnippet previewHeight equals: 400
]

{ #category : #'examples - snippets' }
LeExampleSnippetOptionalAttributesUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeExampleSnippet new 
		exampleBehaviorName: 'BlBasicExamples';
		exampleSelector: #circle;
		codeExpanded: true;
		noCode: true;
		previewExpanded: true;
		previewShowSelector: #gtViewsFor:;
		previewHeight: 300
]

{ #category : #'examples - snippets' }
LeExampleSnippetOptionalAttributesUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet 
		codeExpanded: false;
		noCode: false;
		previewExpanded: false;
		previewShowSelector: #gtLiveFor:;
		previewHeight: 400
]
