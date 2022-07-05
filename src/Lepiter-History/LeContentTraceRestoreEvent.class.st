Class {
	#name : #LeContentTraceRestoreEvent,
	#superclass : #LeContentTraceEvent,
	#instVars : [
		'targetEvent'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #testing }
LeContentTraceRestoreEvent class >> isAbstract [ 
	^ self name = #LeContentTraceRestoreEvent
]

{ #category : #accessing }
LeContentTraceRestoreEvent >> targetEvent [

	^ targetEvent
]

{ #category : #accessing }
LeContentTraceRestoreEvent >> targetEvent: anEvent [

	targetEvent := anEvent
]
