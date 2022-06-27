Class {
	#name : #LePageUnindentSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageUnindentSnippetCommand class >> commandDescription [ 
	^ 'Unindent'
]

{ #category : #execution }
LePageUnindentSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [ 
		self targetSnippet unindent ]
]

{ #category : #'execution - utils' }
LePageUnindentSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder indentSnippetCommand
]
