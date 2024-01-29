Class {
	#name : #LeElementSnippetElementRequester,
	#superclass : #Object,
	#traits : 'TGtCoderRequesterObject',
	#classTraits : 'TGtCoderRequesterObject classTrait',
	#instVars : [
		'element'
	],
	#category : #'Lepiter-Snippet-Element-Snippet'
}

{ #category : #accessing }
LeElementSnippetElementRequester >> element [
	^ element
]

{ #category : #accessing }
LeElementSnippetElementRequester >> element: anObject [
	element := anObject
]

{ #category : #accessing }
LeElementSnippetElementRequester >> isRequestedByElementOrItsChild: anElement [
	self element == anElement
		ifTrue: [ ^ true ].
	
	(self element isKindOf: BlElement)
		ifFalse: [ ^ false ].
		
	^ self element hasParent: anElement
]
