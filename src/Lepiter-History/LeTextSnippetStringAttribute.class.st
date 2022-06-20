Class {
	#name : #LeTextSnippetStringAttribute,
	#superclass : #LeBasicSnippetStateAttribute,
	#instVars : [
		'string'
	],
	#category : #'Lepiter-History'
}

{ #category : #updating }
LeTextSnippetStringAttribute >> applyOn: aTextSnippet [ 
	aTextSnippet updateString: self string
]

{ #category : #accessing }
LeTextSnippetStringAttribute >> attributeName [
	^ #string
]

{ #category : #accessing }
LeTextSnippetStringAttribute >> attributeValue [
	^ self string
]

{ #category : #accessing }
LeTextSnippetStringAttribute >> string [

	^ string
]

{ #category : #accessing }
LeTextSnippetStringAttribute >> string: aString [

	string := aString
]
