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
	<noTest>
	| gtBook |
	gtBook := self gtBook.
	gtBook pagesDo: [ :page | 
		self assertPageEqualsEvaluatedStoreString: page ].
	^ gtBook
]

{ #category : #accessing }
LeStorageExamples >> assertPageEqualsEvaluatedStoreString: aPage [

	"Workaround to avoid breaking = for pages."

	| pageSnippets restoredSnippets result |
	result := Smalltalk compiler evaluate: aPage storeString.
	pageSnippets := aPage children children.
	restoredSnippets := result children children.
	self assert: restoredSnippets size equals: pageSnippets size.
	restoredSnippets withIndexDo: [ :snippet :n | 
		self assertSnippet: snippet equals: (pageSnippets at: n) ].
	^ result
]

{ #category : #accessing }
LeStorageExamples >> assertSnippet: aSnippet equals: anotherSnippet [

	"NB: This is probably not an adequate test as there is more to a snippet than its contentAsString. 
	Unfortunately we cannot implement = for LeContent subclasses because that would break the importer."

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

	| result |
	result := Smalltalk compiler evaluate: aSnippet storeString.
	self assertSnippet: result equals: aSnippet.
	^ result
]

{ #category : #accessing }
LeStorageExamples >> emptyTextSnippet [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet string: ''.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> gtBook [
	<gtExample>
	<noTest>
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase databases 
		  detect: [ :db | db databaseName = 'Glamorous Toolkit Book' ]
]

{ #category : #accessing }
LeStorageExamples >> nestedTextSnippet [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := self textSnippet.
	snippet
		addSnippet: (LeTextSnippet string: 'Everything happens by sending messages').
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> textSnippet [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet string: 'Everything is an object.'.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> textSnippetWithQuotes [
	<gtExample>
	<return: #LeTextSnippet>
	| snippet |
	snippet := LeTextSnippet string: '''Everything'' is an ''object''.'.
	self assertSnippetEqualsEvaluatedStoreString: snippet.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> unnamedPageWithTextAndPharoSnippets [
	<gtExample>
	<return: #LePage>
	| page |
	page := LePage unnamedPage.
	page addSnippet: self textSnippet.
	page addSnippet: self pharoSnippet.
	self assertPageEqualsEvaluatedStoreString: page.
	^ page
]
