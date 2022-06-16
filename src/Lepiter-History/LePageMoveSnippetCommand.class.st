Class {
	#name : #LePageMoveSnippetCommand,
	#superclass : #LePageEditCommand,
	#instVars : [
		'targetSnippetUid'
	],
	#category : #'Lepiter-History'
}

{ #category : #'instance creation' }
LePageMoveSnippetCommand class >> forSnippet: aSnippet [ 
	^ self new
		initializeForSnippet: aSnippet
]

{ #category : #printing }
LePageMoveSnippetCommand >> descriptionOn: aStream [
	aStream 
		<< 'snippetUid: ';
		print: self targetSnippetUid
]

{ #category : #initialization }
LePageMoveSnippetCommand >> initializeForSnippet: aSnippet [ 
	self targetSnippetUid: aSnippet uid
]

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
