Class {
	#name : #LeNullFilter,
	#superclass : #LeFilter,
	#category : 'Lepiter-Core-Database - Filters'
}

{ #category : #testing }
LeNullFilter >> matches: aLeContent [
	^ false
]
