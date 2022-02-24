"
Models the type of change in structure between two Lepiter pages. Changes in structure are detected based on the ids of snippets.

My subclasses indicate concrete types of changes.
"
Class {
	#name : #LePageStructureChange,
	#superclass : #Object,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #testing }
LePageStructureChange class >> needsPageRebuild [
	^ false
]
