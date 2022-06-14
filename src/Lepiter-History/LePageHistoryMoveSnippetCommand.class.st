Class {
	#name : #LePageHistoryMoveSnippetCommand,
	#superclass : #LePageEditCommand,
	#instVars : [
		'targetSnippetUid'
	],
	#category : #'Lepiter-History'
}

{ #category : #printing }
LePageHistoryMoveSnippetCommand >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize:  [ 
		aStream print: self targetSnippetUid ]
]

{ #category : #accessing }
LePageHistoryMoveSnippetCommand >> targetSnippetUid [

	^ targetSnippetUid
]

{ #category : #accessing }
LePageHistoryMoveSnippetCommand >> targetSnippetUid: anObject [

	targetSnippetUid := anObject
]
