Class {
	#name : #LePageMoveSnippetCommand,
	#superclass : #LePageEditCommand,
	#instVars : [
		'targetSnippetUid'
	],
	#category : #'Lepiter-History'
}

{ #category : #printing }
LePageMoveSnippetCommand >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize:  [ 
		aStream print: self targetSnippetUid ]
]

{ #category : #accessing }
LePageMoveSnippetCommand >> targetSnippetUid [

	^ targetSnippetUid
]

{ #category : #accessing }
LePageMoveSnippetCommand >> targetSnippetUid: anObject [

	targetSnippetUid := anObject
]
