Class {
	#name : #LeDatabaseIndexExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Index'
}

{ #category : #accessing }
LeDatabaseIndexExamples >> classSearch [
	<gtExample>
	| database snippets asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetClassReferencesTo: 'OrderedCollection'.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 3.
	^ asyncSnippets
]

{ #category : #accessing }
LeDatabaseIndexExamples >> database [
	<gtExample>
	| page pageUID database |
	database := LeDatabase new.

	page := LePage named: self pageTitle.
	database addPage: page.
	pageUID := page uid.

	page
		addSnippet: (LePharoSnippet new
				code: 'OrderedCollection withAll: {#printString. #Object. #''a b c''. #printOn:}').

	page addSnippet: (LePharoSnippet new code: '2 printString').

	page addSnippet: (LePharoSnippet new code: 'OrderedCollection new').

	page
		addSnippet: (LePharoSnippet new code: '(Smalltalk at: #OrderedCollection) new').


	self assert: (database pageWithID: pageUID) uid equals: pageUID.

	^ database
]

{ #category : #accessing }
LeDatabaseIndexExamples >> pageSendersSearch [
	<gtExample>
	| database pages asyncPages |
	database := self database.
	asyncPages := database asyncPageReferencesTo: #printString.
	pages := asyncPages asyncSimilarCopy toArray wait.
	self assert: pages size equals: 1.
	self
		assert: (database asyncPageReferencesTo: #with:) toArray wait size
		equals: 0.
	^ asyncPages
]

{ #category : #accessing }
LeDatabaseIndexExamples >> pageTitle [
	^ 'This is a test'
]

{ #category : #accessing }
LeDatabaseIndexExamples >> pageTitleSearch [
	<gtExample>
	| database titles asyncTitles |
	database := self database.
	asyncTitles := database index asyncTitlesForWord: 'te'.
	titles := asyncTitles asyncSimilarCopy toArray wait.
	self assert: titles size equals: 1.
	self assert: titles first equals: self pageTitle.
	^ asyncTitles
]

{ #category : #accessing }
LeDatabaseIndexExamples >> removePageUpdatesSearch [
	<gtExample>
	| database page asyncPages |
	database := self database.
	asyncPages := database asyncPageReferencesTo: #withAll:.
	page := asyncPages toArray wait first.
	page removeSelf.
	self
		assert: (database asyncSnippetReferencesTo: #printString) toArray wait size
		equals: 0.
	self assert: database index selectorCache size equals: 0.
	self assert: database index classCache size equals: 0.
	^ database
]

{ #category : #accessing }
LeDatabaseIndexExamples >> removeSnippetUpdatesSearch [
	<gtExample>
	| database snippet asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetReferencesTo: #withAll:.
	snippet := asyncSnippets toArray wait first.
	snippet removeSelf.
	self
		assert: (database asyncSnippetReferencesTo: #withAll:) toArray wait size
		equals: 0.
	asyncSnippets := database asyncSnippetReferencesTo: #printString.
	self assert: asyncSnippets asyncSimilarCopy toArray wait size equals: 1.
	^ asyncSnippets
]

{ #category : #accessing }
LeDatabaseIndexExamples >> sendersSearch [
	<gtExample>
	| database snippets asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetReferencesTo: #withAll:.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 1.
	self
		assert: (database asyncSnippetReferencesTo: #with:) toArray wait size
		equals: 0.
	self
		assert: (database asyncSnippetReferencesTo: #printString) toArray wait size
		equals: 2.
	^ asyncSnippets
]
