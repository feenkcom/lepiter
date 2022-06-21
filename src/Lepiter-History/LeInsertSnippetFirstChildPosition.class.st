Class {
	#name : #LeInsertSnippetFirstChildPosition,
	#superclass : #LeInsertSnippetPosition,
	#category : #'Lepiter-History-Commands'
}

{ #category : #action }
LeInsertSnippetFirstChildPosition >> insertChildSnippet: aChildSnippet intoParent: aContent [
	aContent addFirstSnippet: aChildSnippet
]
