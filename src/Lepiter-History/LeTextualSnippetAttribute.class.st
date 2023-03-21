Class {
	#name : #LeTextualSnippetAttribute,
	#superclass : #LeBasicSnippetStateAttribute,
	#instVars : [
		'source',
		'attributeName'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #'instance creation' }
LeTextualSnippetAttribute class >> named: anAttributeName [ 
	^ self new 
		attributeName: anAttributeName 
]

{ #category : #updating }
LeTextualSnippetAttribute >> applyOn: aTextSnippet [ 
	aTextSnippet 
		updateFromCommandText: self text
		source: self source
]

{ #category : #transformation }
LeTextualSnippetAttribute >> asAttributeForLogStorage [
	^ LeTextualSnippetStringAttribute new 
		attributeName: self rawAttributeName;
		string: self string.
]

{ #category : #accessing }
LeTextualSnippetAttribute >> attributeName [
	^ attributeName
]

{ #category : #accessing }
LeTextualSnippetAttribute >> attributeName: anObject [
	attributeName := anObject
]

{ #category : #printing }
LeTextualSnippetAttribute >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< self attributeName;
			<< '=';
			print: self attributeValue ]
]

{ #category : #accessing }
LeTextualSnippetAttribute >> rawAttributeName [
	self flag: 'To Fix'.
	
	^ attributeName
]

{ #category : #accessing }
LeTextualSnippetAttribute >> shouldTransformForLogStorage [
	"In case a source is present we should not store it in the log.
	This is used to pass temporary information from the view model,
	to avoid redundannt updates and infinite loops when updating."
	
	^ self source notNil
]

{ #category : #accessing }
LeTextualSnippetAttribute >> source [
	^ source
]

{ #category : #accessing }
LeTextualSnippetAttribute >> source: anObject [
	source := anObject
]

{ #category : #accessing }
LeTextualSnippetAttribute >> string [	
	self subclassResponsibility
]

{ #category : #accessing }
LeTextualSnippetAttribute >> text [
	^ self subclassResponsibility
]
