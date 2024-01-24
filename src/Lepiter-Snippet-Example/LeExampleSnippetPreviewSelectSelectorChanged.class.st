Class {
	#name : #LeExampleSnippetPreviewSelectSelectorChanged,
	#superclass : #LeExampleSnippetContentChanged,
	#instVars : [
		'previewSelectSelector'
	],
	#category : #'Lepiter-Snippet-Example-Snippet'
}

{ #category : #accessing }
LeExampleSnippetPreviewSelectSelectorChanged >> previewSelectSelector [
	^ previewSelectSelector
]

{ #category : #accessing }
LeExampleSnippetPreviewSelectSelectorChanged >> previewSelectSelector: anObject [
	previewSelectSelector := anObject
]
