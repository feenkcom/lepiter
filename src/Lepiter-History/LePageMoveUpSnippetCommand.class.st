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
	self assert: [ self targetSnippet canBeMovedUp ].
	
	^ self withUndoExecute: [ 
		| moveResult |
		moveResult := self targetSnippet moveUp.
		self assert: moveResult. ]
]

{ #category : #'execution - utils' }
LePageMoveUpSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder moveDownSnippetCommand
]

{ #category : #accessing }
LePageMoveUpSnippetCommand >> label [
	^ 'Move Up Snippet'
]
