"
# Expansion state changed announcement

Is announced by the {{gtClass:LeAbstractSnippetViewModel}} when its expansion state changed

"
Class {
	#name : #LeSnippetExpansionChanged,
	#superclass : #Announcement,
	#instVars : [
		'expanded'
	],
	#category : 'Lepiter-UI-Snippet-Events'
}

{ #category : #accessing }
LeSnippetExpansionChanged >> expanded [
	^ expanded
]

{ #category : #accessing }
LeSnippetExpansionChanged >> expanded: anObject [
	expanded := anObject
]
