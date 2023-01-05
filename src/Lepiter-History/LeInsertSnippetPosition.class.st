"
{{gtClass:LeInsertSnippetPosition}} indicates the position at which a child snippet should be added in a parent (page or snippet). 

Subclasses model explicit positions.
"
Class {
	#name : #LeInsertSnippetPosition,
	#superclass : #Object,
	#category : #'Lepiter-History-Commands'
}

{ #category : #converting }
LeInsertSnippetPosition >> asPath [ 
	^ LeInsertSnippetPath new
		insertPosition: self
]

{ #category : #description }
LeInsertSnippetPosition >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #description }
LeInsertSnippetPosition >> descriptionOn: aStream [
	aStream << self className
]

{ #category : #action }
LeInsertSnippetPosition >> insertChildSnippet: aChildSnippet intoParent: aContent [
	^ self subclassResponsibility
]

{ #category : #testing }
LeInsertSnippetPosition >> isAfterChildUidPosition [
	^ false
]

{ #category : #testing }
LeInsertSnippetPosition >> isFirstChildPosition [
	^ false
]

{ #category : #testing }
LeInsertSnippetPosition >> isLastChildPosition [
	^ false
]
