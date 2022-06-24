Class {
	#name : #LeSnippetCommand,
	#superclass : #LeContentCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #'instance creation' }
LeSnippetCommand class >> forSnippet: aSnippet [ 
	^ self new
		initializeForSnippet: aSnippet
]

{ #category : #testing }
LeSnippetCommand class >> isAbstract [ 
	^ self name = #LeSnippetCommand
]

{ #category : #printing }
LeSnippetCommand >> descriptionOn: aStream [
	aStream 
		<< 'snippetUid: ';
		print: self targetSnippetUid
]

{ #category : #initialization }
LeSnippetCommand >> initializeForSnippet: aSnippet [ 
	self targetContent: aSnippet.
]

{ #category : #printing }
LeSnippetCommand >> printOn: aStream [
	super printOn: aStream.
	
	self targetSnippet ifNil: [ ^ self ].
	aStream parenthesize:  [ 
		aStream print: self targetSnippetUid ]
]

{ #category : #accessing }
LeSnippetCommand >> targetSnippet [
	^ self targetContent
]

{ #category : #accessing }
LeSnippetCommand >> targetSnippetUid [

	^ self targetSnippet uid
]
