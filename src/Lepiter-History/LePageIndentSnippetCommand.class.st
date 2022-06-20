Class {
	#name : #LePageIndentSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageIndentSnippetCommand class >> commandDescription [ 
	^ 'Indent Snippet'
]

{ #category : #execution }
LePageIndentSnippetCommand >> execute [ 
	self targetSnippet indent
]
