Class {
	#name : #LeFileSnippetViewModel,
	#superclass : #LeSnippetViewModel,
	#category : #'Lepiter-Snippet-File'
}

{ #category : #accessing }
LeFileSnippetViewModel >> bindingName [
	^ self snippetModel bindingName
]

{ #category : #accessing }
LeFileSnippetViewModel >> bindingName: aNameString [
	self snippetModel bindingName: aNameString
]

{ #category : #accessing }
LeFileSnippetViewModel >> fileReference [
	^ self snippetModel fileReference
]

{ #category : #accessing }
LeFileSnippetViewModel >> fileReference: aFileReference [
	self snippetModel fileReference: aFileReference
]

{ #category : #accessing }
LeFileSnippetViewModel >> snippetElementClass [
	^ LeFileSnippetElement
]
