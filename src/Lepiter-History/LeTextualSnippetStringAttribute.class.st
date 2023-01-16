Class {
	#name : #LeTextualSnippetStringAttribute,
	#superclass : #LeTextualSnippetAttribute,
	#instVars : [
		'stringValue'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #accessing }
LeTextualSnippetStringAttribute >> attributeValue [
	^ self string
]

{ #category : #initialization }
LeTextualSnippetStringAttribute >> initializeValueFromSnippet: aSnippet [ 
	self string: (self extractValueFromSnippet: aSnippet)
]

{ #category : #accessing }
LeTextualSnippetStringAttribute >> string [
	^ stringValue
]

{ #category : #accessing }
LeTextualSnippetStringAttribute >> string: aString [

	stringValue := aString 
]

{ #category : #accessing }
LeTextualSnippetStringAttribute >> text [
	^ self string asRopedText
]
