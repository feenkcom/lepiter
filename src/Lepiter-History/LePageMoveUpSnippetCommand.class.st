Class {
	#name : #LePageMoveUpSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageMoveUpSnippetCommand class >> commandDescription [ 
	^ 'Move Up Snippet'
]

{ #category : #'execution - utils' }
LePageMoveUpSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder moveDownSnippetCommand
]

{ #category : #execution }
LePageMoveUpSnippetCommand >> execute [ 
	^ self withUndoExecute: [ 
		self targetSnippet moveUp ]
]
