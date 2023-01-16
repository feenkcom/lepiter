Class {
	#name : #LeTextualSnippetTextAttribute,
	#superclass : #LeTextualSnippetAttribute,
	#instVars : [
		'textValue'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeTextualSnippetTextAttribute >> attributeValue [
	^ self text
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> string [

	^ self text asString
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> text [
	^ textValue
]

{ #category : #accessing }
LeTextualSnippetTextAttribute >> text: aText [
	textValue := aText
]
