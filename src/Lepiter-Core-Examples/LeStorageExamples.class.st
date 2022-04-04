"
Examples to test equality and storeStrings for pages and snippets.
"
Class {
	#name : #LeStorageExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Content'
}

{ #category : #accessing }
LeStorageExamples >> emptyPharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: ''.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> emptyTextSnippet [
	<gtExample>
	|snippet|
	snippet := LeTextSnippet string: ''.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> equalEmptyTextSnippets [
	"NB: text snippet equality uses equality of the strings, not the roped texts, because BlText doesn't (yet) implement equality."
	<gtExample>
	| snippet1 snippet2 |
	snippet1 := self emptyTextSnippet.
	snippet2 := self emptyTextSnippet.
	self assert: snippet1 equals: snippet2.
	^ snippet1
]

{ #category : #accessing }
LeStorageExamples >> equalPages [
	<gtExample>
	|page1 page2|
	page1 := self unnamedPageWithTextAndPharoSnippets.
	page2 := self unnamedPageWithTextAndPharoSnippets.
	self assert: page1 equals: page2.
	^ page1
]

{ #category : #accessing }
LeStorageExamples >> equalPharoSnippets [
	<gtExample>
	|snippet1 snippet2|
	snippet1 := self pharoSnippet.
	snippet2 := self pharoSnippet.
	self assert: snippet1 equals: snippet2.
	^ snippet1
]

{ #category : #accessing }
LeStorageExamples >> equalTextSnippets [
	"NB: text snippet equality uses equality of the strings, not the roped texts, because BlText doesn't (yet) implement equality."
	<gtExample>
	| snippet1 snippet2 |
	snippet1 := self textSnippet.
	snippet2 := self textSnippet.
	self assert: snippet1 equals: snippet2.
	^ snippet1
]

{ #category : #accessing }
LeStorageExamples >> pharoSnippet [
	<gtExample>
	|snippet|
	snippet := LePharoSnippet code: '3+4'.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> storageEqualitEmptyTextSnippets [
	<gtExample>
	| snippet1 snippet2 |
	snippet1 := self textSnippet.
	snippet2 := Smalltalk compiler evaluate: snippet1 storeString.
	self assert: snippet1 equals: snippet2.
	^ snippet1
]

{ #category : #accessing }
LeStorageExamples >> storageEqualityPages [
	<gtExample>
	| page1 page2 |
	page1 := self unnamedPageWithTextAndPharoSnippets.
	page2 := Smalltalk compiler evaluate: page1 storeString.
	self assert: page1 equals: page2.
	^ page1
]

{ #category : #accessing }
LeStorageExamples >> storageEqualityPharoSnippets [
	<gtExample>
	| snippet1 snippet2 |
	snippet1 := self pharoSnippet.
	snippet2 := Smalltalk compiler evaluate: snippet1 storeString.
	self assert: snippet1 equals: snippet2.
	^ snippet1
]

{ #category : #accessing }
LeStorageExamples >> storageEqualityTextSnippets [
	<gtExample>
	| snippet1 snippet2 |
	snippet1 := self textSnippet.
	snippet2 := Smalltalk compiler evaluate: snippet1 storeString.
	self assert: snippet1 equals: snippet2.
	^ snippet1
]

{ #category : #accessing }
LeStorageExamples >> textSnippet [
	<gtExample>
	|snippet|
	snippet := LeTextSnippet string: 'Everything is an object.'.
	^ snippet
]

{ #category : #accessing }
LeStorageExamples >> unnamedPageWithTextAndPharoSnippets [
	<gtExample>
	| page |
	page := LePage unnamedPage.
	page addSnippet: self textSnippet.
	page addSnippet: self pharoSnippet.
	^ page
]
