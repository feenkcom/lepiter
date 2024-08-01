Class {
	#name : #LeSearchSnippetFilterExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Index'
}

{ #category : #accessing }
LeSearchSnippetFilterExamples >> classFilter [
	<gtExample>
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
	| database snippets |
	database := self database.
	snippets := database leSnippetsInDB.
	self assert: snippets contents size equals: database pages first children size.
	^ snippets
]

{ #category : #accessing }
LeSearchSnippetFilterExamples >> snippetsInPage [
	<gtExample>
	| database snippets |
	database := self database.
	snippets := database pages first leSnippetsInPage.
	self assert: snippets contents size equals: database pages first children size.
	^ snippets
]
