Class {
	#name : #LeSnippetRequestRemoveSelection,
	#superclass : #Announcement,
	#instVars : [
		'snippetViewModel'
	],
	#category : #'Lepiter-UI-Snippet-Events'
}

{ #category : #accessing }
LeSnippetRequestRemoveSelection >> snippetViewModel [
	^ snippetViewModel
]

{ #category : #accessing }
LeSnippetRequestRemoveSelection >> snippetViewModel: anObject [
	snippetViewModel := anObject
]
