Class {
	#name : #LeSearchDatabaseSnippetFilter,
	#superclass : #LeSearchSnippetFilter,
	#instVars : [
		'database'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'instance creation' }
LeSearchDatabaseSnippetFilter class >> forDatabase: aDatabase [
	^ self new database: aDatabase
]

{ #category : #comparing }
LeSearchDatabaseSnippetFilter >> = anObject [
	^ self class = anObject class and: [ self database = anObject database ]
]

{ #category : #accessing }
LeSearchDatabaseSnippetFilter >> database [
	^ database
]

{ #category : #accessing }
LeSearchDatabaseSnippetFilter >> database: anObject [
	database := anObject
]

{ #category : #accessing }
LeSearchDatabaseSnippetFilter >> defaultFilterScope [
	^ self database asyncAllSnippets
]

{ #category : #accessing }
LeSearchDatabaseSnippetFilter >> gtDisplayOn: stream [
	stream nextPutAll: 'All snippets in '.
	self database gtDisplayOn: stream
]

{ #category : #comparing }
LeSearchDatabaseSnippetFilter >> hash [
	^ self class hash bitXor: self database hash
]

{ #category : #accessing }
LeSearchDatabaseSnippetFilter >> matches: anObject [
	(anObject isKindOf: LeSnippet) ifFalse: [ ^ false ].
	^ anObject database = self database
]
