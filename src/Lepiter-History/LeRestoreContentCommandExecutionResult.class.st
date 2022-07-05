Class {
	#name : #LeRestoreContentCommandExecutionResult,
	#superclass : #LeCommandExecutionResult,
	#instVars : [
		'insertedSnippet'
	],
	#category : #'Lepiter-History-Commands'
}

{ #category : #accessing }
LeRestoreContentCommandExecutionResult >> traceEvent [
	^ self command traceEventTypeForRecording new 
		targetEvent: self command traceEvent
]
