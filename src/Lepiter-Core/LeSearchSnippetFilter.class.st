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
LeSearchSnippetFilter >> gtItemsByDatabaseFor: aView [
	<gtView>
	<gtToolView>
	^ aView columnedList
		title: 'By Database';
		priority: 43;
		items: [ (self result asyncSimilarCopy toArray wait
				groupedBy: [ :each | each database ]) associations
				sorted: [ :assoc | assoc key ifNil: [ '' ] ifNotNil: [ :each | each databaseName ] ]
						ascending ];
		column: 'Database'
			text: [ :assoc | assoc key ifNil: [ '' ] ifNotNil: [ :each | each databaseName ] ];
		column: 'Items' text: [ :assoc | assoc value size ];
		send: [ :assoc | self & (LeSearchDatabaseSnippetFilter forDatabase: assoc key) ]
]

{ #category : #accessing }
LeSearchSnippetFilter >> matches: anObject [
	^ anObject isKindOf: LeSnippet
]
