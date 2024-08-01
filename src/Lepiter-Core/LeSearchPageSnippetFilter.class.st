Class {
	#name : #LeSearchPageSnippetFilter,
	#superclass : #LeSearchSnippetFilter,
	#instVars : [
		'page'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'instance creation' }
LeSearchPageSnippetFilter class >> forPage: aPage [
	^ self new page: aPage
]

{ #category : #comparing }
LeSearchPageSnippetFilter >> = anObject [
	^ self class = anObject class and: [ self page = anObject page ]
]

{ #category : #accessing }
LeSearchPageSnippetFilter >> defaultFilterScope [
	^ self page asyncAllSnippets
]

{ #category : #accessing }
LeSearchPageSnippetFilter >> gtDisplayOn: stream [
	stream nextPutAll: 'All snippets in '.
	self page gtDisplayOn: stream
]

{ #category : #comparing }
LeSearchPageSnippetFilter >> hash [
	^ self class hash bitXor: self page hash
]

{ #category : #accessing }
LeSearchPageSnippetFilter >> matches: anObject [
	(anObject isKindOf: LeSnippet) ifFalse: [ ^ false ].
	^ anObject page = self page
]

{ #category : #accessing }
LeSearchPageSnippetFilter >> page [
	^ page
]

{ #category : #accessing }
LeSearchPageSnippetFilter >> page: anObject [
	page := anObject
]
