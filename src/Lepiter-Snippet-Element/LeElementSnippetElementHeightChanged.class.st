Class {
	#name : #LeElementSnippetElementHeightChanged,
	#superclass : #LeElementSnippetAnnouncement,
	#instVars : [
		'elementHeight'
	],
	#category : #'Lepiter-Snippet-Element-Events'
}

{ #category : #accessing }
LeElementSnippetElementHeightChanged >> elementHeight [
	^ elementHeight
]

{ #category : #accessing }
LeElementSnippetElementHeightChanged >> elementHeight: aHeight [
	elementHeight := aHeight
]
