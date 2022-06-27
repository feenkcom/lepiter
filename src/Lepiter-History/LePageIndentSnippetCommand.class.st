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
LePageIndentSnippetCommand >> basicExecute [ 
	^ self withUndoExecute: [  
		self targetSnippet indent ]
]

{ #category : #'execution - utils' }
LePageIndentSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder unindentSnippetCommand
]
