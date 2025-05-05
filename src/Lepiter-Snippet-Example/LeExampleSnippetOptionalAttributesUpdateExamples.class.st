Class {
	#name : #LeExampleSnippetOptionalAttributesUpdateExamples,
	#superclass : #LeExampleSnippeUpdateExamples,
	#category : #'Lepiter-Snippet-Example-Examples'
}

{ #category : #'examples - snippets' }
LeExampleSnippetOptionalAttributesUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [

	self assert: anAnnouncementsCollection size equals: 5.
	
	self 
		assert: (anAnnouncementsCollection collect: #className) asArray 
		equals: #(
			LeExampleSnippetCodeExpandedChanged
			LeExampleSnippetNoCodeChanged
			LeExampleSnippetPreviewExpandedChanged
			LeExampleSnippetPreviewShowSelectorChanged
			LeExampleSnippetPreviewHeightChanged).
			
	self 
		assert: anAnnouncementsCollection first snippet codeExpanded 
		equals: false.
	self 
		assert: anAnnouncementsCollection second snippet noCode 
		equals: false.
	self 
		assert: anAnnouncementsCollection third snippet previewExpanded 
		equals: false.
	self 
		assert: anAnnouncementsCollection fourth snippet previewShowSelector 
		equals: #gtLiveFor:.
	self 
		assert: anAnnouncementsCollection fifth snippet previewHeight 
		equals: 400.
]

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
	<return: #LeExampleSnippet>
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
