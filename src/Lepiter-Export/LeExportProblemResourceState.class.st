Class {
	#name : #LeExportProblemResourceState,
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
LeExportProblemResourceState >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #testing }
LeExportProblemResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ true
]

{ #category : #testing }
LeExportProblemResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ false
]

{ #category : #accessing }
LeExportProblemResourceState >> message [
	<return: #String>
	^ message
]

{ #category : #accessing }
LeExportProblemResourceState >> message: aString [
	message := aString
]

{ #category : #accessing }
LeExportProblemResourceState >> name [
	^ 'problem ({1})' format: {self message}
]
