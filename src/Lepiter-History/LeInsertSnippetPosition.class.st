"
{{gtClass:LeInsertSnippetPosition}} indicates the position at which a child snippet should be added in a parent (page or snippet). 

Subclasses model explicit positions.
"
Class {
	#name : #LeInsertSnippetPosition,
	#superclass : #Object,
	#category : #'Lepiter-History'
}

{ #category : #action }
LeInsertSnippetPosition >> insertChildSnippet: aChildSnippet intoParent: aContent [
	self subclassResponsibility
]
