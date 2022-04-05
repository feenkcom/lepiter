"
Examples to test equality and storeStrings for pages and snippets.
"
Class {
	#name : #LeStorageExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #accessing }
LeStorageExamples >> assertGtBookPagesEqualEvaluatedStoreStrings [
	<gtExample>
	| gtBook |
	gtBook := self gtBook.
	gtBook pagesDo: [ :page | 
		LeStorageExamples new assertPageEqualsEvaluatedStoreString: page ].
	^ gtBook
]

{ #category : #accessing }
LeStorageExamples >> assertPageEqualsEvaluatedStoreString: aPage [

	"Workaround to avoid breaking = for pages."

	| pageSnippets restoredSnippets |
	pageSnippets := aPage children children.
	restoredSnippets := (Smalltalk compiler evaluate: aPage storeString)
		                    children children.
	self assert: restoredSnippets size equals: pageSnippets size.
	restoredSnippets withIndexDo: [ :snippet :n | 
		self assertSnippet: snippet equals: (pageSnippets at: n) ]
]

{ #category : #accessing }
LeStorageExamples >> assertSnippet: aSnippet equals: anotherSnippet [

	| children otherChildren |
	self
		assert: aSnippet contentAsString
		equals: anotherSnippet contentAsString.
	children := aSnippet children children.
	otherChildren := anotherSnippet children children.
	self assert: children size equals: otherChildren size.
	otherChildren withIndexDo: [ :snippet :n | 
		self assertSnippet: snippet equals: (children at: n) ]
]

{ #category : #accessing }
LeStorageExamples >> assertSnippetEqualsEvaluatedStoreString: aSnippet [

	self
		assertSnippet: (Smalltalk compiler evaluate: aSnippet storeString)
		equals: aSnippet
]

{ #category : #accessing }
LeStorageExamples >> emptyPharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: ''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> emptyTextSnippet [

	<gtExample>
	| snippet |
	snippet := LeTextSnippet string: ''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> gtBook [
	<gtExample>
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases 
		  detect: [ :db | db databaseName = 'Glamorous Toolkit Book' ]
]

{ #category : #accessing }
LeStorageExamples >> nestedTextSnippet [
	<gtExample>
	| snippet |
	snippet := self textSnippet.
	snippet addSnippet:
		(LeTextSnippet string: 'Everything happens by sending messages').
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> pharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: '3+4'.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> pharoSnippetWithQuotes [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: '''hello world'''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> textSnippet [
	<gtExample>
	|snippet|
	snippet := LeTextSnippet string: 'Everything is an object.'.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> textSnippetWithQuotes [
	<gtExample>
	|snippet|
	snippet := LeTextSnippet string: '''Everything'' is an ''object''.'.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> unnamedPageWithTextAndPharoSnippets [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: self textSnippet.
	page addSnippet: self pharoSnippet.
	self assertPageEqualsEvaluatedStoreString: page.
	^ page
]
