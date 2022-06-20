Class {
	#name : #LePageMoveDownSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageMoveDownSnippetCommand class >> commandDescription [ 
	^ 'Move Down Snippet'
]

{ #category : #execution }
LePageMoveDownSnippetCommand >> execute [ 
	self targetSnippet moveDown
]
