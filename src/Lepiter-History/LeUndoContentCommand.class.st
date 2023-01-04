Class {
	#name : #LeUndoContentCommand,
	#superclass : #LeRestoreContentCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #'execution - utils' }
LeUndoContentCommand >> createUndoCommand [
	^ LeRedoContentCommand new
		targetContent: self targetPage;
		traceEvent: self traceEvent
]

{ #category : #printing }
LeUndoContentCommand >> descriptionOn: aStream [
	aStream 
		<< 'undo: ';
		print: self targetCommand description
]

{ #category : #initialization }
LeUndoContentCommand >> initializeForTraceEvent: anEvent inPage: aPage [
	super initializeForTraceEvent: anEvent inPage: aPage.
	
	targetCommand := anEvent undoCommandSpecification createCommandForPage: aPage.
	targetCommand parentCommand: self.
]

{ #category : #accessing }
LeUndoContentCommand >> label [
	^ 'Redo'
]

{ #category : #accessing }
LeUndoContentCommand >> traceEventTypeForRecording [
	^ LeContentUndoTraceEvent
]
