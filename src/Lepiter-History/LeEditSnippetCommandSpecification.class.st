Class {
	#name : #LeEditSnippetCommandSpecification,
	#superclass : #LeCommandSpecification,
	#instVars : [
		'snippetState'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeEditSnippetCommandSpecification >> snippetState [

	^ snippetState
]

{ #category : #accessing }
LeEditSnippetCommandSpecification >> snippetState: aSnippetState [

	snippetState := aSnippetState
]
