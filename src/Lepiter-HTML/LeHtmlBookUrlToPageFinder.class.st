"
For a given {{gtMethod:LeHtmlBookUrlToPageFinder >> #searchQuery: | label=URL}}, I provide a {{gtClass:LePage}} instance.
#Example
For the following {{gtExample: LeHtmlBookUrlToPageFinderExamples>>#aboutPageUrl | label=#yourself}} URL, the finder identifies the following page: {{gtExample: LeHtmlBookUrlToPageFinderExamples >> #aboutPage | codeExpanded=false | previewExpanded=true}}
"
Class {
	#name : #LeHtmlBookUrlToPageFinder,
	#superclass : #Object,
	#instVars : [
		'spotterContext',
		'database',
		'searchQuery'
	],
	#category : #'Lepiter-HTML-Helpers'
}

{ #category : #accessing }
LeHtmlBookUrlToPageFinder >> database [
	<return: #LeDatabase>
	^ database ifNil: [ database := LeDatabasesRegistry defaultLogicalDatabase ]
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinder >> database: aLeDatabase [
	database := aLeDatabase
]

{ #category : #'api - finding' }
LeHtmlBookUrlToPageFinder >> find [
	<return: #TAsyncStream>
	^ AsyncMaybeOnceStream 
		forFuture: [ self findPage ] asAsyncFuture
]

{ #category : #'api - finding' }
LeHtmlBookUrlToPageFinder >> findPage [
	<return: #AsyncOptionalValue>
	| aSearchQuery anUrl aRegex aPageIdString36 aPageId aLastSegment |
	aSearchQuery := searchQuery trimBoth.

	(aSearchQuery includesSubstring: 'book.gtoolkit.com')
		ifFalse: [ ^ AsyncOptionalValue none ].

	anUrl := aSearchQuery asZnUrl.
	aLastSegment := anUrl lastPathSegment.
	
	(#($/ 'index.html' nil) includes: aLastSegment)
		ifTrue: [ ^ self mainPage ].
	
	(aLastSegment endsWith: '.html' caseSensitive: false)
		ifFalse: [ ^ AsyncOptionalValue none ].

	aRegex := '^.*-([^-]*)\.html$' asRegex.

	(aRegex matches: aLastSegment) 
		ifFalse: [ ^ AsyncOptionalValue none ].

	aRegex subexpressionCount = 2 
		ifFalse: [ ^ AsyncOptionalValue none ].

	aPageIdString36 := aRegex subexpression: 2.

	aPageId := UUID fromString36: aPageIdString36.

	self database pagesDo: [ :aPage | 
		aPage uid = aPageId ifTrue: [ 
			^ AsyncOptionalValue some: aPage ] ].

	^ AsyncOptionalValue none
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinder >> mainPage [
	<return: #AsyncOptionalValue>

	| aPageId |
	aPageId := UUID fromString36: '8w0nfqczshj1njxes11wuazjj'.
	
	self database pagesDo: [ :aPage | 
		aPage uid = aPageId ifTrue: [ 
			^ AsyncOptionalValue some: aPage ] ].

	^ AsyncOptionalValue none
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinder >> searchQuery [
	<return: #String>
	^ searchQuery
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinder >> searchQuery: aString [
	searchQuery := aString
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinder >> spotterContext [
	<return: #GtSpotterContext>
	^ spotterContext
]

{ #category : #accessing }
LeHtmlBookUrlToPageFinder >> spotterContext: aGtSpotterContext [
	spotterContext := aGtSpotterContext.
	searchQuery := spotterContext searchQuery
]
