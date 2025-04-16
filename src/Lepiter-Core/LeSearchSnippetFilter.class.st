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
		column: 'Database' do: [ :aColumn |
			aColumn
				cellStencil: [ 
					GtPhlowLabelWithIcon new ];
				dataBinder: [ :anElement :assoc | 
					anElement 
						initializeWithIcon: LeIcons lepiterDatabase
						label: (assoc key 
							ifNil: [ '' ] 
							ifNotNil: [ :each | each databaseName ] ) ] ];
		column: 'Items' text: [ :assoc | assoc value size ];
		send: [ :assoc | 
			self & (LeSearchDatabaseSnippetFilter forDatabase: assoc key) ]
]

{ #category : #accessing }
LeSearchSnippetFilter >> gtItemsByPageFor: aView [
	<gtView>
	<gtToolView>
	^ aView columnedList
		title: 'By Page';
		priority: 45;
		items: [ (self result asyncSimilarCopy toArray wait
				groupedBy: [ :each | each page ]) associations
				sorted: [ :assoc | assoc key 
					ifNil: [ '' ] 
					ifNotNil: [ :each | each title ] ]
						ascending ];
		column: 'Page' do: [ :aColumn |
			aColumn
				cellStencil: [ 
					GtPhlowLabelWithIcon new ];
				dataBinder: [ :anElement :assoc | 
					anElement 
						initializeWithIcon: LeIcons lepiterPage
						label: (assoc key 
							ifNil: [ '' ] 
							ifNotNil: [ :each | each title ] ) ] ];
		column: 'Items' text: [ :assoc | assoc value size ];
		send: [ :assoc | self & (LeSearchPageSnippetFilter forPage:  assoc key) ]
]

{ #category : #accessing }
LeSearchSnippetFilter >> matches: anObject [
	^ anObject isKindOf: LeSnippet
]
