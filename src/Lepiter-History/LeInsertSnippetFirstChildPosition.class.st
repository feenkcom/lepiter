Class {
	#name : #LeInsertSnippetFirstChildPosition,
	#superclass : #LeInsertSnippetPosition,
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeInsertSnippetFirstChildPosition >> descriptionOn: aStream [
	aStream 
		<< 'First Child'
]

{ #category : #action }
LeInsertSnippetFirstChildPosition >> insertChildSnippet: aChildSnippet intoParent: aContent [
	aContent addFirstSnippet: aChildSnippet
]

{ #category : #testing }
LeInsertSnippetFirstChildPosition >> isFirstChildPosition [
	^ true
]
