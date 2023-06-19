Class {
	#name : #LeCompositeFilter,
	#superclass : #LeFilter,
	#instVars : [
		'left',
		'right'
	],
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #accessing }
LeCompositeFilter >> left [
	^ left
]

{ #category : #accessing }
LeCompositeFilter >> left: aLeFilter [
	left := aLeFilter
]

{ #category : #accessing }
LeCompositeFilter >> right [
	^ right
]

{ #category : #accessing }
LeCompositeFilter >> right: aLeFilter [
	right := aLeFilter
]
