Class {
	#name : #LeSnippetId,
	#superclass : #BlElementId,
	#instVars : [
		'uid'
	],
	#category : #'Lepiter-UI-IDs'
}

{ #category : #comparing }
LeSnippetId >> = anObject [
	^ self class = anObject class and: [ self uid = anObject uid ]
]

{ #category : #converting }
LeSnippetId >> asSymbol [
	^ #'lepiter--snippet-{1}' format: { self uid }
]

{ #category : #comparing }
LeSnippetId >> hash [
	^ self class hash bitXor: [ self uid hash ]
]

{ #category : #accessing }
LeSnippetId >> uid [
	^ uid
]

{ #category : #accessing }
LeSnippetId >> uid: anObject [
	uid := anObject
]
