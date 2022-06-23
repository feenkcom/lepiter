Class {
	#name : #LeEditTextSnippetCommand,
	#superclass : #LeBasicEditSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeEditTextSnippetCommand >> string: aString [ 
	self snippetState 
		addAttribute: (LeTextSnippetStringAttribute new
			string: aString)
]
