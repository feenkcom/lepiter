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
	self snippetState 
		addAttribute: (LeTextualSnippetStringAttribute new
			string: aString;
			source: aSource)
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> text: aText [ 
	self notYetImplemented 
]

{ #category : #accessing }
LeTextualEditSnippetCommand >> text: aText withSource: aSource [
	self notYetImplemented 
]
