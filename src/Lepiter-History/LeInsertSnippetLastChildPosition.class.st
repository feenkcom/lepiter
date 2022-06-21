Class {
	#name : #LeInsertSnippetLastChildPosition,
	#superclass : #LeInsertSnippetPosition,
	#category : #'Lepiter-History-Commands'
}

{ #category : #action }
LeInsertSnippetLastChildPosition >> insertChildSnippet: aChildSnippet intoParent: aContent [
	aContent addSnippet: aChildSnippet
]
