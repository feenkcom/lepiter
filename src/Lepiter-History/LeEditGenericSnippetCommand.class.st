Class {
	#name : #LeEditGenericSnippetCommand,
	#superclass : #LeBasicEditSnippetCommand,
	#category : #'Lepiter-History'
}

{ #category : #accessing }
LeEditGenericSnippetCommand class >> commandDescription [ 
	^ 'Change Snippet'
]

{ #category : #updating }
LeEditGenericSnippetCommand >> update: anAttributeName to: aValue [
	snippetState attributeNamed: anAttributeName setValue: aValue
]
