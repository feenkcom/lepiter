Class {
	#name : #LeTextualSnippetAttribute,
	#superclass : #LeBasicSnippetStateAttribute,
	#instVars : [
		'source',
		'attributeName'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #updating }
LeTextualSnippetAttribute >> applyOn: aTextSnippet [ 
	aTextSnippet 
		updateText: self text
		source: self source
]

{ #category : #accessing }
LeTextualSnippetAttribute >> attributeName [
	self flag: 'To Fix'.
	
	^ attributeName ifNil: [ #string ]
]

{ #category : #accessing }
LeTextualSnippetAttribute >> attributeName: anObject [
	attributeName := anObject
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
LeTextualSnippetAttribute >> text [
	^ self subclassResponsibility
]
