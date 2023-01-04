Class {
	#name : #LeTransferSnippetChildrenCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'sourceSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeTransferSnippetChildrenCommand >> basicExecute [
	^ self withUndoExecute: [ 
		self sourceSnippet transferChildrenTo: self targetSnippet ]
]

{ #category : #converting }
LeTransferSnippetChildrenCommand >> createCommandSpecification [
	^ LeTransferSnippetChildrenCommandSpecification new 
		commandUid: self uid;
		contentUid: self targetSnippetUid;
		commandTypeName: self className;
		sourceSnippet: self sourceSnippet
]

{ #category : #'execution - utils' }
LeTransferSnippetChildrenCommand >> createUndoCommand [
	^ self targetContent commandBuilder transferChildrenCommand
		sourceSnippet: self targetSnippet
]

{ #category : #'execution - utils' }
LeTransferSnippetChildrenCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> label [
	^ 'Transfer Children'
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> sourceSnippet [

	^ sourceSnippet
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> sourceSnippet: anObject [

	sourceSnippet := anObject
]
