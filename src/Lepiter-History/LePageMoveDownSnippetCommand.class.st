Class {
	#name : #LePageMoveDownSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageMoveDownSnippetCommand class >> commandDescription [ 
	^ 'Move Down Snippet'
]

{ #category : #'execution - utils' }
LePageMoveDownSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder moveUpSnippetCommand
]

{ #category : #execution }
LePageMoveDownSnippetCommand >> execute [ 
	^ self withUndoExecute: [ 
		self targetSnippet moveDown ]
]
