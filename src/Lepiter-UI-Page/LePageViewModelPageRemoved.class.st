Class {
	#name : #LePageViewModelPageRemoved,
	#superclass : #LePageViewModelAnnouncement,
	#instVars : [
		'originalDatabase'
	],
	#category : #'Lepiter-UI-Page-Events'
}

{ #category : #accessing }
LePageViewModelPageRemoved >> originalDatabase [
	^ originalDatabase
]

{ #category : #accessing }
LePageViewModelPageRemoved >> originalDatabase: anObject [
	originalDatabase := anObject
]
