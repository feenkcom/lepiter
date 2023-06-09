Class {
	#name : #LeExportAssembledInadequateOutputResourceState,
	#superclass : #Object,
	#traits : 'TLeExportResourceState',
	#classTraits : 'TLeExportResourceState classTrait',
	#instVars : [
		'exception',
		'duration'
	],
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
LeExportAssembledInadequateOutputResourceState >> color [
	^ BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
LeExportAssembledInadequateOutputResourceState >> duration [
	^ duration
]

{ #category : #accessing }
LeExportAssembledInadequateOutputResourceState >> duration: anObject [
	duration := anObject
]

{ #category : #accessing }
LeExportAssembledInadequateOutputResourceState >> exception [
	^ exception
]

{ #category : #accessing }
LeExportAssembledInadequateOutputResourceState >> exception: anObject [
	exception := anObject
]

{ #category : #testing }
LeExportAssembledInadequateOutputResourceState >> isAssembledState [
	"Return true if the resource was assembled (and therefore it nows the assembling duration)"

	^ true
]

{ #category : #testing }
LeExportAssembledInadequateOutputResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ true
]

{ #category : #testing }
LeExportAssembledInadequateOutputResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ true
]

{ #category : #accessing }
LeExportAssembledInadequateOutputResourceState >> minutes [
	^ self duration asMinutes
]

{ #category : #accessing }
LeExportAssembledInadequateOutputResourceState >> name [
	^ 'inadequate output ({1}, {2})' format: {exception. self duration gtShortPrintString}
]
