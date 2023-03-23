Class {
	#name : #LeBasicSnippetStateAttribute,
	#superclass : #Object,
	#category : #'Lepiter-History-State'
}

{ #category : #comparing }
LeBasicSnippetStateAttribute >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ self attributeName = anObject attributeName and: [
		self attributeValue = anObject attributeValue ]
]

{ #category : #updating }
LeBasicSnippetStateAttribute >> applyOn: aSnippet [ 
	self subclassResponsibility
]

{ #category : #transformation }
LeBasicSnippetStateAttribute >> asAttributeForLogStorage [
	^ self
]

{ #category : #accessing }
LeBasicSnippetStateAttribute >> attributeName [

	^ self subclassResponsibility 
]

{ #category : #accessing }
LeBasicSnippetStateAttribute >> attributeValue [

	^ self subclassResponsibility 
]

{ #category : #initialization }
LeBasicSnippetStateAttribute >> extractValueFromSnippet: aSnippet [
	^ aSnippet perform: self attributeName
]

{ #category : #comparing }
LeBasicSnippetStateAttribute >> hash [
	^ self attributeName hash bitXor: self attributeValue hash
]

{ #category : #'testing - transformation' }
LeBasicSnippetStateAttribute >> shouldTransformForLogStorage [
	^ false
]
