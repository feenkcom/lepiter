Class {
	#name : #LeTextualSnippetTextAttribute,
	#superclass : #LeBasicSnippetStateAttribute,
	#instVars : [
		'text',
		'source'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #'instance creation' }
LeTextualSnippetTextAttribute class >> named: anAttributeName fromSnippet: aSnippet [ 
	"Temporary solution to make #extractFromSnippet:basedOn: work."
	self flag: #TO_REMOVE.
	
	self assert: [ anAttributeName = #string ].
	
	^ self new 
		string: aSnippet string
]

{ #category : #updating }
LeTextualSnippetTextAttribute >> applyOn: aTextSnippet [ 
	aTextSnippet 
		updateText: self text
		source: self source
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> attributeName [
	^ #string
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> attributeValue [
	^ self text
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> extractValueFromSnippet: aSnippet [
	^ aSnippet text
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> source [
	^ source
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> source: anObject [
	source := anObject
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> string [

	^ self text asString
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> string: aString [

	self text: aString asRopedText
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> text [
	^ text
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> text: aText [
	text := aText
]
