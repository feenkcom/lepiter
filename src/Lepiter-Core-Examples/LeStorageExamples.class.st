"
Examples to test equality and storeStrings for pages and snippets.
"
Class {
	#name : #LeStorageExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #accessing }
LeStorageExamples >> assertEqualsEvaluatedStoreString: anObject [

	"convenience method"

	self
		assert: (Smalltalk compiler evaluate: anObject storeString)
		equals: anObject
]

{ #category : #accessing }
LeStorageExamples >> emptyPharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: ''.
	self assertEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> emptyTextSnippet [

	<gtExample>
	| snippet |
	snippet := LeTextSnippet string: ''.
	self assertEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> pharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: '3+4'.
	self assertEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> pharoSnippetWithQuotes [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: '''hello world'''.
	self assertEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> textSnippet [
	<gtExample>
	|snippet|
	snippet := LeTextSnippet string: 'Everything is an object.'.
	self assertEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> textSnippetWithQuotes [
	<gtExample>
	|snippet|
	snippet := LeTextSnippet string: '''Everything'' is an ''object''.'.
	self assertEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> unnamedPageWithTextAndPharoSnippets [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: self textSnippet.
	page addSnippet: self pharoSnippet.
	self assertEqualsEvaluatedStoreString: page.
	^ page
]
