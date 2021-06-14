Class {
	#name : #LePharoSnippetUpdateExamples,
	#superclass : #LeSingleSnippetUpdateExamples,
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #'examples - snippets' }
LePharoSnippetUpdateExamples >> assertSnippetModifiedFor: targetSnippet [
	self assert: targetSnippet code equals: '1+2+3'.
]

{ #category : #'examples - snippets' }
LePharoSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	^ LePharoSnippet code: '1+2'
]

{ #category : #'examples - snippets' }
LePharoSnippetUpdateExamples >> modifySnippet: aTargetSnippet [
	<gtExample>
	aTargetSnippet code: '1+2+3'.
	self 
		assert: aTargetSnippet code 
		equals: '1+2+3'.
	^ aTargetSnippet
]
