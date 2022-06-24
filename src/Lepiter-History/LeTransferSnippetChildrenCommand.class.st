Class {
	#name : #LeTransferSnippetChildrenCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'sourceSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

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

{ #category : #execution }
LeTransferSnippetChildrenCommand >> execute [
	^ self withUndoExecute: [ 
		self sourceSnippet transferChildrenTo: self targetSnippet ]
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> sourceSnippet [

	^ sourceSnippet
]

{ #category : #accessing }
LeTransferSnippetChildrenCommand >> sourceSnippet: anObject [

	sourceSnippet := anObject
]
