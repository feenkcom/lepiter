Class {
	#name : #LePageIndentSnippetCommand,
	#superclass : #LeMoveSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LePageIndentSnippetCommand class >> commandDescription [ 
	^ 'Indent Snippet'
]

{ #category : #'execution - utils' }
LePageIndentSnippetCommand >> createUndoCommand [
	^ self targetContent commandBuilder unindentSnippetCommand
]

{ #category : #execution }
LePageIndentSnippetCommand >> execute [ 
	^ self withUndoExecute: [  
		self targetSnippet indent ]
]
