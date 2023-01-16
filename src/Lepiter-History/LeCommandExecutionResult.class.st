Class {
	#name : #LeCommandExecutionResult,
	#superclass : #Object,
	#instVars : [
		'command',
		'undoSpecification'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #'instance creation' }
LeCommandExecutionResult class >> forCommand: aCommand [ 
	^ self new
		command: aCommand
]

{ #category : #accessing }
LeCommandExecutionResult >> command [

	^ command
]

{ #category : #accessing }
LeCommandExecutionResult >> command: anObject [

	command := anObject
]

{ #category : #accessing }
LeCommandExecutionResult >> commandSpecification [
	^ self command createCommandSpecification
]

{ #category : #accessing }
LeCommandExecutionResult >> traceEvent [
	^ LeContentEditTraceEvent new 
		mainCommandSpecification: self commandSpecification 
			asSpecificationForLogStorage;
		undoCommandSpecification: self undoSpecification 
			asSpecificationForLogStorage
]

{ #category : #accessing }
LeCommandExecutionResult >> undoSpecification [

	^ undoSpecification
]

{ #category : #accessing }
LeCommandExecutionResult >> undoSpecification: aCommandSpecification [

	undoSpecification := aCommandSpecification
]

{ #category : #'updating - view model' }
LeCommandExecutionResult >> updateSnippetsViewModelFor: aSnippetsViewModel [
	self command 
		updateSnippetsViewModelFor: aSnippetsViewModel
		withResult: self
]
