Class {
	#name : #LeChangesSnippetHeightUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Snippet-Changes-Examples'
}

{ #category : #'examples - snippets' }
LeChangesSnippetHeightUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self 
		assert: targetSnippet previewHeight 
		equals: 330
]

{ #category : #'examples - snippets' }
LeChangesSnippetHeightUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LeChangesSnippet new
		fileName:  'test.ombu';
		previewHeight: 220
]

{ #category : #'examples - snippets' }
LeChangesSnippetHeightUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	^ aTargetSnippet 
		previewHeight: 330
]
