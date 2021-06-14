"
{{gtClass:LeSingleSnippetUpdateExamples}} provides utility methods for testing the change of a single snippet in a page.
"
Class {
	#name : #LeSingleSnippetUpdateExamples,
	#superclass : #LeSnippetUpdateExamples,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #testing }
LeSingleSnippetUpdateExamples class >> isAbstract [
	^ self = LeSingleSnippetUpdateExamples
]

{ #category : #'examples - snippets' }
LeSingleSnippetUpdateExamples >> addSnippetsInPage: targetPage [
	targetPage addSnippet: self createTargetSnippet.
]

{ #category : #'examples - snippets' }
LeSingleSnippetUpdateExamples >> assertSnippetModifiedFor: aSnippet [ 
	self subclassResponsibility
]

{ #category : #'examples - snippets' }
LeSingleSnippetUpdateExamples >> assertSnippetsModifiedInPage: aTargetPage [ 
	self assert: aTargetPage children size equals: 1.
	self assertSnippetModifiedFor: aTargetPage children first
]

{ #category : #'examples - snippets' }
LeSingleSnippetUpdateExamples >> createTargetSnippet [
	<gtExample>
	self subclassResponsibility
]

{ #category : #'examples - snippets' }
LeSingleSnippetUpdateExamples >> modifySnippet: aSnippet [ 
	self subclassResponsibility
]

{ #category : #'examples - snippets' }
LeSingleSnippetUpdateExamples >> modifySnippetsInPage: aTargetPage [
	self assert: aTargetPage children size equals: 1.
	self modifySnippet: aTargetPage children first.
]
