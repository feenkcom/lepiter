Class {
	#name : #LeContentUndoTraceEvent,
	#superclass : #LeContentTraceRestoreEvent,
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentUndoTraceEvent >> label [
	^ 'Undo'
]

{ #category : #accessing }
LeContentUndoTraceEvent >> mainCommandSpecification [
	^ self targetEvent undoCommandSpecification
]

{ #category : #accessing }
LeContentUndoTraceEvent >> undoCommandSpecification [
	^ self targetEvent mainCommandSpecification
]
