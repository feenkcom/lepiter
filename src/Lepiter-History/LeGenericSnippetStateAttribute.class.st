Class {
	#name : #LeGenericSnippetStateAttribute,
	#superclass : #LeBasicSnippetStateAttribute,
	#instVars : [
		'attributeName',
		'attributeValue'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #'instance creation' }
LeGenericSnippetStateAttribute class >> named: anAttributeName fromSnippet: aSnippet [ 
	^ self new 
		initializeNamed: anAttributeName 
		fromSnippet: aSnippet 
]

{ #category : #updating }
LeGenericSnippetStateAttribute >> applyOn: aSnippet [
	aSnippet 
		perform: self attributeName asMutator 
		with: self attributeValue 
]

{ #category : #accessing }
LeGenericSnippetStateAttribute >> attributeName [

	^ attributeName
]

{ #category : #accessing }
LeGenericSnippetStateAttribute >> attributeName: anAttributeName [

	attributeName := anAttributeName
]

{ #category : #accessing }
LeGenericSnippetStateAttribute >> attributeValue [

	^ attributeValue
]

{ #category : #accessing }
LeGenericSnippetStateAttribute >> attributeValue: anObject [

	attributeValue := anObject
]

{ #category : #initialization }
LeGenericSnippetStateAttribute >> extractValueFromSnippet: aSnippet [
	^ aSnippet perform: self attributeName
]

{ #category : #initialization }
LeGenericSnippetStateAttribute >> initializeNamed: anAttributeName fromSnippet: aSnippet [ 
	self attributeName: anAttributeName.
	self attributeValue: (self extractValueFromSnippet: aSnippet)
]
