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
		commandUid: self uid;
		contentUid: self targetSnippetUid;
		commandTypeName: self className;
		attributeAt: #sourceSnippetUid put: self sourceSnippet uid
]

{ #category : #'execution - utils' }
LeAppendSnippetContentCommand >> createUndoCommand [
	^ self targetContent commandBuilder editSnippetCommand
		snippetState: self extractCurrentSnippetState
]

{ #category : #'execution - utils' }
LeAppendSnippetContentCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]

{ #category : #accessing }
LeAppendSnippetContentCommand >> extractCurrentSnippetState [
	^ LeGenericSnippetState fromSnippet: self targetSnippet
]

{ #category : #accessing }
LeAppendSnippetContentCommand >> sourceSnippet [

	^ sourceSnippet
]

{ #category : #accessing }
LeAppendSnippetContentCommand >> sourceSnippet: anObject [

	sourceSnippet := anObject
]
