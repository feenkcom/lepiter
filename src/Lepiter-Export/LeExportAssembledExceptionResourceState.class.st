Class {
	#name : #LeExportAssembledExceptionResourceState,
	#superclass : #Object,
	#traits : 'TLeExportResourceState',
	#classTraits : 'TLeExportResourceState classTrait',
	#instVars : [
		'duration',
		'exception'
	],
	#category : #'Lepiter-Export-Resources - State'
}

{ #category : #accessing }
LeExportAssembledExceptionResourceState >> color [
	^ BrGlamorousColors errorBackgroundColor
]

{ #category : #accessing }
LeExportAssembledExceptionResourceState >> duration [
	^ duration
]

{ #category : #accessing }
LeExportAssembledExceptionResourceState >> duration: anObject [
	duration := anObject
]

{ #category : #accessing }
LeExportAssembledExceptionResourceState >> exception [
	^ exception
]

{ #category : #accessing }
LeExportAssembledExceptionResourceState >> exception: anObject [
	exception := anObject
]

{ #category : #testing }
LeExportAssembledExceptionResourceState >> isAssembledState [
	"Return true if the resource was assembled (and therefore it nows the assembling duration)"

	^ true
]

{ #category : #testing }
LeExportAssembledExceptionResourceState >> isFailure [
	"Return true if a resource could not be assembled"

	^ true
]

{ #category : #testing }
LeExportAssembledExceptionResourceState >> isReady [
	"Return true if the resource is ready, e.g., an element screenshot is stored in the resource file"

	^ false
]

{ #category : #accessing }
LeExportAssembledExceptionResourceState >> minutes [
	^ self duration asMinutes
]

{ #category : #accessing }
LeExportAssembledExceptionResourceState >> name [
	^ 'assembling problem ({1}, {2})' format: { exception. self duration gtShortPrintString}
]
