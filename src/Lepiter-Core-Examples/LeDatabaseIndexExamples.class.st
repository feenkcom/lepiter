Class {
	#name : #LeDatabaseIndexExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Index'
}

{ #category : #accessing }
LeDatabaseIndexExamples >> classSearch [
	<gtExample>
	<return: #AsyncWithoutDuplicatesStream>
	| database snippets asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetClassReferencesTo: 'OrderedCollection'.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 3.
	^ asyncSnippets
]

{ #category : #accessing }
LeDatabaseIndexExamples >> gtClassSearch [
	<gtExample>
	<return: #AsyncWithoutDuplicatesStream>
	| database snippets asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetClassReferencesTo: #Object.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 2.
	^ asyncSnippets
]

{ #category : #accessing }
LeDatabaseIndexExamples >> gtExampleSearch [
	<gtExample>
	<return: #AsyncSequenceStream>
	| database snippets asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetClassReferencesTo: self class name.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 1.
	asyncSnippets := database asyncSnippetReferencesTo: #database.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 1.
	^ asyncSnippets
]

{ #category : #accessing }
LeDatabaseIndexExamples >> gtMethodSearch [
	<gtExample>
	<return: #AsyncSequenceStream>
	| database snippets asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetClassReferencesTo: #Set.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 1.
	asyncSnippets := database asyncSnippetReferencesTo: #grow.
	snippets := asyncSnippets asyncSimilarCopy toArray wait.
	self assert: snippets size equals: 1.
	^ asyncSnippets
]

{ #category : #accessing }
LeDatabaseIndexExamples >> pageSendersSearch [
	<gtExample>
	<return: #AsyncWithoutDuplicatesStream>
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
	<return: #AsyncWithoutDuplicatesStream>
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
	<return: #LeDatabase>
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
	<return: #AsyncSequenceStream>
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
	<return: #AsyncSequenceStream>
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

{ #category : #accessing }
LeDatabaseIndexExamples >> updateSnippetUpdatesSearch [
	<gtExample>
	<return: #AsyncSequenceStream>
	| database snippet asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetReferencesTo: #withAll:.
	snippet := asyncSnippets toArray wait first.
	snippet
		updateString: 'OrderedCollection with: {#printString. #Object. #''a b c''. #printOn:}'.
	self
		assert: (database asyncSnippetReferencesTo: #withAll:) toArray wait size
		equals: 0.
	self
		assert: (database asyncSnippetReferencesTo: #with:) toArray wait size
		equals: 1.
	asyncSnippets := database asyncSnippetReferencesTo: #printString.
	self assert: asyncSnippets asyncSimilarCopy toArray wait size equals: 2.
	^ asyncSnippets
]

{ #category : #accessing }
LeDatabaseIndexExamples >> updateTextSnippetUpdatesSearch [
	<gtExample>
	<return: #AsyncSequenceStream>
	| database snippet asyncSnippets |
	database := self database.
	asyncSnippets := database asyncSnippetReferencesTo: #database.
	snippet := asyncSnippets toArray wait first.
	snippet updateString: 'This is a test'.
	self
		assert: (database asyncSnippetReferencesTo: #database) toArray wait size
		equals: 0.
	self
		assert: (database asyncSnippetClassReferencesTo: #Object) toArray wait size
		equals: 1.
	^ asyncSnippets
]
