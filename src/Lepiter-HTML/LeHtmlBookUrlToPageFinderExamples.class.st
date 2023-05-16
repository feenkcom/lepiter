"
I exemplify {{gtClass:LeHtmlBookUrlToPageFinder}}. 
"
Class {
	#name : #LeHtmlBookUrlToPageFinderExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #accessing }
LeHtmlBookUrlToPageFinderExamples >> aboutPage [
	<gtExample>
	| anAsyncValue aPage |
	anAsyncValue := LeHtmlBookUrlToPageFinder new
			searchQuery: self aboutPageUrl;
			findPage.

	self
		assert: anAsyncValue isNotNil
		description: [ 'Async value value must be non-nil' ].

	anAsyncValue ifSome: [ :thePage | aPage := thePage ].

	self assert: aPage isNotNil description: [ 'Async value must have a page' ].

	self
		assert: aPage uid = (UUID fromString36: '6rr6j549v9j1fwztgzd4dzwjs')
		description: [ 'Unexpected page id: {1}' format: {aPage uid asString36} ].

	^ aPage
]

{ #category : #examples }
LeHtmlBookUrlToPageFinderExamples >> aboutPageUrl [
	<gtExample>
	^ 'https://book.gtoolkit.com/about-this-book-6rr6j549v9j1fwztgzd4dzwjs.html'
]

{ #category : #asserting }
LeHtmlBookUrlToPageFinderExamples >> assertMainPage: anAsyncValue [
	| aPage anID |
	self
		assert: anAsyncValue isNotNil
		description: [ 'Async value value must be non-nil' ].

	anAsyncValue ifSome: [ :thePage | aPage := thePage ].

	self 
		assert: aPage isNotNil 
		description: [ 'Async value must have a page' ].

	anID := UUID fromString36: '8w0nfqczshj1njxes11wuazjj'.
		
	self
		assert: aPage uid = anID
		description: [ 'Unexpected page id: {1}' 
			format: {aPage uid asString36} ].
			
	^ aPage
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinderExamples >> mainPageFromIndexHtml [
	<gtExample>
	| anAsyncValue aPage |
	anAsyncValue := LeHtmlBookUrlToPageFinder new
			searchQuery: 'https://book.gtoolkit.com/index.html';
			findPage.

	aPage := self assertMainPage: anAsyncValue.
			
	^ aPage
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinderExamples >> mainPageFromLatestIndexHtml [
	<gtExample>
	| anAsyncValue aPage |
	anAsyncValue := LeHtmlBookUrlToPageFinder new
			searchQuery: 'https://book.gtoolkit.com/latest/index.html';
			findPage.

	aPage := self assertMainPage: anAsyncValue.
			
	^ aPage
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinderExamples >> mainPageFromLatestRoot [
	<gtExample>
	| anAsyncValue aPage |
	anAsyncValue := LeHtmlBookUrlToPageFinder new
			searchQuery: 'https://book.gtoolkit.com/latest/';
			findPage.

	aPage := self assertMainPage: anAsyncValue.
			
	^ aPage
]

{ #category : #examples }
LeHtmlBookUrlToPageFinderExamples >> mainPageFromRoot [
	<gtExample>
	| anAsyncValue aPage |
	anAsyncValue := LeHtmlBookUrlToPageFinder new
			searchQuery: 'https://book.gtoolkit.com/';
			findPage.

	aPage := self assertMainPage: anAsyncValue.
			
	^ aPage
]
