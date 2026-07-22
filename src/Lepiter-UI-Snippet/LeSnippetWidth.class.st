"
# Snippet width
Represents how large a snippet should be within a page

"
Class {
	#name : #LeSnippetWidth,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-! Views'
}

{ #category : #accessing }
LeSnippetWidth >> cssClass [
	^ self subclassResponsibility
]

{ #category : #accessing }
LeSnippetWidth >> maxWidth [
	^ self subclassResponsibility
]
