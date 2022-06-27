Class {
	#name : #LeAppendSnippetContentCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'sourceSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeAppendSnippetContentCommand >> sourceSnippet [

	^ sourceSnippet
]

{ #category : #accessing }
LeAppendSnippetContentCommand >> sourceSnippet: anObject [

	sourceSnippet := anObject
]
