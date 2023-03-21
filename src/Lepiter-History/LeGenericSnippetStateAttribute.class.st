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
LeGenericSnippetStateAttribute class >> named: anAttributeName [ 
	^ self new 
		attributeName: anAttributeName 
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

{ #category : #printing }
LeGenericSnippetStateAttribute >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	
	aStream parenthesize: [ 
		aStream 
			<< 'name=';
			<< self attributeName;
			<< ', value=';
			print: self attributeValue]
]

{ #category : #initialization }
LeGenericSnippetStateAttribute >> initializeValueFromSnippet: aSnippet [ 
	self attributeValue: (self extractValueFromSnippet: aSnippet)
]
