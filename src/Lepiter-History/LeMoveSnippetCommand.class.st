Class {
	#name : #LeMoveSnippetCommand,
	#superclass : #LeSnippetCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #testing }
LeMoveSnippetCommand class >> isAbstract [ 
	^ self name = #LeMoveSnippetCommand
]

{ #category : #converting }
LeMoveSnippetCommand >> createCommandSpecification [
	^ LeGenericCommandSpecification new
		contentUid: self targetSnippetUid;
		commandTypeName: self className
]

{ #category : #'execution - utils' }
LeMoveSnippetCommand >> createUndoCommand [ 
	^ self subclassResponsibility
]

{ #category : #'execution - utils' }
LeMoveSnippetCommand >> createUndoCommandSpecification [
	^ self createUndoCommand createCommandSpecification
]
