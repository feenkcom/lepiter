Class {
	#name : #LeTransferChildrenFromSnippetCommand,
	#superclass : #LeTransferSnippetChildrenCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeTransferChildrenFromSnippetCommand >> basicExecute [
	^ self withUndoExecute: [ 
		self sourceSnippet transferChildrenTo: self targetSnippet ]
]

{ #category : #'execution - utils' }
LeTransferChildrenFromSnippetCommand >> createUndoCommand [
	^ self targetSnippet commandBuilder transferChildrenToSnippetCommand
		sourceSnippetUid: self sourceSnippetUid
]

{ #category : #accessing }
LeTransferChildrenFromSnippetCommand >> label [
	^ 'Transfer Children From Snippet'
]
