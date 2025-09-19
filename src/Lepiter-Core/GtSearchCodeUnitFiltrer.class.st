Class {
	#name : #GtSearchCodeUnitFiltrer,
	#superclass : #GtSearchTypedEntitiesFilter,
	#instVars : [
		'codeFilters'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #accessing }
GtSearchCodeUnitFiltrer class >> resultType [
	^ GtAsyncSearchCodeUnitGroupStream
]

{ #category : #initialization }
GtSearchCodeUnitFiltrer >> defaultCodeFilters [
	^ #()
]

{ #category : #accessing }
GtSearchCodeUnitFiltrer >> defaultFilterScope [
	^ (codeFilters collect: [ :each |
		each defaultFilterScope ])
			asAsyncStream flatten
]

{ #category : #'as yet unclassified' }
GtSearchCodeUnitFiltrer >> highlighter [
	| highlighters |
	highlighters := (codeFilters collect: [ :each | each highlighter ]) 
		reject: [ :each | each isNil ].
	
	^ highlighters first
]

{ #category : #'as yet unclassified' }
GtSearchCodeUnitFiltrer >> leHighlighters [
	^ (codeFilters flatCollect: [ :each | each leHighlighters associations ]) asDictionary
]

{ #category : #testing }
GtSearchCodeUnitFiltrer >> matches: anObject [
	^ codeFilters anySatisfy: [ :each | each matches: anObject ]
]
