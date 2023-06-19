Class {
	#name : #LeSnippetHeightChanged,
	#superclass : #LeSnippetContentChanged,
	#instVars : [
		'height'
	],
	#category : 'Lepiter-Core-Announcements'
}

{ #category : #accessing }
LeSnippetHeightChanged >> height [
	^ height
]

{ #category : #accessing }
LeSnippetHeightChanged >> height: anObject [
	height := anObject
]
