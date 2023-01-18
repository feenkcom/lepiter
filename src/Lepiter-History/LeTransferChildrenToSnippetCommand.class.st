Class {
	#name : #LeTransferChildrenToSnippetCommand,
	#superclass : #LeTransferSnippetChildrenCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeTransferChildrenToSnippetCommand >> basicExecute [
	^ self withUndoExecute: [ 
		self targetSnippet transferChildrenTo: self sourceSnippet ]
]

{ #category : #'execution - utils' }
LeTransferChildrenToSnippetCommand >> createUndoCommand [
	^ self targetSnippet commandBuilder transferChildrenFromSnippetCommand
		sourceSnippetUid: self sourceSnippetUid
]

{ #category : #accessing }
LeTransferChildrenToSnippetCommand >> label [
	^ 'Transfer Children To Snippet'
]
