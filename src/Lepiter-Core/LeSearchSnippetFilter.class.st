Class {
	#name : #LeSearchSnippetFilter,
	#superclass : #GtSearchTypedEntitiesFilter,
	#category : #'Lepiter-Core-Filters'
}

{ #category : #accessing }
LeSearchSnippetFilter class >> resultType [
	^ LeAsyncSearchSnippetGroupStream
]

{ #category : #accessing }
LeSearchSnippetFilter >> defaultFilterScope [
	^ LeDatabasesRegistry uniqueInstance defaultLogicalDatabase asyncAllSnippets
]

{ #category : #accessing }
LeSearchSnippetFilter >> matches: anObject [
	^ anObject isKindOf: LeSnippet
]
