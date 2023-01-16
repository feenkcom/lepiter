Class {
	#name : #LeRedoContentCommand,
	#superclass : #LeRestoreContentCommand,
	#category : #'Lepiter-History-Commands'
}

{ #category : #'execution - utils' }
LeRedoContentCommand >> createUndoCommand [
	^ LeUndoContentCommand new
		targetContent: self targetPage;
		traceEvent: self traceEvent
]

{ #category : #printing }
LeRedoContentCommand >> descriptionOn: aStream [
	aStream 
		<< 'redo: ';
		print: self targetCommand description
]

{ #category : #initialization }
LeRedoContentCommand >> initializeForTraceEvent: anEvent inPage: aPage [
	super initializeForTraceEvent: anEvent inPage: aPage.
	
	targetCommand := anEvent mainCommandSpecification 
		createCommandForPage: aPage.
	targetCommand parentCommand: self.
]

{ #category : #accessing }
LeRedoContentCommand >> label [
	^ 'Undo'
]

{ #category : #accessing }
LeRedoContentCommand >> traceEventTypeForRecording [
	^ LeContentRedoTraceEvent
]
