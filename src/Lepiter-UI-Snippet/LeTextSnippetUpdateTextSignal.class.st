Class {
	#name : #LeTextSnippetUpdateTextSignal,
	#superclass : #ContextStackSignal,
	#instVars : [
		'previousText',
		'newText',
		'frameId'
	],
	#category : 'Lepiter-UI-Snippet-Signals'
}

{ #category : #accessing }
LeTextSnippetUpdateTextSignal >> frameId [
	^ frameId
]

{ #category : #accessing }
LeTextSnippetUpdateTextSignal >> frameId: anObject [
	frameId := anObject
]

{ #category : #accessing }
LeTextSnippetUpdateTextSignal >> newText [
	^ newText
]

{ #category : #accessing }
LeTextSnippetUpdateTextSignal >> newText: anObject [
	newText := anObject
]

{ #category : #accessing }
LeTextSnippetUpdateTextSignal >> previousText [
	^ previousText
]

{ #category : #accessing }
LeTextSnippetUpdateTextSignal >> previousText: anObject [
	previousText := anObject
]
