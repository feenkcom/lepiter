Class {
	#name : #GtSearchCodeUnitReferencesFilter,
	#superclass : #GtSearchCodeUnitFiltrer,
	#instVars : [
		'snippetsFilter',
		'methodsFilter',
		'object'
	],
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'instance  creation' }
GtSearchCodeUnitReferencesFilter class >> literal: aLiteral [
	^ self new 
		initializeWithLiteral: aLiteral
]

{ #category : #'gt extensions' }
GtSearchCodeUnitReferencesFilter >> gtItemsByDatabaseFor: aView [
	<gtView>
	<gtToolView>
	
	^ aView forward
		title: 'By Database';
		priority: 45;
		object: [ snippetsFilter ];
		view: #gtItemsByDatabaseFor:
]

{ #category : #'gt extensions' }
GtSearchCodeUnitReferencesFilter >> gtItemsByPageFor: aView [
	<gtView>
	<gtToolView>
	
	^ aView forward
		title: 'By Page';
		object: [ snippetsFilter ];
		view: #gtItemsByPageFor:
]

{ #category : #initialization }
GtSearchCodeUnitReferencesFilter >> initializeWithLiteral: aLiteral [
	object := aLiteral.
	snippetsFilter := LeSearchReferencesFilter selector: aLiteral.
	methodsFilter := GtSearchReferencesFilter literal: aLiteral.
	
	codeFilters := { snippetsFilter. methodsFilter }
]

{ #category : #printing }
GtSearchCodeUnitReferencesFilter >> printOn: stream [
	stream print: object.
	stream nextPutAll: ' method/snippet references'.
]
