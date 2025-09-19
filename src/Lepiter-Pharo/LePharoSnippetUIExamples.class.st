Class {
	#name : #LePharoSnippetUIExamples,
	#superclass : #Object,
	#traits : 'TLeSpaceExamples + TAssertable',
	#classTraits : 'TLeSpaceExamples classTrait + TAssertable classTrait',
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #'examples - basic' }
LePharoSnippetUIExamples >> basicDatabase [
	<gtExample>
	<return: #LeDatabase>
	| aDatabase |
	aDatabase := LeDatabase new.
	self assert: aDatabase size equals: 0.
	^ aDatabase
]

{ #category : #examples }
LePharoSnippetUIExamples >> snippet [
	<gtExample>
	<return: #LePharoSnippet>
	^ LePharoSnippet new code: '42 inspect'
]

{ #category : #examples }
LePharoSnippetUIExamples >> treeNodeElement [
	<gtExample>
	<return: #LePharoSnippetElement>
	| aSnippet aSnippetUIModel aSnippetElement |
	aSnippet := self snippet.
	aSnippetUIModel := aSnippet asSnippetViewModel.
	aSnippetElement := aSnippetUIModel snippetElementClass new.
	aSnippetElement snippetViewModel: aSnippetUIModel.

	^ aSnippetElement
]
