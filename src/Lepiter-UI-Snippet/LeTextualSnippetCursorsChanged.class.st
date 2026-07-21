"
# Cursors state changed announcement

Is announced by the {{gtClass:LeTextualSnippetViewModel}} when its cursors state changed

"
Class {
	#name : #LeTextualSnippetCursorsChanged,
	#superclass : #Announcement,
	#instVars : [
		'source',
		'cursors'
	],
	#category : 'Lepiter-UI-Snippet-Events'
}

{ #category : #accessing }
LeTextualSnippetCursorsChanged >> cursors [
	^ cursors
]

{ #category : #accessing }
LeTextualSnippetCursorsChanged >> cursors: anObject [
	cursors := anObject
]

{ #category : #accessing }
LeTextualSnippetCursorsChanged >> source [
	^ source
]

{ #category : #accessing }
LeTextualSnippetCursorsChanged >> source: anObject [
	source := anObject
]
