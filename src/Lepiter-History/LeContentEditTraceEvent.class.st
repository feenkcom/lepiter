Class {
	#name : #LeContentEditTraceEvent,
	#superclass : #Object,
	#instVars : [
		'commandSpecification',
		'undoSpecification'
	],
	#category : #'Lepiter-History-Store'
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
LeContentEditTraceEvent >> undoSpecification [

	^ undoSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> undoSpecification: anObject [

	undoSpecification := anObject
]
