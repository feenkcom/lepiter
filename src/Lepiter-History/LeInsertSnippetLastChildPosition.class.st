Class {
	#name : #LeInsertSnippetLastChildPosition,
	#superclass : #LeInsertSnippetPosition,
	#category : #'Lepiter-History-Commands'
}

{ #category : #printing }
LeInsertSnippetLastChildPosition >> descriptionOn: aStream [
	aStream 
		<< 'Last Child'
]

{ #category : #action }
LeInsertSnippetLastChildPosition >> insertChildSnippet: aChildSnippet intoParent: aContent [
	aContent addSnippet: aChildSnippet
]

{ #category : #testing }
LeInsertSnippetLastChildPosition >> isLastChildPosition [
	^ true
]
