Class {
	#name : #LePageMoveUpSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History'
}

{ #category : #accessing }
LePageMoveUpSnippetCommand class >> commandDescription [ 
	^ 'Move Up Snippet'
]

{ #category : #execution }
LePageMoveUpSnippetCommand >> execute [ 
	self targetSnippet moveDown
]
