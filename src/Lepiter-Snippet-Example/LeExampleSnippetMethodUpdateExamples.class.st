Class {
	#name : #LeExampleSnippetMethodUpdateExamples,
	#superclass : #LeExampleSnippeUpdateExamples,
	#category : #'Lepiter-Snippet-Example-Examples'
}

{ #category : #asserting }
LeExampleSnippetMethodUpdateExamples >> assertModificationAnnouncements: anAnnouncementsCollection [

	self assert: anAnnouncementsCollection size equals: 2.
	
	self 
		assert: (anAnnouncementsCollection collect: #className) asArray 
		equals: #(
			LeExampleSnippetExampleBehaviorNameChanged
			LeExampleSnippetExampleSelectorChanged).
			
	self 
		assert: anAnnouncementsCollection first snippet exampleBehaviorName 
		equals: #BlElementBoundsExamples.
	self 
		assert: anAnnouncementsCollection second snippet exampleSelector 
		equals: #bounds.
]

{ #category : #asserting }
LeExampleSnippetMethodUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet exampleBehaviorName 
		equals:'BlElementBoundsExamples'.
	self 
		assert: targetSnippet exampleSelector 
		equals: #bounds
]

{ #category : #'examples - snippets' }
LeExampleSnippetMethodUpdateExamples >> createTargetSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: 'BlBasicExamples';
		exampleSelector: #circle
]

{ #category : #'examples - snippets' }
LeExampleSnippetMethodUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet 
		exampleBehaviorName: 'BlElementBoundsExamples';
		exampleSelector: #bounds
]
