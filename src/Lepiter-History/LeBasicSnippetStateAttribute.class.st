Class {
	#name : #LeBasicSnippetStateAttribute,
	#superclass : #Object,
	#category : #'Lepiter-History-State'
}

{ #category : #updating }
LeBasicSnippetStateAttribute >> applyOn: aSnippet [ 
	self subclassResponsibility
]

{ #category : #accessing }
LeBasicSnippetStateAttribute >> attributeName [

	^ self subclassResponsibility 
]

{ #category : #accessing }
LeBasicSnippetStateAttribute >> attributeValue [

	^ self subclassResponsibility 
]
