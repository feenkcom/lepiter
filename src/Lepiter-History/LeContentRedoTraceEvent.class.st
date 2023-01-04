Class {
	#name : #LeContentRedoTraceEvent,
	#superclass : #LeContentTraceRestoreEvent,
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentRedoTraceEvent >> label [
	^ 'Redo'
]

{ #category : #accessing }
LeContentRedoTraceEvent >> mainCommandSpecification [
	^ self targetEvent mainCommandSpecification
]

{ #category : #accessing }
LeContentRedoTraceEvent >> undoCommandSpecification [
	^ self targetEvent undoCommandSpecification
]
