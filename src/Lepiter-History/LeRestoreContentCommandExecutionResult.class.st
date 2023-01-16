Class {
	#name : #LeRestoreContentCommandExecutionResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'targetCommandResult'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeRestoreContentCommandExecutionResult >> targetCommandResult [
	^ targetCommandResult
]

{ #category : #accessing }
LeRestoreContentCommandExecutionResult >> targetCommandResult: aCommandResult [
	targetCommandResult := aCommandResult
]

{ #category : #accessing }
LeRestoreContentCommandExecutionResult >> traceEvent [
	^ self command traceEventTypeForRecording new 
		targetEvent: self command traceEvent
]
