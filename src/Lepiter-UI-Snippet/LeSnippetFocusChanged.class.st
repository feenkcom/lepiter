"
# Focus state changed announcement

Is announced by the {{gtClass:LeAbstractSnippetViewModel}} when its focus state changed

"
Class {
	#name : #LeSnippetFocusChanged,
	#superclass : #Announcement,
	#instVars : [
		'source',
		'focused'
	],
	#category : 'Lepiter-UI-Snippet-Events'
}

{ #category : #accessing }
LeSnippetFocusChanged >> focused [
	^ focused
]

{ #category : #accessing }
LeSnippetFocusChanged >> focused: anObject [
	focused := anObject
]

{ #category : #accessing }
LeSnippetFocusChanged >> source [
	^ source
]

{ #category : #accessing }
LeSnippetFocusChanged >> source: anObject [
	source := anObject
]
