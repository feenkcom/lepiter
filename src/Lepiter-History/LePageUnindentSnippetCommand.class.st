Class {
	#name : #LePageUnindentSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageUnindentSnippetCommand class >> commandDescription [ 
	^ 'Unindent'
]

{ #category : #'execution - utils' }
LePageUnindentSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder indentSnippetCommand
]

{ #category : #execution }
LePageUnindentSnippetCommand >> execute [ 
	^ self withUndoExecute: [ 
		self targetSnippet unindent ]
]
