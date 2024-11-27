Class {
	#name : #LeDatabaseExplicitGroupedItems,
	#superclass : #Object,
	#instVars : [
		'groupedItems'
	],
	#category : #'Lepiter-UI-! UI - Database'
}

{ #category : #computing }
LeDatabaseExplicitGroupedItems >> fromNavigationModel: aNavigationModel [
	^ groupedItems ifNil: [ #() ]
]

{ #category : #accessing }
LeDatabaseExplicitGroupedItems >> groupedItems [
	^ groupedItems
]

{ #category : #accessing }
LeDatabaseExplicitGroupedItems >> groupedItems: anObject [
	groupedItems := anObject
]
