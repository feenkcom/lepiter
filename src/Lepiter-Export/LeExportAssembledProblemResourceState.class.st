Class {
	#name : #LeExportAssembledProblemResourceState,
	#superclass : #Object,
	#traits : 'TLeExportResourceState',
	#classTraits : 'TLeExportResourceState classTrait',
	#instVars : [
		'message',
		'duration'
	],
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
LeExportAssembledProblemResourceState >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportAssembledProblemResourceState >> duration [
	^ duration
]

{ #category : #accessing }
LeExportAssembledProblemResourceState >> duration: anObject [
	duration := anObject
]

{ #category : #testing }
LeExportAssembledProblemResourceState >> isAssembledState [
	"Return true if the resource was assembled (and therefore it nows the assembling duration)"

	^ true
]

{ #category : #testing }
LeExportAssembledProblemResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ true
]

{ #category : #testing }
LeExportAssembledProblemResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ false
]

{ #category : #accessing }
LeExportAssembledProblemResourceState >> message [
	<return: #String>
	^ message
]

{ #category : #accessing }
LeExportAssembledProblemResourceState >> message: aString [
	message := aString
]

{ #category : #accessing }
LeExportAssembledProblemResourceState >> minutes [
	^ self duration asMinutes
]

{ #category : #accessing }
LeExportAssembledProblemResourceState >> name [
	^ 'problem ({1}, {2})' format: {self message. self duration gtShortPrintString}
]
