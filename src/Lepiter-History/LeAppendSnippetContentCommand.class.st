Class {
	#name : #LeAppendSnippetContentCommand,
	#superclass : #LeSnippetCommand,
	#instVars : [
		'sourceSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #execution }
LeAppendSnippetContentCommand >> basicExecute [
	^ self withUndoExecute: [ 
		self targetSnippet 
			appendText: self sourceSnippet text ]
]

{ #category : #converting }
LeAppendSnippetContentCommand >> createCommandSpecification [
	^ LeGenericCommandSpecification new
		contentUid: self targetSnippetUid;
		commandTypeName: self className;
		attributeAt: #sourceSnippetUid put: self sourceSnippet uid
]

{ #category : #'execution - utils' }
LeAppendSnippetContentCommand >> createUndoCommand [
	^ self targetContent commandBuilder undoSnippetStateCommand
]

{ #category : #'execution - utils' }
LeAppendSnippetContentCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]

{ #category : #accessing }
LeAppendSnippetContentCommand >> label [
	^ 'Append Snippet Content'
]

{ #category : #accessing }
LeAppendSnippetContentCommand >> sourceSnippet [

	^ sourceSnippet
]

{ #category : #accessing }
LeAppendSnippetContentCommand >> sourceSnippet: anObject [

	sourceSnippet := anObject
]
