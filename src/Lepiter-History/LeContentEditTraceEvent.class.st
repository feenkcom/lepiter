Class {
	#name : #LeContentEditTraceEvent,
	#superclass : #LeContentTraceEvent,
	#instVars : [
		'mainCommandSpecification',
		'undoCommandSpecification'
	],
	#category : #'Lepiter-History-Storage'
}

{ #category : #accessing }
LeContentEditTraceEvent >> label [
	^ 'Edit'
]

{ #category : #accessing }
LeContentEditTraceEvent >> mainCommandSpecification [

	^ mainCommandSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> mainCommandSpecification: aCommandSpecification [

	mainCommandSpecification := aCommandSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> undoCommandSpecification [

	^ undoCommandSpecification
]

{ #category : #accessing }
LeContentEditTraceEvent >> undoCommandSpecification: aCommandSpecification [

	undoCommandSpecification := aCommandSpecification
]
