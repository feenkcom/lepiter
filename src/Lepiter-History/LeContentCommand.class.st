Class {
	#name : #LeContentCommand,
	#superclass : #Object,
	#instVars : [
		'uid',
		'targetContent'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #'execution - utils' }
LeContentCommand >> createCommandResult [
	^ LeCommandExecutionResult forCommand: self
]

{ #category : #'execution - utils' }
LeContentCommand >> createUndoCommandSpecification [
	^ nil
]

{ #category : #printing }
LeContentCommand >> description [
	^ String streamContents: [ :aStream |
		self descriptionOn: aStream ]
]

{ #category : #printing }
LeContentCommand >> descriptionOn: aStream [
	self subclassResponsibility
]

{ #category : #execution }
LeContentCommand >> execute [
	self subclassResponsibility
]

{ #category : #initialization }
LeContentCommand >> initialize [ 
	super initialize.
	uid := LeUID new uid: UUID new.
]

{ #category : #accessing }
LeContentCommand >> targetContent [

	^ targetContent
]

{ #category : #accessing }
LeContentCommand >> targetContent: aLeContent [

	targetContent := aLeContent
]

{ #category : #accessing }
LeContentCommand >> uid [ 
	^ uid
]

{ #category : #execution }
LeContentCommand >> withUndoExecute: aBlock [
	"An utility method that creates an undo specification after a command was executed.
	Can be used when all the information needed by an undo is available before executing
	the command."
	| undoSpecification |
	undoSpecification := self createUndoCommandSpecification.
	
	aBlock value.
	
	^ self createCommandResult 
		undoSpecification: undoSpecification
]
