Class {
	#name : #LeTextSnippetStringAttribute,
	#superclass : #LeBasicSnippetStateAttribute,
	#instVars : [
		'string'
	],
	#category : #'Lepiter-History-State'
}

{ #category : #'instance creation' }
LeTextSnippetStringAttribute class >> named: anAttributeName fromSnippet: aSnippet [ 
	"Temporary solution to make #extractFromSnippet:basedOn: work."
	self flag: #TO_REMOVE.
	
	self assert: [ anAttributeName = #string ].
	
	^ self new 
		string: aSnippet string
]

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
