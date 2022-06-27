Class {
	#name : #LePageMoveUpSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageMoveUpSnippetCommand class >> commandDescription [ 
	^ 'Move Up Snippet'
]

{ #category : #execution }
LePageMoveUpSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [ 
		self targetSnippet moveUp ]
]

{ #category : #'execution - utils' }
LePageMoveUpSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder moveDownSnippetCommand
]
