Class {
	#name : #LeContentEditTraceEvent,
	#superclass : #LeContentTraceEvent,
	#instVars : [
		'commandSpecification',
		'undoSpecification'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentEditTraceEvent >> commandSpecification [

	^ commandSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> commandSpecification: anObject [

	commandSpecification := anObject
]

{ #category : #accessing }
LeContentEditTraceEvent >> label [
	^ 'Edit'
]

{ #category : #accessing }
LeContentEditTraceEvent >> undoSpecification [

	^ undoSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> undoSpecification: anObject [

	undoSpecification := anObject
]
