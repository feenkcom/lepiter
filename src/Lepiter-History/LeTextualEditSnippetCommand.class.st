Class {
	#name : #LeTextualEditSnippetCommand,
	#superclass : #LeBasicEditSnippetCommand,
	#instVars : [
		'source'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeTextualEditSnippetCommand >> string: aString [ 
	self string: aString withSource: nil
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> string: aString withSource: aSource [
	self 
		text: aString asRopedText 
		withSource: aSource
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> text: aText [ 
	self 
		text: aText 
		withSource: nil
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> text: aText withSource: aSource [
	self snippetState 
		addAttribute: (LeTextualSnippetTextAttribute new
			text: aText;
			source: aSource)
]
