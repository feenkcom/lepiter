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
LePageMoveDownSnippetCommand >> basicExecute [ 
	self assert: [ self targetSnippet canBeMovedDown ].
	
	^ self withUndoExecute: [ 
		| moveResult |
		moveResult := self targetSnippet moveDown.
		
		self 
			assert: moveResult
			description: 'Moving down should have an effect'. ]
]

{ #category : #'execution - utils' }
LePageMoveDownSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder moveUpSnippetCommand
]

{ #category : #accessing }
LePageMoveDownSnippetCommand >> label [
	^ 'Move Down Snippet'
]
