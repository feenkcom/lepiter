Class {
	#name : #LeSearchSnippetFilterExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Index'
}

{ #category : #accessing }
LeSearchSnippetFilterExamples >> astFilter [
	<gtExample>
	<return: #Array>
	| database snippets filter |
	database := self database.
	filter := LeSearchRBASTSnippetFilter sourceExpression: '`#l'.
	snippets := (database asyncAllSnippets select: [ :each | filter matches: each ])
			toArray wait.
	self assert: snippets size equals: 3.
	^ snippets
]

{ #category : #accessing }
LeSearchSnippetFilterExamples >> classFilter [
	<gtExample>
	<return: #GtSearchIntersectionFilter>
	| database snippets |
	database := self database.
	snippets := database leSnippetsInDB & OrderedCollection leReferences.
	self assert: snippets contents size equals: 3.
	^ snippets
]

{ #category : #accessing }
LeSearchSnippetFilterExamples >> database [
	| database |
	database := LeDatabaseIndexExamples new database.
	database asyncSnippetReferencesTo: #aaa.	"Make sure the index is computed"
	^ database
]

{ #category : #accessing }
LeSearchSnippetFilterExamples >> snippetsInDatabase [
	<gtExample>
	<return: #LeSearchDatabaseSnippetFilter>
	| database snippets |
	database := self database.
	snippets := database leSnippetsInDB.
	self assert: snippets contents size equals: database pages first children size.
	^ snippets
]

{ #category : #accessing }
LeSearchSnippetFilterExamples >> snippetsInPage [
	<gtExample>
	<return: #LeSearchPageSnippetFilter>
	| database snippets |
	database := self database.
	snippets := database pages first leSnippetsInPage.
	self assert: snippets contents size equals: database pages first children size.
	^ snippets
]

{ #category : #accessing }
LeSearchSnippetFilterExamples >> substringFilter [
	<gtExample>
	<return: #Array>
	| database snippets filter |
	database := self database.
	filter := LeSearchSubstringSnippetFilter substring: 'redcol'.
	snippets := (database asyncAllSnippets select: [ :each | filter matches: each ])
			toArray wait.
	self assert: snippets size equals: 3.
	^ snippets
]
