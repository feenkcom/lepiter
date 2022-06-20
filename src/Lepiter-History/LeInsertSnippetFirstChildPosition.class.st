Class {
	#name : #LeInsertSnippetFirstChildPosition,
	#superclass : #LeInsertSnippetPosition,
	#category : #'Lepiter-History'
}

{ #category : #action }
LeInsertSnippetFirstChildPosition >> insertChildSnippet: aChildSnippet intoParent: aContent [
	aContent addFirstSnippet: aChildSnippet
]
