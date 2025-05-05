Class {
	#name : #LePharoSnippetsMergingExamples,
	#superclass : #Object,
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #examples }
LePharoSnippetsMergingExamples >> cannotMergePharoSnippetIntoTextSnippet [
	<gtExample>
	<return: #LePage>
	| page textSnippetTwo codeSnippetThree |
	page := LePharoSnippetExamples new pageWithCodeAndTextSnippets.

	textSnippetTwo := page children at: 2.
	codeSnippetThree := page children at: 3.
	codeSnippetThree mergeWithPrevious.

	self assert: page childrenCount equals: 4.

	self assert: codeSnippetThree childrenCount equals: 0.
	self assert: textSnippetTwo string equals: '2'.
	self assert: codeSnippetThree code equals: '3.'.

	^ page
]

{ #category : #examples }
LePharoSnippetsMergingExamples >> cannotMergeTextSnippetIntoPharoSnippet [
	<gtExample>
	<return: #LePage>
	| page textSnippetTwo codeSnippetOne |
	page := LePharoSnippetExamples new pageWithCodeAndTextSnippets.

	codeSnippetOne := page children at: 1.
	textSnippetTwo := page children at: 2.

	textSnippetTwo mergeWithPrevious.

	self assert: page childrenCount equals: 4.

	self assert: codeSnippetOne childrenCount equals: 0.
	self assert: codeSnippetOne code equals: '1.'.
	self assert: textSnippetTwo string equals: '2'.

	^ page
]

{ #category : #examples }
LePharoSnippetsMergingExamples >> mergeSiblingInPreviousSibling [
	<gtExample>
	<return: #LePage>
	| page snippetOne snippetTwo snippetThree |
	page := LePharoSnippetExamples new pageWithPharoSnippets.

	snippetOne := page children at: 1.
	self assert: snippetOne childrenCount equals: 0.

	snippetTwo := page children at: 2.
	snippetThree := page children at: 3.
	snippetTwo mergeWithPrevious.

	self assert: page childrenCount equals: 3.

	self assert: snippetOne childrenCount equals: 0.
	self assert: snippetOne code equals: '1.2.'.
	self assert: snippetThree code equals: '3.'.

	^ page
]
