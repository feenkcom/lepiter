Class {
	#name : #LeContentUndoTraceEvent,
	#superclass : #LeContentTraceRestoreEvent,
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentUndoTraceEvent >> commandSpecification [
	^ self targetEvent undoSpecification
]

{ #category : #accessing }
LeContentUndoTraceEvent >> label [
	^ 'Undo'
]

{ #category : #accessing }
LeContentUndoTraceEvent >> undoSpecification [
	^ self targetEvent commandSpecification
]
