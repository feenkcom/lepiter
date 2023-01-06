Class {
	#name : #LeTextualEditSnippetCommand,
	#superclass : #LeBasicEditSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeTextualEditSnippetCommand >> string: aString [ 
	self snippetState 
		addAttribute: (LeTextSnippetStringAttribute new
			string: aString)
]
