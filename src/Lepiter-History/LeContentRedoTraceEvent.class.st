Class {
	#name : #LeContentRedoTraceEvent,
	#superclass : #LeContentTraceRestoreEvent,
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentRedoTraceEvent >> commandSpecification [
	^ self targetEvent commandSpecification
]

{ #category : #accessing }
LeContentRedoTraceEvent >> label [
	^ 'Redo'
]

{ #category : #accessing }
LeContentRedoTraceEvent >> undoSpecification [
	^ self targetEvent undoSpecification
]
