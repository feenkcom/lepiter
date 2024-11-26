Class {
	#name : #LePageEmptyViewModel,
	#superclass : #Object,
	#instVars : [
		'originalDatabase'
	],
	#category : #'Lepiter-UI-Page-! View Models'
}

{ #category : #accessing }
LePageEmptyViewModel >> originalDatabase [
	<return: #LeDatabase>
	^ originalDatabase
]

{ #category : #accessing }
LePageEmptyViewModel >> originalDatabase: aLeDatabase [
	originalDatabase := aLeDatabase
]
